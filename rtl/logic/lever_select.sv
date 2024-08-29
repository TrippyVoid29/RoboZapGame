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
    output logic [2:0] position

    );
    //logic turn, turn_next;

    logic lever_lethality, lever_lethality_next;
    logic target, target_next;

    logic [2:0] position_next;
    logic [4:0] lever_select_next;
    logic turn_done_next;

    //STATES
    typedef enum bit [2:0] {    
        IDLE = 3'b000,
        LEFT = 3'b001,
        RIGHT = 3'b010,
        LOCKED = 3'b011,
        UP = 3'b100,
        DOWN = 3'b101} direction_state;

        direction_state state_current, state_next;


    // body
    always_ff@(posedge clk)
    if (rst)
       begin
          state_current <= IDLE;
          position <= 3'b000;
          lever_select <= 5'b00000;
          turn_done <= 1'b0;
          lever_lethality <= 1'b0;
          target <= 1'b0;
       end
    else
       begin
          state_current <= state_next;
          position <= position_next;
          lever_select <= lever_select_next;
          turn_done <= turn_done_next;
          lever_lethality <= lever_lethality_next;
          target <= target_next;
       end

    always_comb
        begin
            //add signals
            case(state_current)
                IDLE:
                    begin
                        position_next = position;

                        if((game_state == 3'b011 && current_player == 1'b0) || (game_state == 3'b010 && current_player == 1'b1))
                            begin
                            if(buttonR == 1'b1)
                                begin
                                    state_next = RIGHT;
                                end
                            else if(buttonL == 1'b1)
                                begin
                                    state_next = LEFT;
                                end
                            else if(buttonU == 1'b1)
                                begin
                                    state_next = UP;
                                end
                            else if(buttonD == 1'b1)
                                begin
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
                        position_next = position - 1;
                        state_next = IDLE;
                    end
                RIGHT:
                    begin
                        position_next = position + 1;
                        state_next = IDLE;
                    end
                UP:
                    begin
                        if(lever_left_in[position] == 1'b1) begin
                            lever_lethality_next = table_lethality[position];
                            turn_done_next = 1'b1;
                            if(current_player == 1'b0)
                                begin
                                    target_next = 1'b1;
                                end 
                            else if(current_player == 1'b1)
                                begin
                                    target_next = 1'b0;
                                end
                            state_next = LOCKED;

                        end else if(lever_left_in[position] == 1'b0) begin
                            state_next = IDLE;
                        end
                    end
                DOWN:
                    begin
                        if(lever_left_in[position] == 1'b1) begin
                            turn_done_next = 1'b1;
                            if(current_player == 1'b0) 
                                begin
                                    target_next = 1'b0;
                                end 
                            else if(current_player == 1'b1)
                                begin
                                    target_next = 1'b1;
                                end
                            state_next = LOCKED;

                        end else if(lever_left_in[position] == 1'b0) begin
                            state_next = IDLE;
                        end
                    end
                LOCKED:
                    begin
                        lever_select_next = {target, position, lever_lethality};
                        turn_done_next = 1'b0;
                        state_next = IDLE;

                    end
                default:
                    state_next = IDLE;
            endcase 
        end

endmodule
