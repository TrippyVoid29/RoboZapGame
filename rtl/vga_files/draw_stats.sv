/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_stats (

    input  logic clk,
    input  logic rst,
    vga_if.out vga_stats_out,
    vga_if.in vga_stats_in
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vga_stats_out.vcount <= '0;
        vga_stats_out.vsync  <= '0;
        vga_stats_out.vblnk  <= '0;
        vga_stats_out.hcount <= '0;
        vga_stats_out.hsync  <= '0;
        vga_stats_out.hblnk  <= '0;
        vga_stats_out.rgb    <= '0;
    end else begin
        vga_stats_out.vcount <= vga_stats_in.vcount;
        vga_stats_out.vsync  <= vga_stats_in.vsync;
        vga_stats_out.vblnk  <= vga_stats_in.vblnk;
        vga_stats_out.hcount <= vga_stats_in.hcount;
        vga_stats_out.hsync  <= vga_stats_in.hsync;
        vga_stats_out.hblnk  <= vga_stats_in.hblnk;
        vga_stats_out.rgb    <= rgb_nxt;
        if(rgb_nxt) begin
            vga_stats_out.rgb    <= rgb_nxt;
        end else begin
            vga_stats_out.rgb    <= vga_stats_in.rgb;
        end
    end
end

always_comb begin : bg_comb_blk
        //circle
        if ((400 - vga_stats_in.hcount)*(400 - vga_stats_in.hcount) + (400 - vga_stats_in.vcount)*(400 - vga_stats_in.vcount) <= 900)
            rgb_nxt = 12'h5_1_5;
        else if ((400 - vga_stats_in.hcount)*(400 - vga_stats_in.hcount) + (400 - vga_stats_in.vcount)*(400 - vga_stats_in.vcount) <= 1600)
            rgb_nxt = 12'h1_7_5;
        else
            rgb_nxt = 0; 

    end

endmodule
