/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: �?ukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Module drawing background dependant on player_selected.
 */

`timescale 1 ns / 1 ps

module draw_bg (

    input  logic clk,
    input  logic rst,
    input logic [2:0]  position,
    input logic player_selected,
    input logic [7:0] lever_left_tim,

    vga_if.out vga_bg_out,
    vga_if.in vga_bg_in,
    output logic [7:0] lever_left_bg
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
        vga_bg_out.position <= '0;
        lever_left_bg <= 8'b00000000;
    end else begin
        vga_bg_out.vcount <= vga_bg_in.vcount;
        vga_bg_out.vsync  <= vga_bg_in.vsync;
        vga_bg_out.vblnk  <= vga_bg_in.vblnk;
        vga_bg_out.hcount <= vga_bg_in.hcount;
        vga_bg_out.hsync  <= vga_bg_in.hsync;
        vga_bg_out.hblnk  <= vga_bg_in.hblnk;
        vga_bg_out.rgb    <= rgb_nxt;
        vga_bg_out.position <= position;
        lever_left_bg <= lever_left_tim;
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
        else if (vga_bg_in.hcount >= 175 && vga_bg_in.hcount <= 800 && 
                vga_bg_in.vcount >= 575 && vga_bg_in.vcount <= 675)
            begin
                rgb_nxt = 12'h4_1_0;
            end

// --------------------- ROBOT HEAD ------------------------
        else if (vga_bg_in.hcount >= 565 && vga_bg_in.hcount <= 595 && vga_bg_in.vcount >= 265 && vga_bg_in.vcount <= 300)
            begin
                rgb_nxt = 12'h5_5_2;
            end
        else if (vga_bg_in.hcount >= 485 && vga_bg_in.hcount <= 515 && vga_bg_in.vcount >= 265 && vga_bg_in.vcount <= 300)
            begin
                rgb_nxt = 12'h5_5_2;
            end
        else if (vga_bg_in.hcount >= 405 && vga_bg_in.hcount <= 435 && vga_bg_in.vcount >= 265 && vga_bg_in.vcount <= 300)
            begin
                rgb_nxt = 12'h5_5_2;
            end
        else if (vga_bg_in.hcount >= 545 && vga_bg_in.hcount <= 565 && vga_bg_in.vcount >= 335 && vga_bg_in.vcount <= 345)
            begin
                rgb_nxt = 12'h5_2_2;
            end
        else if (vga_bg_in.hcount >= 435 && vga_bg_in.hcount <= 455 && vga_bg_in.vcount >= 335 && vga_bg_in.vcount <= 345)
            begin
                rgb_nxt = 12'h5_2_2;
            end
        //stripes
        else if (vga_bg_in.hcount >= 455 && vga_bg_in.hcount <= 460 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 465 && vga_bg_in.hcount <= 470 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 475 && vga_bg_in.hcount <= 480 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 485 && vga_bg_in.hcount <= 490 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 495 && vga_bg_in.hcount <= 500 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 505 && vga_bg_in.hcount <= 510 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 515 && vga_bg_in.hcount <= 520 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 525 && vga_bg_in.hcount <= 530 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 535 && vga_bg_in.hcount <= 540 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else if (vga_bg_in.hcount >= 545 && vga_bg_in.hcount <= 550 && vga_bg_in.vcount >= 402 && vga_bg_in.vcount <= 418)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        //stripes_end
        else if (vga_bg_in.hcount >= 430 && vga_bg_in.hcount <= 460 && vga_bg_in.vcount >= 330 && vga_bg_in.vcount <= 350)
            begin
                if (player_selected == 1'b0)
                rgb_nxt = 12'h2_2_4;
                else if (player_selected == 1'b1)
                rgb_nxt = 12'h2_4_2;
            end
        else if (vga_bg_in.hcount >= 540 && vga_bg_in.hcount <= 570 && vga_bg_in.vcount >= 330 && vga_bg_in.vcount <= 350)
            begin
                if (player_selected == 1'b0)
                    rgb_nxt = 12'h2_2_4;
                else if (player_selected == 1'b1)
                    rgb_nxt = 12'h2_4_2;
            end
        else if (vga_bg_in.hcount >= 450 && vga_bg_in.hcount <= 555 && vga_bg_in.vcount >= 400 && vga_bg_in.vcount <= 420)
            begin
                if (player_selected == 1'b0)
                rgb_nxt = 12'h2_2_4;
                else if (player_selected == 1'b1)
                rgb_nxt = 12'h2_4_2;
            end
        else if (vga_bg_in.hcount >= 400 && vga_bg_in.hcount <= 600 && vga_bg_in.vcount >= 300 && vga_bg_in.vcount <= 450)
            begin
                rgb_nxt = 12'h4_4_4;
            end
        else if (vga_bg_in.hcount >= 390 && vga_bg_in.hcount <= 610 && vga_bg_in.vcount >= 295 && vga_bg_in.vcount <= 460)
            begin
                if (player_selected == 1'b0)
                rgb_nxt = 12'h2_2_4;
                else if (player_selected == 1'b1)
                rgb_nxt = 12'h2_4_2;
            end
        //chasis
        else if (vga_bg_in.hcount >= 400 && vga_bg_in.hcount <= 600 && vga_bg_in.vcount >= 500 && vga_bg_in.vcount <= 510)
            begin
                rgb_nxt = 12'h3_3_3;
            end
        else if (vga_bg_in.hcount >= 390 && vga_bg_in.hcount <= 610 && vga_bg_in.vcount >= 490 && vga_bg_in.vcount <= 590)
            begin
                rgb_nxt = 12'h4_4_4;
            end
        else if (vga_bg_in.hcount >= 380 && vga_bg_in.hcount <= 620 && vga_bg_in.vcount >= 480 && vga_bg_in.vcount <= 600)
            begin
                if (player_selected == 1'b0)
                rgb_nxt = 12'h2_2_4;
                else if (player_selected == 1'b1)
                rgb_nxt = 12'h2_4_2;
            end
        //connector
        else if (vga_bg_in.hcount >= 430 && vga_bg_in.hcount <= 570 && vga_bg_in.vcount >= 410 && vga_bg_in.vcount <= 620)
            begin
                rgb_nxt = 12'h1_1_1;
            end
        else                          
            rgb_nxt = 12'h0_0_2;           // - fill with drak blue - background_color
    end
end

endmodule
