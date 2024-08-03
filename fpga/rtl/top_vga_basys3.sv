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
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

`timescale 1 ns / 1 ps

module top_vga_basys3 (
    input  wire clk,
    input  wire btnC, btnU,
    input  wire sw1,
    input  wire RsRx,
    output wire RsTx,
    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire JA1,
    output wire JA2
);


/**
 * Local variables and signals
 */

wire locked;
wire pclk;
wire clk100;
wire pclk_mirror;

wire rxmonitor;
wire txmonitor;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */

 assign JA1 = rxmonitor;
 assign JA2 = txmonitor;

/**
 * FPGA submodules placement
 */


clk_wiz_0_clk_wiz u_clk_wiz_0_clk_wiz (
  // Clock out ports  
  .clk100MHz(clk100),
  .clk40MHz(pclk),
  // Status and control signals               
  .locked(locked),
 // Clock in ports
  .clk(clk)
  );

// Mirror pclk on a pin for use by the testbench;
// not functionally required for this design to work.

ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);


/**
 *  Project functional top module
 */

top_vga u_top_vga (
    .clk(pclk),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync)
);

top_uart u_top_uart (
    .clk(clk100),
    .rst(btnC),
    .btnU,
    .rx(RsRx),
    .loopback_enable(sw1),
    //.tx_in,
    .tx(RsTx),   
    .rx_monitor(rxmonitor),
    .tx_monitor(txmonitor)
    //.tx_done_tick,
    //.rx_out,
    //.rx_done_tick
);

endmodule
