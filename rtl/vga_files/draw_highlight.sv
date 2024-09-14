/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Lever highlight.
 */

`timescale 1 ns / 1 ps

module draw_highlight #(

    parameter lever_posit_x = 200,
    parameter lever_posit_y = 600,
    parameter width = 50,
    parameter height = 50,
    parameter distance = width + 25
)(
    input  logic clk,
    input  logic rst,

    vga_if.out vga_highlight_out,
    vga_if.in vga_highlight_in
);

import vga_pkg::*;

logic [11:0] rgb_nxt;

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        vga_highlight_out.vcount <= '0;
        vga_highlight_out.vsync  <= '0;
        vga_highlight_out.vblnk  <= '0;
        vga_highlight_out.hcount <= '0;
        vga_highlight_out.hsync  <= '0;
        vga_highlight_out.hblnk  <= '0;
        vga_highlight_out.rgb    <= '0;
        vga_highlight_out.position <= '0;
    end else begin
        vga_highlight_out.vcount <= vga_highlight_in.vcount;
        vga_highlight_out.vsync  <= vga_highlight_in.vsync;
        vga_highlight_out.vblnk  <= vga_highlight_in.vblnk;
        vga_highlight_out.hcount <= vga_highlight_in.hcount;
        vga_highlight_out.hsync  <= vga_highlight_in.hsync;
        vga_highlight_out.hblnk  <= vga_highlight_in.hblnk;
        vga_highlight_out.position <= vga_highlight_in.position;
        if(rgb_nxt) begin
            vga_highlight_out.rgb    <= rgb_nxt;
        end else begin
            vga_highlight_out.rgb    <= vga_highlight_in.rgb;
        end
    end
end

always_comb begin : lever_comb_blk

//------------------------INTERFACE_ELEMENTS----------------------------

parameter highlight_range = 3;
parameter highlight_color = 12'h0_9_0; //GREEN

        // --Lever_Highlight--
        if (vga_highlight_out.hcount >= (lever_posit_x - highlight_range) + (vga_highlight_out.position * distance) && 
            vga_highlight_out.hcount <= (lever_posit_x + height + highlight_range) + (vga_highlight_out.position * distance) && 
            vga_highlight_out.vcount >= (lever_posit_y - highlight_range) && 
            vga_highlight_out.vcount <= (lever_posit_y + height + highlight_range))              
            
            rgb_nxt = highlight_color;
        else
            rgb_nxt = 0;

end

endmodule
