`timescale 1 ns / 1 ps

// microcode
// 0000 0000
// 0,1,2 - turn
// 3 - lever lethality
// 4,5,6 - which switch
// 7 - who was targeted

// code for reset = 0000 0000
// code for player set = 1000 0000


module game_state #(

    )(
    input wire clk,
    input wire rst,
    input wire [4:0] lever_select,
    input wire buttonL, //left button
    input wire buttonR, //right button
    input wire turn_done, // if turn was done 1-Y, 0-N

    output logic [1:0] who_won, //info for display (00 - I'm still standing, 10 - I won, 01 - I lost, 11 - I drew)
    output logic [7:0] lever_left_out,
    output logic current_player, // saved which player i am
    output logic [1:0] player0_health,
    output logic [1:0] player1_health,
    output logic [2:0] tableselected, // for now 8 tables
    output logic [2:0] state
   
    );

    //STATES
    typedef enum bit [2:0] {    
    PLAYER_SELECT = 3'b000,
    MENU = 3'b001,
    LEVERS = 3'b010,
    PLAYER_0 = 3'b011,
    PLAYER_1 = 3'b100,
    GAMEEND = 3'b101,
    CON_CHECK = 3'b110} egame_state;

    

    //local signals
    logic [1:0] who_won_next;
    logic [7:0] lever_left_out_next;
    logic current_player_next;
    logic [1:0] player0_health_next, player1_health_next;
    logic [2:0] tableselected_next;
    logic [2:0] turn, turn_next;

    egame_state state_next;

    // body
    always_ff@(posedge clk)
    if (rst)
        begin
            who_won <= 2'b00;
            lever_left_out <= 8'b11111111;
            current_player <= 1'b0;
            player0_health <= 2'b10;
            player1_health <= 2'b10;
            tableselected <= 3'b000;
            turn <= 3'b000;
            state <= PLAYER_SELECT;
        end
    else
        begin
            who_won <= who_won_next;
            lever_left_out <= lever_left_out_next;
            current_player <= current_player_next;
            player0_health <= player0_health_next;
            player1_health <= player1_health_next;
            tableselected <= tableselected_next;
            turn <= turn_next;
            state <= state_next;
        end


    always_comb
        begin
            case(state)
                PLAYER_SELECT:
                    begin

                    end
                MENU: //player0 only
                    begin

                    end
                LEVERS: //player1 only
                    begin

                    end
                CON_CHECK: //player0 only
                    begin

                    end
                PLAYER_0:
                    begin
                        turn_next = turn;
                        if(lever_left_out == 8'b00000000 || player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = GAMEEND;
                            end
                        else if(turn == 3'b000 || turn == 3'b010 || turn == 3'b100 || turn == 3'b110)
                            begin
                                if(turn_done == 1'b1)
                                    begin
                                        turn_next = turn + 1;
                                        lever_left_out_next[lever_select[3:1]] = 1'b0;

                                        //hp calculations
                                        if(lever_select[0] == 1'b0 && lever_select[4] == 1'b0)
                                            begin
                                                player0_health_next = player0_health + 1;
                                            end
                                        else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b0)
                                            begin
                                                player0_health_next = player0_health - 1;
                                            end
                                        else if(lever_select[0] == 1'b0 && lever_select[4] == 1'b1)
                                            begin
                                                player1_health_next = player1_health + 1;
                                            end
                                        else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b1)
                                            begin
                                                player1_health_next = player1_health - 1;
                                            end
                                        else
                                            begin
                                                player1_health_next = player1_health;
                                                player0_health_next = player0_health;
                                            end
                                            state_next = PLAYER_0;
                                    end
                                else
                                    begin
                                        state_next = PLAYER_0;
                                    end

                            end
                    end
                PLAYER_1:
                    begin
                        turn_next = turn;

                        if(lever_left_out == 8'b00000000 || player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = GAMEEND;
                            end
                        else if(turn == 3'b001 || turn == 3'b011 || turn == 3'b101 || turn == 3'b111)
                            begin
                                if(turn_done == 1'b1)
                                    begin
                                        turn_next = turn + 1;
                                        lever_left_out_next[lever_select[3:1]] = 1'b0;

                                        //hp calculations
                                        if(lever_select[0] == 1'b0 && lever_select[4] == 1'b0)
                                            begin
                                                player0_health_next = player0_health + 1;
                                            end
                                        else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b0)
                                            begin
                                                player0_health_next = player0_health - 1;
                                            end
                                        else if(lever_select[0] == 1'b0 && lever_select[4] == 1'b1)
                                            begin
                                                player1_health_next = player1_health + 1;
                                            end
                                        else if(lever_select[0] == 1'b1 && lever_select[4] == 1'b1)
                                            begin
                                                player1_health_next = player1_health - 1;
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
                    end
                GAMEEND:
                    begin
                        if(buttonR == 1'b1)
                            begin
                                state_next = PLAYER_SELECT;
                            end
                        else
                            begin
                                if((current_player == 1'b0) && (player0_health > player1_health))
                                    begin
                                        who_won_next = 2'b10;
                                    end
                                else if((current_player == 1'b0) && (player0_health < player1_health))
                                    begin
                                        who_won_next = 2'b01;
                                    end
                                else if((current_player == 1'b1) && (player0_health < player1_health))
                                    begin
                                        who_won_next = 2'b10;
                                    end
                                else if((current_player == 1'b1) && (player0_health > player1_health))
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
                default:
                begin
                    who_won_next = 2'b00;
                    lever_left_out_next = 8'b11111111;
                    current_player_next = 1'b0;
                    player0_health_next = 2'b10;
                    player1_health_next = 2'b10;
                    tableselected_next = 3'b000;
                    turn_next = 3'b000;
                    state_next = PLAYER_SELECT;
                end
            endcase
        end
endmodule
