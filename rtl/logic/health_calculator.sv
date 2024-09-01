`timescale 1 ns / 1 ps

module health_calculator (
    
    input wire clk,
    input wire rst,

    input wire [1:0] game_state_in,
    input wire [1:0] lever_info, // lethality, usability
    input wire target,
    input wire lever_used_in,

    output logic [1:0] player0_health, 
    output logic [1:0] player1_health,
    output logic end_game

);

    logic [1:0] player0_health_next;
    logic [1:0] player1_health_next;
    logic end_game_next;

always_ff @(posedge clk)
begin
    if(rst)
        begin
            player0_health <= 2'b11;
            player1_health <= 2'b11;
            end_game <= 1'b0;
        end
    else
        begin   
            player0_health <= player0_health_next;
            player1_health <= player1_health_next;
            end_game <= end_game_next;
        end
end

always_comb
begin
    end_game_next = end_game;

    if((game_state_in == 2'b01) && (lever_info[0] == 1'b1) && (lever_used_in == 1'b1))
        begin
            if(lever_info[1] == 1'b1)
                begin
                    if(target)
                        begin
                            if(player1_health > 1'b1)
                                player1_health_next = player1_health - 1;
                            else if(player1_health == 1'b1)
                                begin
                                    player1_health_next = 2'b00;
                                    end_game_next = 1'b1;
                                end
                            else
                            player1_health_next = player1_health;
                            player0_health_next = player0_health;
                        end
                    else
                        begin
                            if(player0_health > 1'b1)
                                player0_health_next = player0_health - 1;
                            else if(player0_health == 1'b1)
                                begin
                                    player0_health_next = 2'b00;
                                    end_game_next = 1'b1;
                                end
                            else
                            player0_health_next = player0_health;
                            player1_health_next = player1_health;
                        end
                end
            else
                begin
                    player0_health_next = player0_health;
                    player1_health_next = player1_health;
                end
        end
    else if(game_state_in == 2'b10)
        begin
            player0_health_next = player0_health;
            player1_health_next = player1_health;
            end_game_next = 1'b0;
        end
    else
        begin
            player0_health_next = 2'b11;
            player1_health_next = 2'b11;
        end
end

endmodule