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
    input  wire buttonC, buttonU, buttonD, buttonL, buttonR,
    input wire RsRx,

    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire RsTx,
    output wire JA1
);


/**
 * Local variables and signals
 */

wire locked;
wire pclk;
wire clk100;
wire pclk_mirror;


(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
logic [7:0] safe_start = 0;
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */

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

 wire current_player;
 wire [1:0] player0_health, player1_health, who_won; 
 wire [2:0] position, states;
 wire [7:0] lever_used;
 logic tx_start;

top_vga u_top_vga (
    .clk(pclk),
    .rst(buttonC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .current_player,
    .lever_used_in(lever_used),
    .player0_health,
    .player1_health,
    .position,
    .states,
    .who_won
);

wire [7:0] uart_tx, uart_rx;

top_uart u_top_uart (
    .clk(clk100),
    .rst(buttonC),
    .rx_in(RsRx),
    .tx_out(RsTx),
    .tx_in(uart_tx),   
    .rx_out(uart_rx),
    .tx_start(tx_start)
);

top_logic u_top_logic (
    .clk(clk100),
    .data_output(uart_tx), //trasmitter uart
    .rst(buttonC),
    .uart_rx(uart_rx), //receiver uart
    .who_won,
    .buttonC,
    .buttonD,
    .buttonL,
    .buttonR,
    .buttonU,
    .current_player,
    .lever_used_out(lever_used),
    .player0_health,
    .player1_health,
    .position,
    .state_output(states),
    .tx_start(tx_start)
);

endmodule
