 `timescale 1 ns / 1 ps

 module draw_start_bg(

    input  logic clk,
    input  logic rst,
    input  logic [2:0] states,
    input  logic [1:0] who_won,

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
 
 /**
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
// --------------------- BG 1 ------------------------
        if(states == 3'b000)
            //PRESS LB AND RB TO START
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
            //space
            // next letter - R
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + pixel&& 
            vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 2 * pixel&& 
            vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 3 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 3 * pixel&& 
            vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 4 * pixel&& 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        // next letter - B
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        //space
        // next letter - A
        else if(vga_start_bg_in.hcount >= start_posit_x + 9 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 9 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y + pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 9 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 9 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 9 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 9 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 9 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 9 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        //next letter - N
        else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 2 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 2 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 3 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 3 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        // next letter - D
        else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        //space
        // next letter - L
        else if(vga_start_bg_in.hcount >= start_posit_x + 13 * letter_width + 0 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 13 * letter_width + 1 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 13 * letter_width + 1 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 13 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        // next letter - B
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y && 
            vga_start_bg_in.vcount <= start_posit_y + pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 4 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 4 * pixel && 
            vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 5 * pixel && 
            vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
            vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
            begin
                rgb_nxt = 12'h8_8_8;
            end
        
            //end
            else
                rgb_nxt = 12'h1_1_1;

// --------------------- BG 2 ------------------------
        // letter - S
        else if(states == 3'b001)
            if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel&& 
                vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - E
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 1 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 1 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
                // next letter - L
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - E
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
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
            else if(vga_start_bg_in.hcount >= start_posit_x + 3 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 3 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - C
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - T
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - I
            else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //next letter - N
            else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 2 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 7 * letter_width + 3 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 7 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            //letter - G
            else if(vga_start_bg_in.hcount >= start_posit_x + 8 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 8 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 8 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 8 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 8 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 8 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 8 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 8 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 8 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 8 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // space
            // letter - B
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 10 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 10 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - U
            else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 11 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 11 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - T
            else if(vga_start_bg_in.hcount >= start_posit_x + 12 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 12 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 12 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 12 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - T
            else if(vga_start_bg_in.hcount >= start_posit_x + 13 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 13 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 13 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 13 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - O
            else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 14 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 14 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - N
            else if(vga_start_bg_in.hcount >= start_posit_x + 15 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 15 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 15 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 15 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 15 * letter_width + 1 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 15 * letter_width + 2 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 15 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 15 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 15 * letter_width + 3 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 15 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - S
            else if(vga_start_bg_in.hcount >= start_posit_x + 16 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 16 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y && 
                vga_start_bg_in.vcount <= start_posit_y + pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 16 * letter_width + pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 16 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 16 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 16 * letter_width + pixel && 
                vga_start_bg_in.vcount >= start_posit_y + pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 16 * letter_width && 
                vga_start_bg_in.hcount <= start_posit_x + 16 * letter_width + 4 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 16 * letter_width + 4 * pixel&& 
                vga_start_bg_in.hcount <= start_posit_x + 16 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - ...
            else if(vga_start_bg_in.hcount >= start_posit_x + 17 * letter_width + 0 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 17 * letter_width + 1 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 17 * letter_width + 2 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 17 * letter_width + 3 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            else if(vga_start_bg_in.hcount >= start_posit_x + 17 * letter_width + 4 * pixel && 
                vga_start_bg_in.hcount <= start_posit_x + 17 * letter_width + 5 * pixel && 
                vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                begin
                    rgb_nxt = 12'h8_8_8;
                end
            // letter - ...
            
            //end
            else
                rgb_nxt = 12'h1_1_1;
            


// --------------------- BG 3 ------------------------
        else if(states == 3'b110) // gameend

            if(who_won == 2'b01) //u lost
                begin
                // letter - Y
                if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 2 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 3 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                //letter - O
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
                //letter - U
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                //space
                //letter - D
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
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
                //letter - I
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                // letter - E
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
               
                //end
                else
                    rgb_nxt = 12'h2_0_0;
                end

            else if(who_won == 2'b10) //u win
                begin
                // letter - Y
                if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 2 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 3 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                //letter - O
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
                //letter - U
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                //space
                // letter - W
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 2 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 4 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 3 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 4 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                //letter - I
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 5 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 5 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                // letter - N
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 2 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 2 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 2 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 3 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 6 * letter_width + 3 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 6 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 3 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 4 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                
                //end
                else
                    rgb_nxt = 12'h0_2_0;
                end

            else if(who_won == 2'b11) //draw
                begin
                // letter - D
                if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 1 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 5 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 0 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 0 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 0 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                // letter - R
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
                // letter - A
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 4 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y && 
                    vga_start_bg_in.vcount <= start_posit_y + 1 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 2 * letter_width + 1 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 2 * letter_width + 4 * pixel && 
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
                // letter - ...
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 0 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 1 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 2 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 3 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                else if(vga_start_bg_in.hcount >= start_posit_x + 4 * letter_width + 4 * pixel && 
                    vga_start_bg_in.hcount <= start_posit_x + 4 * letter_width + 5 * pixel && 
                    vga_start_bg_in.vcount >= start_posit_y + 5 * pixel && 
                    vga_start_bg_in.vcount <= start_posit_y + 6 * pixel)
                    begin
                        rgb_nxt = 12'h8_8_8;
                    end
                
                else
                    rgb_nxt = 12'h0_0_4;
                end

            else if(who_won == 2'b00) //still alive - nothing
                begin
                    rgb_nxt = 0;
                end

            else //safety
                begin
                    rgb_nxt = 0;
                end
        else
            rgb_nxt = 12'h0_0_0;
        end
end
 
endmodule
 