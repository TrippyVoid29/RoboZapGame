`timescale 1 ns / 1 ps

module lever_select #(

    )(
    input wire clk,
    input wire rst,
    input wire buttonU, //UPper button
    input wire buttonD, //DOWN button
    input wire buttonL, //LEFT button
    input wire buttonR, //RIGHT button
    input wire current_player,
    input wire [7:0] lever_left_in,
    input reg [7:0] table_lethality,
    input wire [2:0] game_state,

    output logic [4:0] lever_select,
    output logic turn_done,
    output logic [2:0] position = 3'b000

    );

    logic button_pressed, button_pressed_next;
    //logic turn, turn_next;

    logic lever_lethality;
    logic target;

    logic [2:0] position_next;
    logic [4:0] lever_select_next;
    logic turn_done_next;

    logic [2:0] state_current, state_next;

    //STATES
    localparam [2:0]
    IDLE = 3'b000,
    LEFT = 3'b001,
    RIGHT = 3'b010,
    LOCKED = 3'b011,
    UP = 3'b100,
    DOWN = 3'b101;

    // body
    always_ff@(posedge clk)
    if (rst)
       begin
          state_current <= IDLE;
          position <= 3'b000;
          //turn <= 1'b0;
          lever_select <= 5'b00000;
          turn_done <= 1'b0;
          button_pressed <= 1'b0;
       end
    else
       begin
          state_current <= state_next;
          position <= position_next;
          //turn <= turn_next;
          lever_select <= lever_select_next;
          turn_done <= turn_done_next;
          button_pressed <= button_pressed_next;
       end

    always_comb
        begin
            //add signals
            case(state_current)
                IDLE:
                    begin
                        position_next = position;
                        button_pressed_next = button_pressed;

                        if((game_state == 3'b011 && current_player == 1'b1) || (game_state == 3'b010 && current_player == 1'b0) )
                            begin
                                state_next = LOCKED;
                            end
                        else if((game_state == 3'b011 && current_player == 1'b0) || (game_state == 3'b010 && current_player == 1'b1))
                            begin
                                if(buttonR == 1'b1)
                                begin
                                    button_pressed_next = 1'b1;
                                    state_next = RIGHT;
                                end
                            else if(buttonL == 1'b1)
                                begin
                                    button_pressed_next = 1'b1;
                                    state_next = LEFT;
                                end
                            else if(buttonU == 1'b1)
                                begin
                                    button_pressed_next = 1'b1;
                                    state_next = UP;
                                end
                            else if(buttonD == 1'b1)
                                begin
                                    button_pressed_next = 1'b1;
                                    state_next = DOWN;
                                end
                            else
                                state_next = IDLE;
                            end
                        else
                            begin
                                state_next = IDLE;
                            end
                    end
                LEFT:
                    begin
                        if(buttonL == 1'b0 && button_pressed == 1'b1) 
                        begin
                            position_next = position - 1;
                            button_pressed_next = 0;
                            state_next = IDLE;
                        end else begin
                            state_next = LEFT;
                        end
                    end
                RIGHT:
                    begin
                        if(buttonR == 1'b0 && button_pressed == 1'b1) 
                        begin
                            position_next = position + 1;
                            button_pressed_next = 0;
                            state_next = IDLE;
                        end else begin
                            state_next = RIGHT;
                        end
                    end
                UP:
                    begin
                        if(lever_left_in[position_next] == 1'b1) begin
                            if(buttonU == 1'b0 && button_pressed == 1'b1) 
                            begin
                                lever_lethality = table_lethality[position_next];
                                state_next = LOCKED;
                                turn_done_next = 1'b1;
                                if(current_player == 1'b0)
                                begin
                                    target = 1'b1;
                                end 
                                else if(current_player == 1'b1)
                                begin
                                    target = 1'b0;
                                end
                                lever_select_next = {target, position, lever_lethality};
                            end else begin
                                state_next = UP;
                            end
                        end else if(lever_left_in[position_next] == 1'b0) begin
                            state_next = IDLE;
                        end
                    end
                DOWN:
                    begin
                        if(lever_left_in[position_next] == 1'b1) begin
                            if(buttonD == 1'b0 && button_pressed == 1'b1)
                            begin
                                lever_lethality = table_lethality[position_next];
                                state_next = LOCKED;
                                turn_done_next = 1'b1;
                                if(current_player == 1'b0) 
                                begin
                                    target = 1'b0;
                                end 
                                else if(current_player == 1'b1)
                                begin
                                    target = 1'b1;
                                end
                                lever_select_next = {target, position, lever_lethality};
                            end else begin
                                state_next = DOWN;
                            end
                        end else if(lever_left_in[position_next] == 1'b0) begin
                            state_next = IDLE;
                        end
                    end
                LOCKED:
                    begin
                        
                        turn_done_next = 1'b0;
                        //turn_next = ^lever_left_in;
                        button_pressed_next = 1'b0;

                        if(current_player == 1'b0 && game_state == 3'b011)
                            begin
                                state_next = IDLE;
                            end
                        else if(current_player == 1'b1 && game_state == 3'b010)
                            begin
                                state_next = IDLE;
                            end
                        else
                            state_next = LOCKED;
                    end
            endcase 
        end

        //assign lever_select = {target, position, lever_lethality};
        //assign turn_done = turn_done_next;
        //assign state_current_lever = state_next;
endmodule
