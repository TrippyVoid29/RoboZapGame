/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Module for drawing active and inactive levers.
 */

`timescale 1 ns / 1 ps

module draw_lever #(

    parameter lever_posit_x = 100,
    parameter lever_posit_y = 500,
    parameter width = 50,
    parameter height = 50
)(
    input  logic clk,
    input  logic rst,
    input [7:0] lever_left_in,
    vga_if.out vga_lever_out,
    vga_if.in vga_lever_in
);

import vga_pkg::*;

logic [11:0] rgb_nxt;

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        vga_lever_out.vcount <= '0;
        vga_lever_out.vsync  <= '0;
        vga_lever_out.vblnk  <= '0;
        vga_lever_out.hcount <= '0;
        vga_lever_out.hsync  <= '0;
        vga_lever_out.hblnk  <= '0;
        vga_lever_out.rgb    <= '0;
        vga_lever_out.position <= '0;
    end else begin
        vga_lever_out.vcount <= vga_lever_in.vcount;
        vga_lever_out.vsync  <= vga_lever_in.vsync;
        vga_lever_out.vblnk  <= vga_lever_in.vblnk;
        vga_lever_out.hcount <= vga_lever_in.hcount;
        vga_lever_out.hsync  <= vga_lever_in.hsync;
        vga_lever_out.hblnk  <= vga_lever_in.hblnk;
        vga_lever_out.position <= vga_lever_in.position;
        if(rgb_nxt) begin
            vga_lever_out.rgb    <= rgb_nxt;
        end else begin
            vga_lever_out.rgb    <= vga_lever_in.rgb;
        end
    end
end

always_comb begin : lever_comb_blk
//------------------------INTERFACE_ELEMENTS----------------------------

parameter distance = width + 25;

// Colors
parameter unused_st_color = 12'h4_4_4;
parameter unused_nd_color = 12'h7_7_7;
parameter unused_rd_color = 12'h9_9_9;

parameter used_st_color = 12'h1_1_1;
parameter used_nd_color = 12'h2_2_2;
parameter used_rd_color = 12'h4_4_4;


//------------------------LEVER_7---------------------------
        if (vga_lever_out.hcount >= (lever_posit_x + 7) && vga_lever_out.hcount <= (width + lever_posit_x - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[0] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[0] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + 5) && vga_lever_out.hcount <= (width + lever_posit_x - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[0] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[0] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x && vga_lever_out.hcount <= (width + lever_posit_x) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[0] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[0] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_6---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + distance + 7) && vga_lever_out.hcount <= (width + lever_posit_x + distance - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[1] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[1] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + distance + 5) && vga_lever_out.hcount <= (width + lever_posit_x + distance - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[1] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[1] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + distance && vga_lever_out.hcount <= (width + lever_posit_x + distance) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[1] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[1] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_5---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 2) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 2) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[2] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[2] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 2) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 2) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[2] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[2] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 2) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 2)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[2] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[2] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_4---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 3) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 3) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[3] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[3] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 3) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 3) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[3] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[3] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 3) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 3)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[3] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[3] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_3---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 4) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 4) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[4] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[4] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 4) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 4) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[4] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[4] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 4) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 4)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[4] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[4] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_2---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 5) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 5) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[5] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[5] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 5) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 5) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[5] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[5] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 5)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[5] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[5] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_1---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 6) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 6) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[6] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[6] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 6) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 6) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[6] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[6] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 6) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 6)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[6] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[6] == 0)
                rgb_nxt = used_rd_color;
            end
//------------------------LEVER_0---------------------------
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 7) + 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 7) - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            begin
            if(lever_left_in[7] == 1)
                rgb_nxt = unused_st_color;
            else if(lever_left_in[7] == 0) 
                rgb_nxt = used_st_color;
            end
        else if (vga_lever_out.hcount >= (lever_posit_x + (distance * 7) + 5) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 7) - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            begin
            if(lever_left_in[7] == 1)
                rgb_nxt = unused_nd_color;
            else if(lever_left_in[7] == 0)
                rgb_nxt = used_nd_color;   
            end
        else if (vga_lever_out.hcount >= lever_posit_x + (distance * 7) && vga_lever_out.hcount <= (width + lever_posit_x + (distance * 7)) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            begin
            if(lever_left_in[7] == 1)
                rgb_nxt = unused_rd_color;
            else if(lever_left_in[7] == 0)
                rgb_nxt = used_rd_color;
            end

        else
            rgb_nxt = 0;
end

endmodule
