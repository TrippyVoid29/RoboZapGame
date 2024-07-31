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

wire clk_in, clk_fb, clk_ss, clk_out;
wire locked;
wire pclk;
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

IBUF clk_ibuf (
    .I(clk),
    .O(clk_in)
);

MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000)
) clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clk_fb),
    .CLKFBOUTB(),
    .CLKFBIN(clk_fb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
);

BUFH clk_out_bufh (
    .I(clk_out),
    .O(clk_ss)
);

always_ff @(posedge clk_ss)
    safe_start <= {safe_start[6:0],locked};

BUFGCE #(
    .SIM_DEVICE("7SERIES")
) clk_out_bufgce (
    .I(clk_out),
    .CE(safe_start[7]),
    .O(pclk)
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
    .clk,
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
