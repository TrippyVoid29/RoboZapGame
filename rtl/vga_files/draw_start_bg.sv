/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Module for drawing letters and INIT background.
 */

`timescale 1 ns / 1 ps

 module draw_start_bg(

    input  logic clk,
    input  logic rst,
    input  logic [1:0] states,
    input  logic [1:0] who_won,
    input  logic player_selected,

    vga_if.out vga_start_bg_out,
    vga_if.in vga_start_bg_in
 );
 
 import vga_pkg::*;
 
 
 /**
  * Local variables and signals
  */
 
 logic [11:0] rgb_nxt;
 parameter pixel = 5;
 parameter letter_width = 6 * pixel;
 parameter start_posit_x = 100;
 parameter start_posit_y = 285;
 parameter vertical_fix = 260;
 parameter horizontal_fix = 20;
 parameter new_line = pixel * 8;
 
 /*
  * Internal logic
  */
 
 always_ff @(posedge clk) begin : bg_ff_blk
     if (rst) begin
         vga_start_bg_out.vcount <= '0;
         vga_start_bg_out.vsync  <= '0;
         vga_start_bg_out.vblnk  <= '0;
         vga_start_bg_out.hcount <= '0;
         vga_start_bg_out.hsync  <= '0;
         vga_start_bg_out.hblnk  <= '0;
         vga_start_bg_out.rgb    <= '0;
     end else begin
         vga_start_bg_out.vcount <= vga_start_bg_in.vcount;
         vga_start_bg_out.vsync  <= vga_start_bg_in.vsync;
         vga_start_bg_out.vblnk  <= vga_start_bg_in.vblnk;
         vga_start_bg_out.hcount <= vga_start_bg_in.hcount;
         vga_start_bg_out.hsync  <= vga_start_bg_in.hsync;
         vga_start_bg_out.hblnk  <= vga_start_bg_in.hblnk;
         vga_start_bg_out.rgb    <= rgb_nxt;
        
         if(rgb_nxt) begin
            vga_start_bg_out.rgb    <= rgb_nxt;
        end else begin
            vga_start_bg_out.rgb    <= vga_start_bg_in.rgb;
        end
     end
 end
 
always_comb begin : bg_comb_blk

    if (vga_start_bg_in.vblnk || vga_start_bg_in.hblnk) 
    begin
        rgb_nxt = 12'h0_0_0;
    end 
    else 
        begin
// --------------------- BG 1: INIT ------------------------
        if(states == 2'b00)
            begin
            // first letter - P
            if (vga_start_bg_in.hcount >= start_posit_x && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
            else if(vga_start_bg_in.hcount >= start_posit_x && 
                vga_start_bg_in.hcount <= start_posit_x + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + pixel * 4 && 
                vga_start_bg_in.hcount <= start_posit_x + pixel * 5 && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // second letter - R
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel&& 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel&& 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width + 3 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel&& 
                vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 4 * pixel&& 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // next letter - E
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // next letter - S
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 4 * pixel&& 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // next letter - S
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 4 * pixel&& 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // new line
            // next letter - L
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel + new_line&& 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
                
            // next letter - B
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel + new_line&& 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel + new_line)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //space x2
            // letter - P
            if (vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel  && 
                vga_start_bg_in.vcount >= start_posit_y + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + pixel + new_line )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width  && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + pixel * 4 && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel * 5 && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * letter_width + pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel + new_line  )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width  && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel + new_line  && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel + new_line  )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - I
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel + new_line )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel + new_line )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel  && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel  && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel + new_line && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line )
                begin
                    rgb_nxt = 12'h8_8_8;
                end

            //new line
            //letter - R
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y  + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel + new_line * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel + new_line * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 3 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel + new_line * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + 4 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 4 * pixel + new_line * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //letter - B
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + new_line  * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel + new_line * 2&& 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel + new_line * 2 && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel + new_line * 2)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //space x2
            //letter - P
            if (vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel  && 
                vga_start_bg_in.vcount >= start_posit_y + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + pixel + new_line * 2  )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width  && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2  )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + pixel * 4 && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel * 5 && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * letter_width + pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel + new_line * 2   )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width  && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel + new_line * 2   && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel + new_line * 2   )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //letter - O
            if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel + new_line * 2 )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel + new_line * 2 )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel + new_line * 2 )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel + new_line * 2  && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel + new_line * 2 )
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //end
            else
                rgb_nxt = 12'h1_1_1;
        end

//----------------------- BG 2: PLAYER_1 --------------------------

            else if(states == 2'b01)   //player1
            begin
                if(player_selected == 1'b1)
                begin  
                // letter - P
                if (vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + pixel - vertical_fix )
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                else if(vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + pixel * 4 + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + pixel * 5 + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 3 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                // letter - I
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 2 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 3 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel - vertical_fix&& 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel - vertical_fix)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel - vertical_fix&& 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel - vertical_fix)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel - vertical_fix)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else
                    begin
                        rgb_nxt = 12'h0_0_0;
                    end
                end

//----------------------- BG 2: PLAYER_0 --------------------------

                else if(player_selected == 1'b0)//player0
                begin  
                // letter - P
                if (vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + pixel - vertical_fix )
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                else if(vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + pixel * 4 + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + pixel * 5 + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 3 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                // letter - 0
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 0 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 1 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel + horizontal_fix && 
                    vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel + horizontal_fix && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel - vertical_fix && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel - vertical_fix )
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                
                else
                    begin
                        rgb_nxt = 12'h0_0_0;
                    end
                end
            end


// --------------------- BG 3: GAMEEND (Baldur's Gate 3)------------------------

        else if(states == 2'b10) // gameend
                begin
                    // letter - P
                    if (vga_start_bg_in.hcount >= start_posit_x && 
                        vga_start_bg_in.hcount <= start_posit_x + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y && 
                        vga_start_bg_in.vcount <= start_posit_y + pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                    else if(vga_start_bg_in.hcount >= start_posit_x && 
                        vga_start_bg_in.hcount <= start_posit_x + pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + pixel * 4 && 
                        vga_start_bg_in.hcount <= start_posit_x + pixel * 5 && 
                        vga_start_bg_in.vcount >= start_posit_y + pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x && 
                        vga_start_bg_in.hcount <= start_posit_x + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    // letter - W
                    else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 0 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 1 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 1 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 2 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 4 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 2 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 3 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 3 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 4 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + 4 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 5 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    //letter - I
                    else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 2 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 3 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 1 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 1 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    // letter - N
                    else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width && 
                        vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + pixel && 
                        vga_start_bg_in.vcount >= start_posit_y && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 4 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 5 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y && 
                        vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 2 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 2 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 3 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 3 * pixel && 
                        vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                        vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                        vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                        begin
                            rgb_nxt = 12'h8_8_8;
                        end
                    
                    // zero or one 
                    // letter - O
                    else if(who_won == 2'b01)
                        begin
                        if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 0 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 1 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 4 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= 0 && 
                            vga_start_bg_in.hcount <= 400 && 
                            vga_start_bg_in.vcount >= 0 && 
                            vga_start_bg_in.vcount <= 600)
                            begin
                                rgb_nxt = 12'h0_0_0;
                            end
                        end
                    else if(who_won == 2'b10)
                        begin
                        // letter - 1
                        if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 2 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 3 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + 1 * pixel && 
                            vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                            begin
                                rgb_nxt = 12'h8_8_8;
                            end
                        else if(vga_start_bg_in.hcount >= 0 && 
                            vga_start_bg_in.hcount <= 400 && 
                            vga_start_bg_in.vcount >= 0 && 
                            vga_start_bg_in.vcount <= 600)
                            begin
                                rgb_nxt = 12'h0_0_0;
                            end
                        end
                    //text end
                    else
                        begin
                            rgb_nxt = 12'h0_0_0;
                        end
        
                end
            else //safety
                begin
                    rgb_nxt = 0;
                end

        
    end
end
 
endmodule
 