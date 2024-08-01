`timescale 1 ns / 1 ps

module top_uart (
    input  logic clk,
    input  logic rst,
    input logic btnU,
    input  logic rx,
    input  logic loopback_enable,
    input  logic [7:0] tx_in,
    output  logic tx,   
    output  logic rx_monitor,
    output  logic tx_monitor,
    output  logic tx_done_tick,
    output  logic [7:0] rx_out,
    output  logic rx_done_tick
);

logic tx_loop, tx_bnt;

uart u_uart(
    .clk,
    .rst,
    .rx,
    .rx_monitor,
    .tx(tx_loop),
    .tx_monitor,
    .loopback_enable
);

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
     .dout(rx_out)
    );

uart_tx u_uart_tx
    (
     .clk, 
     .reset(rst),
     .tx(tx_bnt), 
     .din(tx_in),
     .s_tick(uclk),
     .tx_start(btnU),
     .tx_done_tick(tx_done_tick)
    );


assign tx = tx_loop & tx_bnt;



endmodule
