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
    input wire [7:0] uart_rx,        //info received from uart
    //input logic [7:0] lever_used_in, // which lever was used: 1- when unused, 0 - when used
    input wire [4:0] lever_select,
    input wire buttonC, //middle button
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button
    input wire turn_done, // if turn was done 1-Y, 0-N

    output logic [1:0] who_won = 2'b00, //info for display (00 - I'm still standing, 10 - I won, 01 - I lost, 11 - I drew)
    output logic [7:0] lever_used_out,
    output wire [7:0] data_output, //send info to uart
    output logic [2:0] tablecode,   //code for table selector
    output logic current_player = 1'b0 // saved which player i am
    );

    reg [7:0] uart_state = 8'b00000000; //for updating changes in uart
    logic [2:0] tableselected = 3'b000; // for now 8 tables
    logic [1:0] player0_health = 2'b10;
    logic [1:0] player1_health = 2'b10;
    logic [2:0] turn = 3'b000;

//STATES
    localparam [2:0]
    init = 3'b000, // wait for action (button) = sends info who is player0 and player1, starts counter for table selector
    menu = 3'b001, // open menu on dispaly, wait for button to start game = get value for table counter, send/receive table with level data
    player0 = 3'b011, // turn of player0, even turns
    player1 = 3'b010, // turn of player1, odd turns
    gameend = 3'b110, // game end
    newgame = 3'b100; // new game

    // signal declaration
    logic [2:0] state_current, state_next;

    // body
    always @(posedge clk, posedge rst)
    if (rst)
       begin
          state_current <= init;
          tablecode <= 3'b000;
          //add signals
          uart_state <= 8'b00000000;
          current_player <= 1'b0;
       end
    else
       begin
          state_current <= state_next;
          uart_state <= uart_state;
          current_player <= current_player;
          tablecode <= tablecode;
          //add signals
       end
    
    always @*
        begin
            //send info to uart
            
            //add signals
            case(state_current)
                init:
                    begin
                        if( buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1) //button pressed
                            begin
                                state_next = menu;
                                current_player = 1'b0;
                                uart_state = 8'b10000000; //I'm player_0 u re player_1
                            end
                        else if(uart_rx == 8'b10000000) //uart signal recived
                            begin
                                current_player = 1'b1; // I'm player_1
                                state_next = menu;
                            end
                        else
                            begin
                                state_next = init;
                                tableselected = tableselected + 1;
                            end
                        lever_used_out = 8'b11111111;
                    end
                menu:
                    begin
                        if(current_player == 1'b0) //for player_0
                            begin
                            if(buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1) //any button pressed
                                begin
                                    uart_state [3] = tableselected [0]; //code information to output for uart 
                                    uart_state [4] = tableselected [1];
                                    uart_state [5] = tableselected [2];
                                    uart_state [6] = 1'b1;
                                    state_next = player0;
                                end
                            else
                                begin
                                    state_next = menu;
                                end
                            end
                        else if(current_player == 1'b1 && uart_rx[6] == 1'b1) //for player_1
                            begin
                                    tableselected [0] = uart_rx [3]; //code information to the memory
                                    tableselected [1] = uart_rx [4];
                                    tableselected [2] = uart_rx [5];
                                    state_next = player0;
                            end
                        else    //added for safety
                            begin
                                state_next = menu;
                            end
                        //tablecode [0:2] = tableselected [2:0]; // send info about lever pos to lever selected
                        tablecode [0] = tableselected [0];
                        tablecode [1] = tableselected [1];
                        tablecode [2] = tableselected [2];
                    end                    
                player0:
                    begin
                        if(uart_state == 8'b111xxxxx || player0_health == 2'b00 || player1_health == 2'b00)
                            begin
                                state_next = gameend;
                            end
                        else
                            begin
                            if(current_player == 1'b0)
                                begin
                                    if(turn_done == 1'b1)
                                        begin
                                            turn = turn + 1;// increment turn
                                            uart_state [7:0] = {turn, lever_select}; // save turn in uart /update uart which lever was pulled, lethality, target

                                            if(uart_state[3] == 1'b0 && uart_state[7] == 1'b0)
                                                begin
                                                    player0_health = player0_health + 1;
                                                end
                                            else if(uart_state[3] == 1'b1 && uart_state[7] == 1'b0)
                                                begin
                                                    player0_health = player0_health - 1;
                                                end
                                            else if(uart_state[3] == 1'b0 && uart_state[7] == 1'b1)
                                                begin
                                                    player1_health = player1_health + 1;
                                                end
                                            else if(uart_state[3] == 1'b1 && uart_state[7] == 1'b1)
                                                begin
                                                    player1_health = player1_health - 1;
                                                end
                                            
                                            state_next = player1;
                                        end
                                    else
                                        begin
                                            state_next = player0;
                                        end
                                end 
                            else if(current_player == 1'b1) 
                                begin
                                    if(uart_rx[2:0] > turn)
                                        begin
                                            turn = uart_rx[2:0]; // update turn on this device
                                            lever_used_out[uart_rx[6:4]] = 1'b0; //update which lever was pulled for lever_select module

                                            if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b0)
                                                begin
                                                    player0_health = player0_health + 1;
                                                end
                                            else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b0)
                                                begin
                                                    player0_health = player0_health - 1;
                                                end
                                            else if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b1)
                                                begin
                                                    player1_health = player1_health + 1;
                                                end
                                            else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b1)
                                                begin
                                                    player1_health = player1_health - 1;
                                                end
                                            
                                            
                                            state_next = player1;
                                        end
                                    else
                                        begin
                                            state_next = player0;
                                        end
                                end
                        end
                    end 
                player1:
                begin
                    if(uart_state == 8'b111xxxxx || player0_health == 2'b00 || player1_health == 2'b00)
                        begin
                            state_next = gameend;
                        end
                    else
                        begin
                        if(current_player == 1'b1)
                            begin
                                if(turn_done == 1'b1)
                                    begin
                                        turn = turn + 1;// increment turn
                                        uart_state [7:0] = {turn, lever_select}; // save turn in uart /update uart which lever was pulled, lethality, target

                                        if(uart_state[3] == 1'b0 && uart_state[7] == 1'b0)
                                            begin
                                                player0_health = player0_health + 1;
                                            end
                                        else if(uart_state[3] == 1'b1 && uart_state[7] == 1'b0)
                                            begin
                                                player0_health = player0_health - 1;
                                            end
                                        else if(uart_state[3] == 1'b0 && uart_state[7] == 1'b1)
                                            begin
                                                player1_health = player1_health + 1;
                                            end
                                        else if(uart_state[3] == 1'b1 && uart_state[7] == 1'b1)
                                            begin
                                                player1_health = player1_health - 1;
                                            end
                                        
                                        state_next = player1;
                                    end
                                else
                                    begin
                                        state_next = player0;
                                    end
                            end 
                        else if(current_player == 1'b0) 
                            begin
                                if(uart_rx[2:0] > turn)
                                    begin
                                        turn = uart_rx[2:0]; // update turn on this device
                                        lever_used_out[uart_rx[6:4]] = 1'b0; //update which lever was pulled for lever_select module

                                        if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b0)
                                            begin
                                                player0_health = player0_health + 1;
                                            end
                                        else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b0)
                                            begin
                                                player0_health = player0_health - 1;
                                            end
                                        else if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b1)
                                            begin
                                                player1_health = player1_health + 1;
                                            end
                                        else if(uart_rx[3] == 1'b1 && uart_rx[7] == 1'b1)
                                            begin
                                                player1_health = player1_health - 1;
                                            end
                                        
                                        
                                        state_next = player1;
                                    end
                                else
                                    begin
                                        state_next = player0;
                                    end
                            end
                    end
                end
                gameend:
                    begin
                        if(buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1)
                            begin
                                state_next = newgame;
                            end
                        else
                            begin
                                state_next = gameend;
                            end


                        if(current_player == 1'b0 && player0_health > player1_health)
                            begin
                                who_won = 2'b10;
                            end
                        else if(current_player == 1'b0 && player0_health < player1_health)
                            begin
                                who_won = 2'b01;
                            end
                        if(current_player == 1'b1 && player0_health < player1_health)
                            begin
                                who_won = 2'b10;
                            end
                        else if(current_player == 1'b1 && player0_health > player1_health)
                            begin
                                who_won = 2'b01;
                            end
                        else if(player0_health == player1_health)
                            begin
                                who_won = 2'b11;
                            end
                        else
                            begin
                                who_won = 2'b00;
                            end
                    end 
                newgame:
                    begin
                        if(current_player == 1'b0 && (buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1)) //button pressed
                            begin
                                state_next = menu;
                                uart_state = 8'b10000000;
                                lever_used_out = 8'b11111111;
                                player0_health = 2'b10;
                                player1_health = 2'b10;
                                turn = 3'b000;
                            end
                        else if(uart_rx == 8'b10000000) //uart signal recived
                            begin
                                current_player = 1'b1; // I'm player_1
                                state_next = menu;
                                lever_used_out = 8'b11111111;
                                player0_health = 2'b10;
                                player1_health = 2'b10;
                                turn = 3'b000;
                            end
                        else
                            begin
                                state_next = init;
                                tableselected = tableselected + 1;
                            end
                    end
            endcase
        end

    assign data_output = uart_state; // send everything to uart

endmodule