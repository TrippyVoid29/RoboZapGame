/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module top_uart_tb;
    //inputs -> logic/reg    outputs -> wires
    logic clk;
    logic rst;
    logic tx_start, rx_in;
    logic [7:0] tx_in;

    wire tx_out; //signal transmitted to second basys3
    wire [7:0] rx_out, dout; //signal received from the other basys3


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

top_uart dut(
    .clk(clk),
    .rst(rst),
    .rx_in(rx_in),
    .rx_out(rx_out),
    .tx_in(tx_in),
    .tx_out(tx_out),
    .tx_start(tx_start),
    .dout(dout)
);

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
    end
endtask

    integer rx_counter;

task get_rx(input logic [7:0] data);
    begin
        rx_in = 1'b0;
        #10
        for (rx_counter = 0; rx_counter < 8; rx_counter = rx_counter + 1)
        begin
            rx_in = data[rx_counter];
            #10;
        end
        rx_in = 1'b1;
        #10;
    end
endtask
 
task send_tx_in(logic [7:0] data);
    begin
        tx_in = data;
        #10 tx_start = 1'b1;
        #10 tx_start = 1'b0;
    end
endtask


initial begin

    reset();

    #100 get_rx(8'b10001100);
    #100 send_tx_in(8'b10101100);
    #100


    //add code here

    $finish;
end

 endmodule