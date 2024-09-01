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
logic buttonD, buttonL, buttonR, buttonU;
logic current_player;
logic [7:0] lever_left;
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
    .rst

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

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
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


/**
 * Main test
 */

initial begin
    reset();
    #1000 press_lever(RIGHT);
    #1000 press_lever(LEFT);
    #1000

    $finish;
end

endmodule
