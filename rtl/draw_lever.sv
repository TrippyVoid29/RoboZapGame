/**
 * Description:
 * Draw lever
 */
`timescale 1 ns / 1 ps

module draw_lever #(

    parameter lever_posit_x = 100,
    parameter lever_posit_y = 100,
    parameter width = 100,
    parameter height = 50
)(
    input  logic clk,
    input  logic rst,
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
    end else begin
        vga_lever_out.vcount <= vga_lever_in.vcount;
        vga_lever_out.vsync  <= vga_lever_in.vsync;
        vga_lever_out.vblnk  <= vga_lever_in.vblnk;
        vga_lever_out.hcount <= vga_lever_in.hcount;
        vga_lever_out.hsync  <= vga_lever_in.hsync;
        vga_lever_out.hblnk  <= vga_lever_in.hblnk;
        if(rgb_nxt) begin
            vga_lever_out.rgb    <= rgb_nxt;
        end else begin
            vga_lever_out.rgb    <= vga_lever_in.rgb;
        end
    end
end

always_comb begin : lever_comb_blk

//------------------------INTERFACE_ELEMENTS----------------------------

parameter highlight_range = 3;
parameter highlight_color = 12'h0_6_0; //GREEN

//------------------------LEVER_STATE_NEUTRAL---------------------------
        if (vga_lever_out.hcount >= (lever_posit_x + 7) && vga_lever_out.hcount <= (width + lever_posit_x - 7) && vga_lever_out.vcount >= (lever_posit_y + 22) && vga_lever_out.vcount <= (height + lever_posit_y - 22))              
            rgb_nxt = 12'h3_3_3;
        else if (vga_lever_out.hcount >= (lever_posit_x + 5) && vga_lever_out.hcount <= (width + lever_posit_x - 5) && vga_lever_out.vcount >= (lever_posit_y + 20) && vga_lever_out.vcount <= (height + lever_posit_y - 20))              
            rgb_nxt = 12'h5_5_5;
        else if (vga_lever_out.hcount >= lever_posit_x && vga_lever_out.hcount <= (width + lever_posit_x) && vga_lever_out.vcount >= lever_posit_y && vga_lever_out.vcount <= (height + lever_posit_y))              
            rgb_nxt = 12'h7_7_7;

        //--Lever_Highlight--
        else if (vga_lever_out.hcount >= (lever_posit_x - highlight_range) && vga_lever_out.hcount <= (width + lever_posit_x + highlight_range) && vga_lever_out.vcount >= (lever_posit_y - highlight_range) && vga_lever_out.vcount <= (height + lever_posit_y + highlight_range))              
            rgb_nxt = highlight_color;
        //--END--
        else
           rgb_nxt = 0;
end

endmodule
