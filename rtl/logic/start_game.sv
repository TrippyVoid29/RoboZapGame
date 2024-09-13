/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Sends flag to start game from init.
 */

`timescale 1 ns / 1 ps

module start_game (
    input wire clk,
    input wire rst,
    input logic [1:0] state_input,
    input logic buttonL, buttonR,

    output logic start_game_out,
    output logic player_selected
);


always_ff@(posedge clk)
begin
    if (rst)
        begin
            start_game_out <= 1'b0;
            player_selected <= 1'b0;
        end
    else
        begin
            if(state_input == 2'b00)
                begin
                    if(buttonL == 1'b1)
                        begin
                            start_game_out <= 1'b1;
                            player_selected <= 1'b0;
                        end
                    else if(buttonR == 1'b1)
                        begin
                            start_game_out <= 1'b1;
                            player_selected <= 1'b1;
                        end
                    else
                        begin
                            start_game_out <= 1'b0;
                        end
                end
            else
                begin
                    start_game_out <= 1'b0;
                end
        end
end
endmodule