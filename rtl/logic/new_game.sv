/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Sends flag to start new game.
 */

`timescale 1 ns / 1 ps

module new_game (
    input wire clk,
    input wire rst,
    input logic [1:0] state_input,
    input logic buttonL,

    output logic new_game_out
);

always_ff@(posedge clk)
begin
    if (rst)
            new_game_out <= 1'b0;
    else
        begin
            if(state_input == 2'b10)
                begin
                    if(buttonL == 1'b1)
                            new_game_out <= 1'b1;
                    else
                            new_game_out <= 1'b0;
                end
            else
                    new_game_out <= 1'b0;
        end 
end    

endmodule
