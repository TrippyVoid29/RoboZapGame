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
    input  wire JA1,

    output wire JA2,
    output wire Vsync,
    output wire Hsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    inout  wire PS2Clk,
    inout  wire PS2Data
);


/**
 * Local variables and signals
 */

//wire locked;
wire clk65;
wire clk100;

wire LMB, RMB;
//wire pclk_mirror;


(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
//logic [7:0] safe_start = 0;
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
  .clk65MHz(clk65),
  // Status and control signals               
  .locked(),
 // Clock in ports
  .clk(clk)
  );



/**
 *  Project functional top module
 */

 wire player_selected;
 wire [1:0] player0_health, player1_health, who_won; 
 wire [2:0] position;
 wire [1:0] states;
 wire [7:0]  uart_rx_wire, uart_tx_wire, lever_left;

top_vga u_top_vga (
    .clk(clk65),
    .rst(buttonC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync),
    .player_selected,
    .lever_left,
    .player0_health,
    .player1_health,
    .position,
    .states,
    .who_won
);

top_logic u_top_logic (
    .clk(clk65),
    .rst(buttonC),
    .buttonD,
    .buttonL,
    .buttonR,
    .buttonU,
    .position,
    .uart_in(uart_rx_wire),
    .tx_done(tx_done_wire),
    .mouse_left(LMB),
    .mouse_right(RMB),

    .turn(),
    .winner(who_won),
    .player0_health,
    .player1_health,
    .lever_left,
    .state_output(states),
    .uart_out(uart_tx_wire),
    .tx_start(tx_start_wire),
    .player_selected
);

top_uart u_top_uart(
    .clk(clk65),
    .rst(buttonC),
    .rx(JA1),
    .tx_start(tx_start_wire),
    .tx_in(uart_tx_wire),

    .tx(JA2),   
    .tx_done(tx_done_wire),
    .uart_rx_out(uart_rx_wire)
);

MouseCtl u_MouseCtl (
    .clk(clk65),
    .rst(buttonC),

    .ps2_data(PS2Data),
    .ps2_clk(PS2Clk),
    .left(LMB),
    .right(RMB)
);
endmodule
