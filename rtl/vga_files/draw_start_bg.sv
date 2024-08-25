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
        // jakiś losowy kwadrat
            if (vga_start_bg_in.hcount >= 250 && vga_start_bg_in.hcount <= 350 && vga_start_bg_in.vcount >= 150 && vga_start_bg_in.vcount <= 250)
                rgb_nxt = 12'h8_0_0;
            else
                rgb_nxt = 12'h1_1_1;

// --------------------- BG 2 ------------------------
        else if(states == 3'b001)
        // jakiś losowy kwadrat
            if (vga_start_bg_in.hcount >= 250 && vga_start_bg_in.hcount <= 350 && vga_start_bg_in.vcount >= 150 && vga_start_bg_in.vcount <= 250)
                rgb_nxt = 12'h0_8_0;
            else
                rgb_nxt = 12'h1_1_1;

// --------------------- BG 3 ------------------------
        else if(states == 3'b110)
        // jakiś losowy kwadrat
            if (vga_start_bg_in.hcount >= 250 && vga_start_bg_in.hcount <= 350 && vga_start_bg_in.vcount >= 150 && vga_start_bg_in.vcount <= 250)
                rgb_nxt = 12'h0_0_8;
            else
                rgb_nxt = 12'h1_1_1;
        else
            rgb_nxt = 0;
        end
end
 
endmodule
 