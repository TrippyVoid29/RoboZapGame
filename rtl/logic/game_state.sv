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
    //input wire [7:0] uart_rx,        //info received from uart
    input wire [4:0] lever_select,
    input wire buttonC, //middle button
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button
    input wire turn_done, // if turn was done 1-Y, 0-N

    output logic [1:0] who_won, //info for display (00 - I'm still standing, 10 - I won, 01 - I lost, 11 - I drew)
    output logic [7:0] lever_left_out,
    output wire [7:0] data_output, //send info to uart
    output logic current_player, // saved which player i am
    output logic [2:0] state,
    output logic [1:0] player0_health,
    output logic [1:0] player1_health,
    output logic [2:0] tableselected, // for now 8 tables
    output logic tx_start
    );

    reg [7:0] uart_state; //for updating changes in uart
    
    logic [7:0] uart_rx = 8'b00000000;
    logic [2:0] turn, turn_next;

//STATES
    typedef enum bit [2:0] {    
        INIT = 3'b000,
        MENU = 3'b001,
        PLAYER0 = 3'b011,
        PLAYER1 = 3'b010,
        GAMEEND = 3'b110,
        NEWGAME = 3'b100} game_state;

    game_state state_next;

    // signal declaration
    logic [7:0] uart_state_next;
    logic current_player_next;
    logic [2:0] tableselected_next;
    logic [7:0] lever_left_out_next;
    logic [1:0] player0_health_next;
    logic [1:0] player1_health_next;
    logic [1:0] who_won_next;


    // body
    always_ff@(posedge clk)
    if (rst)
        begin
            state <= INIT;
            uart_state <= 8'b00000000;
            current_player <= 1'b0;
            tableselected <= 3'b000;
            lever_left_out <= 8'b11111111;
            player0_health <= 2'b10;
            player1_health <= 2'b10;
            who_won <= 2'b00;
            turn <= 3'b000;
        end
    else
        begin
            state <= state_next;
            uart_state <= uart_state_next;
            current_player <= current_player_next;
            tableselected <= tableselected_next;
            lever_left_out <= lever_left_out_next;
            player1_health <= player1_health_next;
            player0_health <= player0_health_next;
            who_won <= who_won_next;
            turn <= turn_next;
        end
    
    always_comb
        begin
            //add signals
            case(state)
                INIT:
                    begin
                        who_won_next = who_won;
                        lever_left_out_next = lever_left_out;
                        player0_health_next = player0_health;
                        player1_health_next = player1_health;
                        turn_next = turn;

                        if(buttonL && buttonR == 1'b1) //button pressed
                            begin
                                state_next = MENU;
                                current_player_next = 1'b0;
                                uart_state_next = 8'b10000000; //I'm player_0 u re player_1
                                tx_start = 1'b1;
                            end
                        else if(uart_rx == 8'b10000000) //uart signal recived
                            begin
                                current_player_next = 1'b1; // I'm player_1
                                state_next = MENU;
                            end
                        else
                            begin
                                state_next = INIT;
                                tableselected_next =   + 1;
                            end
                    end
                MENU:
                    begin
                        tx_start = 1'b0;
                        if(current_player_next == 1'b0) //for player_0
                            begin
                            if((buttonL == 1'b1) && (buttonR == 1'b0) || (buttonL == 1'b0) && (buttonR == 1'b1)) //any button pressed
                                begin
                                    uart_state_next [3] = tableselected_next [0]; //code information to output for uart 
                                    uart_state_next [4] = tableselected_next [1];
                                    uart_state_next [5] = tableselected_next [2];
                                    uart_state_next [6] = 1'b1;
                                    state_next = PLAYER0;
                                    tx_start = 1'b1;
                                end
                            else
                                begin
                                    state_next = MENU;
                                end
                            end
                        else if(current_player_next == 1'b1 && uart_rx[6] == 1'b1) //for player_1
                            begin
                                    tableselected_next [0] = uart_rx [3]; //code information to the memory
                                    tableselected_next [1] = uart_rx [4];
                                    tableselected_next [2] = uart_rx [5];
                                    state_next = PLAYER0;
                            end
                        else    //added for safety
                            begin
                                state_next = MENU;
                            end
                    end                    
                PLAYER0:
                    begin
                        tx_start = 1'b0;
                        if(lever_left_out == 8'b00000000 || player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = GAMEEND;
                            end
                        else
                            begin
                            if(current_player_next == 1'b0)
                                begin
                                    if(turn_done == 1'b1)
                                        begin
                                            turn_next = turn + 1;// increment turn
                                            uart_state_next [7:0] = {lever_select, turn_next}; // save turn in uart /update uart which lever was pulled, lethality, target
                                                //lethality                      target
                                            if(uart_state_next[3] == 1'b0 && uart_state_next[7] == 1'b0)
                                                begin
                                                    player0_health_next = player0_health + 1;
                                                end
                                            else if(uart_state_next[3] == 1'b1 && uart_state_next[7] == 1'b0)
                                                begin
                                                    player0_health_next = player0_health - 1;
                                                end
                                            else if(uart_state_next[3] == 1'b0 && uart_state_next[7] == 1'b1)
                                                begin
                                                    player1_health_next = player1_health + 1;
                                                end
                                            else if(uart_state_next[3] == 1'b1 && uart_state_next[7] == 1'b1)
                                                begin
                                                    player1_health_next = player1_health - 1;
                                                end
                                                
                                            tx_start = 1'b1;
                                            lever_left_out_next[lever_select[3:1]] = 1'b0;
                                            state_next = PLAYER1;
                                            
                                        end
                                    else
                                        begin
                                            state_next = PLAYER0;
                                        end
                                end 
                            else if(current_player_next == 1'b1) 
                                begin
                                    if(uart_rx[2:0] > turn)
                                        begin
                                            turn_next = uart_rx[2:0]; // update turn on this device
                                            lever_left_out_next[uart_rx[6:4]] = 1'b0; //update which lever was pulled for lever_select module

                                            if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b0)
                                                begin
                                                    player0_health_next = player0_health + 1;
                                                end
                                            else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b0)
                                                begin
                                                    player0_health_next = player0_health - 1;
                                                end
                                            else if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b1)
                                                begin
                                                    player1_health_next = player1_health + 1;
                                                end
                                            else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b1)
                                                begin
                                                    player1_health_next = player1_health - 1;
                                                end
                                            
                                            
                                            state_next = PLAYER1;
                                        end
                                    else
                                        begin
                                            state_next = PLAYER0;
                                        end
                                end
                        end
                    end 
                PLAYER1:
                begin
                    tx_start = 1'b0;
                    if(lever_left_out == 8'b00000000 || player0_health == 2'b00 || player1_health == 2'b00)
                        begin
                            state_next = GAMEEND;
                        end
                    else
                        begin
                        if(current_player_next == 1'b1)
                            begin
                                if(turn_done == 1'b1)
                                    begin
                                        turn_next = turn + 1;// increment turn
                                        uart_state_next [7:0] = {lever_select, turn_next}; // save turn in uart /update uart which lever was pulled, lethality, target
                                                //lethality                      target
                                        if(uart_state_next[3] == 1'b0 && uart_state_next[7] == 1'b0)
                                            begin
                                                player0_health_next = player0_health + 1;
                                            end
                                        else if(uart_state_next[3] == 1'b1 && uart_state_next[7] == 1'b0)
                                            begin
                                                player0_health_next = player0_health - 1;
                                            end
                                        else if(uart_state_next[3] == 1'b0 && uart_state_next[7] == 1'b1)
                                            begin
                                                player1_health_next = player1_health + 1;
                                            end
                                        else if(uart_state_next[3] == 1'b1 && uart_state_next[7] == 1'b1)
                                            begin
                                                player1_health_next = player1_health - 1;
                                            end

                                        tx_start = 1'b1;
                                        lever_left_out_next[lever_select[3:1]] = 1'b0;
                                        state_next = PLAYER0;
                                    end
                                else
                                    begin
                                        state_next = PLAYER1;
                                    end
                            end 
                        else if(current_player_next == 1'b0) 
                            begin
                                if(uart_rx[2:0] > turn)
                                    begin
                                        turn_next = uart_rx[2:0]; // update turn on this device
                                        lever_left_out_next[uart_rx[6:4]] = 1'b0; //update which lever was pulled for lever_select module
                                            //lethality                      target
                                        if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b0)
                                            begin
                                                player0_health_next = player0_health + 1;
                                            end
                                        else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b0)
                                            begin
                                                player0_health_next = player0_health - 1;
                                            end
                                        else if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b1)
                                            begin
                                                player1_health_next = player1_health + 1;
                                            end
                                        else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b1)
                                            begin
                                                player1_health_next = player1_health - 1;
                                            end
                                        
                                        
                                        state_next = PLAYER0;
                                    end
                                else
                                    begin
                                        state_next = PLAYER1;
                                    end
                            end
                    end
                end
                GAMEEND:
                    begin
                        if(buttonU || buttonD || buttonL || buttonR == 1'b1)
                            begin
                                state_next = NEWGAME;
                            end
                        else
                            begin
                                state_next = GAMEEND;
                            end


                        if(current_player_next == 1'b0 && player0_health > player1_health)
                            begin
                                who_won_next = 2'b10;
                            end
                        else if(current_player_next == 1'b0 && player0_health < player1_health)
                            begin
                                who_won_next = 2'b01;
                            end
                        if(current_player_next == 1'b1 && player0_health < player1_health)
                            begin
                                who_won_next = 2'b10;
                            end
                        else if(current_player_next == 1'b1 && player0_health > player1_health)
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
                    end 
                NEWGAME:
                    begin
                        if(current_player_next == 1'b0 && (buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1)) //button pressed
                            begin
                                state_next = MENU;
                                uart_state_next = 8'b10000000;
                                lever_left_out_next = 8'b11111111;
                                player0_health_next = 2'b10;
                                player1_health_next = 2'b10;
                                turn_next = 3'b000;
                            end
                        else if(uart_rx == 8'b10000000) //uart signal recived
                            begin
                                current_player_next = 1'b1; // I'm player_1
                                state_next = MENU;
                                lever_left_out_next = 8'b11111111;
                                player0_health_next = 2'b10;
                                player1_health_next = 2'b10;
                                turn_next = 3'b000;
                            end
                        else
                            begin
                                state_next = INIT;
                                tableselected_next = tableselected + 1;
                            end
                    end
                default:
                    state_next = INIT;
            endcase
        end

    assign data_output = uart_state; // send everything to uart

endmodule