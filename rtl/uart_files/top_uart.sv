`timescale 1 ns / 1 ps

module top_uart (
    input  logic clk,
    input  logic rst,
    input  logic rx,
    input  logic tx_start,
    input  logic [7:0] tx_in,

    output  logic tx,   
    output  logic tx_done,
    output  logic [7:0] uart_rx_out
);


logic rx_done_tick;
logic [7:0] dout;


logic tx_bnt;


wire uclk;

uart_clock u_uart_clock(

    .clk, 
    .rst,
    .uclk(uclk)
);

uart_rx u_uart_rx
    (
     .clk, 
     .reset(rst),

     .rx, 
     .s_tick(uclk),

     .rx_done_tick,
     .dout
    );

uart_rec u_uart_rec
    (
     .clk, 
     .rst(rst),

     .dout,
     .rx_done_tick,

     .uart_rx_out(uart_rx_out)
    );

uart_tx u_uart_tx
    (
     .clk, 
     .reset(rst),

     .tx_start(tx_start),
     .din(tx_in),
     .s_tick(uclk),

     .tx(tx),
     .tx_done_tick(tx_done)
    );



endmodule
