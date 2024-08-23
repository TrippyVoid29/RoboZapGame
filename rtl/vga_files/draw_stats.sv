/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_stats #(
    parameter position_x = 20,
    parameter position_y = 20,

    parameter healthbar_height = 40,
    parameter healthbar_width = 20,

    parameter distance_x = 5,
    parameter distance_y = 5,

    parameter health_max = 3
)(

    input  logic clk,
    input  logic rst,
    input  logic [1:0] player0_health,
    input  logic [1:0] player1_health,
    input logic current_player,

    vga_if.out vga_stats_out,
    vga_if.in vga_stats_in
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;
logic [1:0] my_health;

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
// ---------------- MY_HEALTH_CALCULATION ---------------------------
    if(current_player == 1'b0)
        begin
            my_health [1:0] = player0_health [1:0];
        end
    else
        begin
            my_health [1:0] = player1_health [1:0];
        end

//------------------- HEALTH_BAR ------------------------------------
    // 1_HP
    if (vga_stats_out.hcount >= (position_x + distance_x) && 
        vga_stats_out.hcount <= (position_x + healthbar_width + distance_x) && 
        vga_stats_out.vcount >= (position_y) && 
        vga_stats_out.vcount <= position_y + healthbar_height)       

        begin
            if(my_health >= 2'b01)
                begin
                    rgb_nxt = 12'h8_0_0;
                end
            else
                begin
                    rgb_nxt = 12'h3_0_0;
                end
        end

    // 2_HP
    else if (vga_stats_out.hcount >= (position_x + distance_x) + (healthbar_width + distance_x) && 
        vga_stats_out.hcount <= (position_x + healthbar_width + distance_x) + (healthbar_width + distance_x) && 
        vga_stats_out.vcount >= (position_y) && 
        vga_stats_out.vcount <= position_y + healthbar_height) 

        begin
            if(my_health >= 2'b10)
                begin
                    rgb_nxt = 12'h8_0_0;
                end
            else
                begin
                    rgb_nxt = 12'h3_0_0;
                end
        end

    // 3_HP
    else if (vga_stats_out.hcount >= (position_x + distance_x) + 2 * (healthbar_width + distance_x) && 
        vga_stats_out.hcount <= (position_x + healthbar_width + distance_x) + 2 * (healthbar_width + distance_x) && 
        vga_stats_out.vcount >= (position_y) && 
        vga_stats_out.vcount <= position_y + healthbar_height)

        begin
            if(my_health == 2'b11)
                begin
                    rgb_nxt = 12'h8_0_0;
                end
            else
                begin
                    rgb_nxt = 12'h3_0_0;
                end
        end
//------------------- BATTERY_BOX ------------------------------------
    else if (vga_stats_out.hcount >= (position_x) && 
    vga_stats_out.hcount <= (position_x + health_max * healthbar_width + (health_max + 1) * distance_x) && 
    vga_stats_out.vcount >= (position_y - distance_y) && 
    vga_stats_out.vcount <= position_y + healthbar_height + distance_y)

    rgb_nxt = 12'h4_0_0;

    else
        rgb_nxt = 12'h0_0_0;

    end

endmodule
