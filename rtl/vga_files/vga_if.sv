/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Interface for graphics.
 */

`timescale 1 ns / 1 ps
interface vga_if();

logic [10:0] vcount;
logic        vsync;
logic        vblnk;
logic [10:0] hcount;
logic        hsync;
logic        hblnk;
logic [2:0]  position;

logic [11:0] rgb;

 modport in(
    input vsync, vcount, vblnk, hcount, hsync, hblnk, rgb, position
 );

 modport out(
    output vsync, vcount, vblnk, hcount, hsync, hblnk, rgb, position
 );

endinterface
 
 