/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module top_uart_rx_tb;
    //inputs -> logic/reg    outputs -> wires
    logic clk, uclk;
    logic rst;
    logic rx_in, rx_done_tick;


    logic [7:0] dout, dout_logic; 
    localparam CLK_PERIOD_100M = 10;

initial begin
    clk = 0;
    forever #(CLK_PERIOD_100M/2) clk = ~clk;
end

uart_clock dut_u_uart_clock(
    .clk(clk),
    .rst(rst),
    .uclk(uclk)
);

uart_rx dut_rx(
    .clk(clk),
    .dout(dout),
    .reset(rst),
    .rx(rx_in),
    .rx_done_tick(rx_done_tick),
    .s_tick(uclk)

);

uart_rec dut_uart_rec(
    .clk,
    .rst,
    .din(dout),
    .dout(dout_logic),
    .rx_done_tick(rx_done_tick)

);

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
    end
endtask

    logic [3:0] rx_counter;

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


initial begin

    reset();
    rx_in = 1'b1;

    #8800 get_rx(8'b10001100);
    #8800 get_rx(8'b00000000);
    #8800 get_rx(8'b11110000);
    #104000


    //add code here

    $finish;
end

 endmodule