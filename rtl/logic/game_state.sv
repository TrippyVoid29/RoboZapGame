`timescale 1 ns / 1 ps

// microcode
// 0000 0000
// 0 - parity bit
// 1,2,3 - turn
// 4,5,6 - which switch
// 7 - who was targeted

// code for reset = 0000 0000
// code for player set = 1000 0000

module game_state #(

    logic [7:0] uart_state = 8'b00000000, 
    logic [2:0] tableselected = 3'b000, // for now 8 tables
    logic current_player = 1'b0 // saved which player i am

    )(
    input wire clk,
    input wire rst,
    //input wire gtablein,
    input wire [7:0] uart_rx,
    input logic [7:0] lever_used_in, // which lever was used: 1- when unused, 0 - when used
    input reg [7:0] table_lethality,
    input wire buttonC, //middle button
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button

    //output wire gtableout,
    output logic [7:0] lever_used_out,
    output wire [7:0] data_output,
    output logic [2:0] tablecode
    );

//STATES
    localparam [2:0]
    init = 3'b000, // wait for action (button) = sends info who is player0 and player1, starts counter for table selector
    menu = 3'b001, // open menu on dispaly, wait for button to start game = get value for table counter, send/receive table with level data
    player0 = 3'b011, // turn of player0
    player1 = 3'b010, // turn of player1
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
                    end
                menu:
                    begin
                        if(current_player == 1'b0) //for player_0
                            begin
                            if(buttonU || buttonD || buttonL || buttonR || buttonC == 1'b1) //any button pressed
                                begin
                                    uart_state [0] = tableselected [0]; //code information to output for uart 
                                    uart_state [1] = tableselected [1];
                                    uart_state [2] = tableselected [2];
                                    state_next = player0;
                                end
                            else
                                begin
                                    state_next = menu;
                                end
                            end
                        else if(current_player == 1'b1) //for player_1
                            begin
                                    tableselected [0] = uart_rx [0]; //code information to the memory
                                    tableselected [1] = uart_rx [1];
                                    tableselected [2] = uart_rx [2];
                                    state_next = player0;
                            end
                        else    //added for safety
                            begin
                                state_next = menu;
                            end
                        tablecode [0:2] = tableselected [2:0]; // send info about lever pos to lever selected
                    end                    
                player0:
                    begin
                    end 
                player1:
                    begin
                    end
                gameend:
                    begin
                    end 
                newgame:
                    begin
                    end
            endcase
        end

    assign data_output = uart_state; // send everything to uart

endmodule