`timescale 1 ns / 1 ps

module top_uart (
    input  logic clk,
    input  logic rst,
    input  logic tx_start,
    input  logic rx_in,
    input  logic [7:0] tx_in,

    output  logic tx_out,   
    output  logic [7:0] rx_out
);

wire uclk;
logic rx_done_tick;
logic [7:0] rx_read;

uart_clock u_uart_clock
    (

    .clk, 
    .rst,
    .uclk(uclk)
    );

uart_rx u_uart_rx
    (
     .clk, 
     .reset(rst),
     .rx(rx_in), 
     .s_tick(uclk),
     .rx_done_tick(rx_done_tick),
     .dout(rx_read)
    );

uart_rec u_uart_rec
    (
    .clk,
    .rst,
    .rx_done_tick(rx_done_tick),
    .din(rx_read),
    .dout(rx_out)

    );

uart_tx u_uart_tx
    (
     .clk, 
     .reset(rst),
     .tx(tx_out), 
     .din(tx_in),
     .s_tick(uclk),
     .tx_start,
     .tx_done_tick()
    );

endmodule
