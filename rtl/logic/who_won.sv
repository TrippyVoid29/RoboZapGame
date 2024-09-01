/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Sends information to vga about game result.
 */

`timescale 1 ns / 1 ps

module who_won (

    input rst,
    input clk,

    input wire [1:0] player0_health, 
    input wire [1:0] player1_health,
    input wire [1:0] game_state_in,

    output logic [1:0] winner

);

always_ff @(posedge clk)
begin
    if(rst)
        begin
            winner <= 2'b00;
        end
    else
        begin
            if(game_state_in == 2'b01)
                begin
                    if(player0_health == 2'b00)
                        winner <= 2'b10;
                    else if(player1_health == 2'b00)
                        winner <= 2'b01;
                    else
                        winner <= winner;
                end
            else if(game_state_in == 2'b10)
                winner <= winner;
            else
                winner <= 2'b00;
        end
end

endmodule