/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * VGA top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,

    input  logic [1:0] states,
    input  logic [2:0] position,
    input  logic [7:0] lever_left_in,
    input  logic current_player,
    input  logic [1:0] player0_health,
    input  logic [1:0] player1_health,
    input  logic [1:0] who_won,

    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

// VGA signals from timing
vga_if vga_tim();
vga_if vga_bg();
vga_if vga_stats();
vga_if vga_highlight();
vga_if vga_lever();
vga_if vga_start_bg();

/**
 * Signals assignments
 */

assign vs = vga_start_bg.vsync;
assign hs = vga_start_bg.hsync;
assign {r,g,b} = vga_start_bg.rgb;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,

    .vga_tim(vga_tim)
);

draw_bg u_draw_bg (
    .clk,
    .rst,
    .position,
    .current_player,

    .vga_bg_in(vga_tim),
    .vga_bg_out(vga_bg)
);

draw_stats u_draw_stats (
    .clk,
    .rst,
    .current_player,
    .player0_health,
    .player1_health,

    .vga_stats_in(vga_bg),
    .vga_stats_out(vga_stats)
);

draw_highlight u_draw_highlight (
    .clk,
    .rst,

    .vga_highlight_in(vga_stats),
    .vga_highlight_out(vga_highlight)
);

draw_lever u_draw_lever (
    .clk,
    .rst,
    .lever_left_in,

    .vga_lever_in(vga_highlight),
    .vga_lever_out(vga_lever)
);

draw_start_bg u_draw_start_bg (
    .clk,
    .rst,
    .states,
    .who_won,
    .current_player,

    .vga_start_bg_in(vga_lever),
    .vga_start_bg_out(vga_start_bg)
);

endmodule
