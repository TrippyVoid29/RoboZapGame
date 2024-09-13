/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Holds information about currently selected lever.
 */

`timescale 1 ns / 1 ps

module levers_info (
    input wire clk,
    input wire rst,

    input wire [2:0] position,
    input wire lever_used,
    input wire [1:0] game_state_in,
    input wire [7:0] levers_lethality,
    input wire player_selected,
    input wire turn_uart,
    input wire lever_used_uart,
    input wire [2:0] position_uart,
    input wire [1:0] usability_uart,

    output logic [1:0] lever_info, // lethality, usability
    output logic [7:0] lever_left
);

//local signals
logic [7:0] lever_left_next;
logic is_lethal, is_lethal_next;
logic is_usable, is_usable_next;
logic [1:0] lever_info_next;

always_ff@(posedge clk)
    if (rst)
        begin
            is_usable <= 1'b0;
            is_lethal <= 1'b0;
            lever_left <= 8'b11111111;
            lever_info <= 2'b00;
        end
    else 
        begin
            if(turn_uart == player_selected)
            begin
                lever_left <= lever_left_next;
                is_lethal <= usability_uart[0];
                is_usable <= usability_uart[1];
                lever_info <= usability_uart;
                
            end
            else 
            begin
                lever_left <= lever_left_next;
                is_lethal <= is_lethal_next;
                is_usable <= is_usable_next;
                lever_info <= lever_info_next;
            end
        end

    always_comb
        begin
            is_lethal_next = is_lethal;
            is_usable_next = is_usable;
            lever_left_next = lever_left;
            lever_info_next = lever_info;
            
            if(game_state_in == 2'b01)
                begin
                    is_lethal_next = levers_lethality[position];
                    is_usable_next = lever_left[position];
                    lever_info_next = {is_lethal, is_usable};
                    if(lever_used == 1'b1)
                        begin
                            lever_left_next[position] = 1'b0;
                        end
                    else if(lever_used_uart == 1'b1)
                        begin
                            lever_left_next[position_uart] = 1'b0;
                        end
                    
                end
            else if(game_state_in == 2'b00)
                begin
                    is_usable_next = 1'b0;
                    is_lethal_next = 1'b0;
                    lever_left_next = 8'b11111111;
                    lever_info_next = 2'b00;
                end
            else
                begin
                    is_lethal_next = is_lethal;
                    is_usable_next = is_usable;
                end
        end
endmodule