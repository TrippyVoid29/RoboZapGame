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

    logic uart_state = 8'b00000000, 
    logic tableselected = 3'b000 // for now 8 tables

    )(
    input wire clk,
    input wire rst,
    input wire gtablein,
    input wire [7:0] uart_rx,
    input wire buttonC, //middle button RST?
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button

    output wire gtableout,
    output wire [7:0] data_output
    );

//STATES
    localparam [2:0]
    init = 3'b000, // wait for action, starts clock for table selector
    start = 3'b001, // sends info who is player0 and player1, open menu on dispaly ---IS THIS STATE NEEDED?---
    menu = 3'b011, // wait for start, table selector clock
    setup = 3'b010, // send table with level data
    player0 = 3'b110, // turn of player0
    player1 = 3'b100, // turn of player1
    gameend = 3'b101, // game end
    newgame = 3'b111; // new game


    // signal declaration
    logic [2:0] state_current, state_next;

    // body
    always @(posedge clk, posedge rst)
    if (rst)
       begin
          state_current <= init;
          //add signals
          uart_state <= 8'b00000000;
       end
    else
       begin
          state_current <= state_next;
          //add signals
       end
    
    always @*
        begin
            state_next = state_current;
            //send info to uart
            //add signals
            case(state_current)
                init:
                    begin
                        if(/*any button used TO DO*/0)
                            begin
                                state_next = start;
                            end
                        else
                            begin
                                state_next = init;
                                tableselected = tableselected + 1;
                            end
                    end
                start:
                    begin
                        uart_state = 8'b10000000; //to output for uart
                        state_next = menu;
                    end
                menu:
                    begin
                    end            
                setup:
                    begin
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