`timescale 1 ns / 1 ps

module top_uart (
    input  logic clk,
    input  logic rst,
    input logic btnU,
    input  logic rx,
    input  logic loopback_enable,
    output  logic tx,   
    output  logic rx_monitor,
    output  logic tx_monitor,

    output  logic [6:0]seg,
    output  logic dp,
    output  logic [3:0] an
);


logic rx_done_tick;
logic [7:0] dout;
logic [3:0] h1 ,l1 ,h2 ,l2;
logic [7:0] tx_in;


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

wire [7:0] sseg;

display u_display(
    .clk, 
    .reset(rst),
    .hex3(h2), 
    .hex2(l2), 
    .hex1(h1), 
    .hex0(l1),  // hex digits
    .dp_in(0),             // 4 decimal points
    .an,  // enable 1-out-of-4 asserted low
    .sseg(sseg) // led segments
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
     .dout
    );

uart_tx u_uart_tx
    (
     .clk, 
     .reset(rst),
     .tx(tx_bnt), 
     .din(tx_in),
     .s_tick(uclk),
     .tx_start(btnU)
    );

assign tx_in[7:4] = h1;
assign tx_in[3:0] = l1;

uart_rec u_uart_rec
    (
     .clk, 
     .rst(rst),
     .dout,
     .rx_done_tick,
     .outH(h1),
     .outL(l1),
     .outH2(h2),
     .outL2(l2)

    );


assign tx = tx_loop & tx_bnt;

genvar n;
generate
    for ( n=0; n<7; n=n+1 ) begin 
        assign seg[n] = sseg[6-n];
    end
endgenerate

assign dp = sseg[7];



endmodule
