/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module top_uart_tx_tb;
    //inputs -> logic/reg    outputs -> wires
    logic clk, uclk;
    logic rst;
    logic tx_start;
    logic [7:0] tx_in;

    wire tx_out, tx_done_tick; //signal transmitted to second basys3


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

uart_tx dut_tx(
    .clk(clk),
    .reset(rst),
    .din(tx_in),
    .s_tick(uclk),
    .tx_start(tx_start),
    
    .tx(tx_out),
    .tx_done_tick(tx_done_tick)
);

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
        tx_start = 1'b1;
    end
endtask
 
task send_tx_in(logic [7:0] data);
    begin
        tx_in = data;
        //#100 tx_start = 1'b1;
        //#100 tx_start = 1'b0;
    end
endtask


initial begin

    reset();

    send_tx_in(8'b11110000);
    #90000 //1
    send_tx_in(8'b10101010);
    #90000
    send_tx_in(8'b11010011);
    #90000
    //add code here

    $finish;
end

 endmodule