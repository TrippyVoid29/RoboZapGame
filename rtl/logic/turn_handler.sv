/**
* 2024  AGH University of Science and Technology
* MTM UEC2
* Author: Łukasz Perczyński & Tymon Ryś
*
* Description:
* handles turns.
*/

`timescale 1 ns / 1 ps

module turn_handler (
    
    input wire clk,
    input wire rst,

    input wire [1:0] game_state_in,
    input wire player_selected,
    input wire turn_uart,
    input wire turn_flag,
    input wire data_received,

    output logic turn
    
);


always_ff @(posedge clk)
    begin
        if(rst)
            begin
                turn <= 1'b0;
            end
        else
            begin 
                if(game_state_in == 2'b01)
                    begin
                        if(data_received)
                            begin
                                turn <= turn_uart;
                            end
                        else
                            begin
                                if(turn_flag)
                                    turn <= ~turn;
                                else
                                    turn <= turn;
                            end
                    end
                else
                    begin
                        turn <= 1'b0;
                    end
            end
    end

endmodule