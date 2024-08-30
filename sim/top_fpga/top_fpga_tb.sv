/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for top_fpga.
 * Thanks to the tiff_writer module, an expected image
 * produced by the project is exported to a tif file.
 * Since the vs signal is connected to the go input of
 * the tiff_writer, the first (top-left) pixel of the tif
 * will not correspond to the vga project (0,0) pixel.
 * The active image (not blanked space) in the tif file
 * will be shifted down by the number of lines equal to
 * the difference between VER_SYNC_START and VER_TOTAL_TIME.
 */

`timescale 1 ns / 1 ps

module top_fpga_tb;

/**
 *  Local parameters
 */

localparam CLK_PERIOD = 10;     // 100 MHz


/**
 * Local variables and signals
 */

logic clk, rst;
wire clk100, clk40;
logic buttonD, buttonL, buttonR, buttonU, rx_in;
wire tx_out;
logic tx_start, current_player;
logic [7:0] tx_conn, rx_logic_in, lever_left;
wire [1:0] player0_health, player1_health, who_won;
wire [2:0] position, states;



/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


clk_wiz_0_clk_wiz clk_wizard(
    .clk,
    .clk100MHz(clk100),
    .clk40MHz(clk40)
);

/**
 * Submodules instances
 */
 
top_logic top_logic_dut(
    .clk(clk100),
    .rst,
    .buttonD(buttonD),
    .buttonL(buttonL),
    .buttonR(buttonR),
    .buttonU(buttonU),
    .uart_rx(rx_logic_in),

    .current_player(current_player),
    .data_output(tx_conn),
    .lever_left_out(lever_left),
    .player0_health,
    .player1_health,
    .position(position),
    .state_output(states),
    .tx_start(tx_start),
    .who_won
);


top_vga top_vga_dut(
    .clk(clk40),
    .rst,
    .current_player(current_player),
    .lever_left_in(lever_left),
    .player0_health,
    .player1_health,
    .position(position),
    .states(states),
    .who_won
);

top_uart top_uart_dut(
    .clk(clk100),
    .rst,
    .rx_in(rx_in),
    .tx_start(tx_start),
    .tx_in(tx_conn),

    .rx_out(rx_logic_in),
    .tx_out(tx_out)
);

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
        rx_in = 1'b1;
    end
endtask

localparam [1:0]
UP = 2'b00,
LEFT = 2'b10,
RIGHT = 2'b01,
DOWN = 2'b11;

task press_lever(input [1:0] direction);
    begin
    if(direction == LEFT) begin
        buttonL = 1'b1;
        #500 buttonL = 1'b0;
        #20;
    end else if (direction == RIGHT) begin
        buttonR = 1'b1;
        #500 buttonR = 1'b0;
        #20;
    end else if (direction == UP) begin
        buttonU = 1'b1;
        #500 buttonU = 1'b0;
        #20;
    end else if (direction == DOWN) begin
        buttonD = 1'b1;
        #500 buttonD = 1'b0;
        #20;
    end 
    end
endtask

    logic [2:0] rx_counter;

task get_rx(input logic [7:0] data);
    begin
        rx_in = 1'b0;
        #8800
        for (rx_counter = 0; rx_counter < 8; rx_counter = rx_counter + 1)
        begin
            rx_in = data[rx_counter];
            #8800;
        end
        rx_in = 1'b1;
        #8800;
    end
endtask

/**
 * Main test
 */

initial begin
    reset();
    #10000 press_lever(RIGHT);
    #10000 press_lever(LEFT);
    #10000 get_rx(8'b11000000);
    #10000 get_rx(8'b00000000);
    #10000

    $finish;
end

endmodule
