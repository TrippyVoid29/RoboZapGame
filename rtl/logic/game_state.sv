`timescale 1 ns / 1 ps

module game_state #(

    )(
    input wire clk,
    input wire rst,
    input wire [4:0] lever_select,
    input wire buttonL, //left button
    input wire buttonR,
    input wire turn_done, // if turn was done 1-Y, 0-N

    output logic [1:0] who_won, //info for display (00 - I'm still standing, 10 - I won, 01 - I lost, 11 - I drew)
    output logic [7:0] lever_left_out,
    output logic current_player, // saved which player i am
    output logic [1:0] player0_health,
    output logic [1:0] player1_health,
    output logic [2:0] tableselected, // for now 8 tables
    output logic [2:0] state_output
   
    );

    //STATES
    typedef enum bit [2:0] {    
    INIT = 3'b000,
    MENU = 3'b001,
    PLAYER_0 = 3'b010,
    PLAYER_1 = 3'b011,
    GAMEEND = 3'b100} egame_state;

    //local signals
    logic [1:0] who_won_next;
    logic [7:0] lever_left_out_next;
    logic current_player_next;
    logic [1:0] player0_health_next, player1_health_next;
    logic [2:0] tableselected_next;

    egame_state state_next;
    logic [2:0] state; 

    // body
    always_ff@(posedge clk)
    if (rst)
        begin
            who_won <= 2'b00;
            lever_left_out <= 8'b11111111;
            current_player <= 1'b0;
            player0_health <= 2'b11;
            player1_health <= 2'b11;
            tableselected <= 3'b000;
            state <= INIT;
            state_output <= INIT;
        end
    else
        begin
            who_won <= who_won_next;
            lever_left_out <= lever_left_out_next;
            current_player <= current_player_next;
            player0_health <= player0_health_next;
            player1_health <= player1_health_next;
            tableselected <= tableselected_next;
            state <= state_next;
            state_output <= state_next;
        end


    always_comb
        begin
            case(state)
                INIT:
                    begin
                        if(buttonR == 1'b1)
                            begin
                                state_next = MENU;
                                player0_health_next = 2'b11;
                                player1_health_next = 2'b11;
                                current_player_next = 1'b0;
                                who_won_next =  2'b00;
                                lever_left_out_next = 8'b11111111;
                            end
                        else 
                            begin
                                tableselected_next = tableselected + 1;
                                state_next = INIT;
                                player0_health_next = player0_health;
                                player1_health_next = player1_health;
                                current_player_next = current_player;
                                who_won_next =  who_won;
                                lever_left_out_next = lever_left_out;
                            end
                    end
                MENU:
                    begin
                        if(buttonL == 1'b1)
                            begin
                                state_next = PLAYER_0;
                                current_player_next = 1'b0;
                            end
                        else
                            begin
                                state_next = MENU;
                            end
                    end
                PLAYER_0:
                    begin
                        if(player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = GAMEEND;
                            end
                        else if(turn_done == 1'b1 && lever_left_out[lever_select[3:1]] == 1'b1)
                            begin

                                lever_left_out_next[lever_select[3:1]] = 1'b0;

                                //hp calculations
                                if(lever_select[0] == 1'b0 && lever_select[4] == 1'b0)
                                    begin
                                        player0_health_next = player0_health;
                                        current_player_next = 1'b0;
                                        state_next = PLAYER_0;
                                    end
                                else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b0)
                                    begin
                                        player0_health_next = player0_health - 1;
                                        current_player_next = 1'b0;
                                        state_next = PLAYER_0;
                                    end
                                else if(lever_select[0] == 1'b0 && lever_select[4] == 1'b1)
                                    begin
                                        player1_health_next = player1_health;
                                        current_player_next = 1'b1;
                                        state_next = PLAYER_1;
                                    end
                                else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b1)
                                    begin
                                        player1_health_next = player1_health - 1;
                                        current_player_next = 1'b1;
                                        state_next = PLAYER_1;
                                    end
                                else
                                    begin
                                        player1_health_next = player1_health;                                            
                                        player0_health_next = player0_health;
                                    end
                            end
                        else
                            begin
                                state_next = PLAYER_0;
                            end
                    end
                PLAYER_1:
                    begin
                        if(player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = GAMEEND;
                            end
                        else if(turn_done == 1'b1 && lever_left_out[lever_select[3:1]] == 1'b1)
                            begin

                                lever_left_out_next[lever_select[3:1]] = 1'b0;

                                //hp calculations
                                if(lever_select[0] == 1'b0 && lever_select[4] == 1'b0)
                                    begin
                                        player0_health_next = player0_health;
                                        state_next = PLAYER_0;
                                        current_player_next = 1'b0;
                                    end
                                else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b0)
                                    begin
                                        player0_health_next = player0_health - 1;
                                        state_next = PLAYER_0;
                                        current_player_next = 1'b0;
                                    end
                                else if(lever_select[0] == 1'b0 && lever_select[4] == 1'b1)
                                    begin
                                        player1_health_next = player1_health;
                                        state_next = PLAYER_1;
                                        current_player_next = 1'b1;
                                    end
                                else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b1)
                                    begin
                                        player1_health_next = player1_health - 1;
                                        state_next = PLAYER_1;
                                        current_player_next = 1'b1;
                                    end
                                else
                                    begin
                                        player1_health_next = player1_health;                                            
                                        player0_health_next = player0_health;
                                    end
                            end
                    else
                        begin
                            state_next = PLAYER_1;
                        end
                    end
                GAMEEND:
                    begin
                        if(buttonL == 1'b1 || buttonR == 1'b1)
                            begin
                                state_next = INIT;
                            end
                        else
                            begin
                                if(player0_health > player1_health)
                                begin
                                    who_won_next = 2'b10;
                                end
                                else if(player0_health < player1_health)
                                begin
                                    who_won_next = 2'b01;
                                end
                                else if(player0_health == player1_health)
                                begin
                                    who_won_next = 2'b11;
                                end
                                else
                                begin
                                    who_won_next = 2'b00;
                                end
                                state_next = GAMEEND;
                            end
                    end
            endcase
        end
            
endmodule

