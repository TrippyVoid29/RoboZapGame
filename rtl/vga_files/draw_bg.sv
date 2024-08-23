/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (

    input  logic clk,
    input  logic rst,
    vga_if.out vga_bg_out,
    vga_if.in vga_bg_in
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
        vga_bg_out.vcount <= '0;
        vga_bg_out.vsync  <= '0;
        vga_bg_out.vblnk  <= '0;
        vga_bg_out.hcount <= '0;
        vga_bg_out.hsync  <= '0;
        vga_bg_out.hblnk  <= '0;
        vga_bg_out.rgb    <= '0;
    end else begin
        vga_bg_out.vcount <= vga_bg_in.vcount;
        vga_bg_out.vsync  <= vga_bg_in.vsync;
        vga_bg_out.vblnk  <= vga_bg_in.vblnk;
        vga_bg_out.hcount <= vga_bg_in.hcount;
        vga_bg_out.hsync  <= vga_bg_in.hsync;
        vga_bg_out.hblnk  <= vga_bg_in.hblnk;
        vga_bg_out.rgb    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk

    if (vga_bg_in.vblnk || vga_bg_in.hblnk) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (vga_bg_in.vcount == 0)                     // - top edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.
        else if (vga_bg_in.vcount == VER_PIXELS - 1)   // - bottom edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.
        else if (vga_bg_in.hcount == 0)                // - left edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.
        else if (vga_bg_in.hcount == HOR_PIXELS - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

// --------------------- Table for switches ------------------------
        else if (vga_bg_in.hcount >= 75 && vga_bg_in.hcount <= 700 && 
                vga_bg_in.vcount >= 475 && vga_bg_in.vcount <= 575)
            begin
                rgb_nxt = 12'h4_1_0;
            end

// --------------------- ROBOT HEAD ------------------------
        else if (vga_bg_in.hcount >= 330 && vga_bg_in.hcount <= 360 && vga_bg_in.vcount >= 230 && vga_bg_in.vcount <= 250)
            begin
                rgb_nxt = 12'h2_2_2;
            end
        else if (vga_bg_in.hcount >= 440 && vga_bg_in.hcount <= 470 && vga_bg_in.vcount >= 230 && vga_bg_in.vcount <= 250)
            begin
                rgb_nxt = 12'h2_2_2;
            end
        else if (vga_bg_in.hcount >= 350 && vga_bg_in.hcount <= 450 && vga_bg_in.vcount >= 300 && vga_bg_in.vcount <= 320)
            begin
                rgb_nxt = 12'h2_2_2;
            end
        else if (vga_bg_in.hcount >= 300 && vga_bg_in.hcount <= 500 && vga_bg_in.vcount >= 200 && vga_bg_in.vcount <= 350)
            begin
                rgb_nxt = 12'h4_4_4;
            end

        else                          // The rest of active display pixels:
            rgb_nxt = 12'h0_0_2;           // - fill with gray.
    end
end

endmodule
