`timescale 1 ns / 1 ps

module buttons_handler (
    input wire clk,
    input wire rst,
    input wire buttonU, //UPper button
    input wire buttonD, //DOWN button
    input wire buttonL, //LEFT button
    input wire buttonR, //RIGHT button
    //input wire current_player,

    //input wire [2:0] game_state,

    output logic buttonL_pressed, buttonR_pressed, buttonD_pressed, buttonU_pressed

    );
    
        logic buttonL_pressed_next, buttonR_pressed_next, buttonD_pressed_next, buttonU_pressed_next;

    //STATES
    typedef enum bit [2:0] {    
        IDLE = 3'b000,
        LEFT = 3'b001,
        RIGHT = 3'b010,
        UP = 3'b011,
        DOWN = 3'b100} direction_state;

        direction_state state_current, state_next;

    // body
    always_ff@(posedge clk)
    if (rst)
       begin
          state_current <= IDLE;
          buttonL_pressed <= 1'b0;
          buttonR_pressed <= 1'b0;
          buttonD_pressed <= 1'b0;
          buttonU_pressed <= 1'b0;
       end
    else
       begin
          state_current <= state_next;
          buttonL_pressed <= buttonL_pressed_next;
          buttonR_pressed <= buttonR_pressed_next;
          buttonD_pressed <= buttonD_pressed_next;
          buttonU_pressed <= buttonU_pressed_next;
       end

    always_comb
        begin
            case(state_current)
                IDLE:
                    begin
                    buttonL_pressed_next = buttonL_pressed;
                    buttonR_pressed_next = buttonR_pressed;
                    buttonD_pressed_next = buttonD_pressed;
                    buttonU_pressed_next = buttonU_pressed;

                    if(buttonR == 1'b1 && buttonL == 1'b0 && buttonU == 1'b0 && buttonD == 1'b0)
                        begin
                            buttonR_pressed_next = 1'b1;
                            state_next = RIGHT;
                        end
                    else if(buttonR == 1'b0 && buttonL == 1'b1 && buttonU == 1'b0 && buttonD == 1'b0)
                        begin
                            buttonL_pressed_next = 1'b1;
                            state_next = LEFT;
                        end
                    else if(buttonR == 1'b0 && buttonL == 1'b0 && buttonU == 1'b1 && buttonD == 1'b0)
                        begin
                            buttonU_pressed_next = 1'b1;
                            state_next = UP;
                        end
                    else if(buttonR == 1'b0 && buttonL == 1'b0 && buttonU == 1'b0 && buttonD == 1'b1)
                        begin
                            buttonD_pressed_next = 1'b1;
                            state_next = DOWN;
                        end
                    else                    

                        state_next = IDLE;
                    end
                LEFT:
                    begin
                    buttonL_pressed_next = 1'b0;
                    if(buttonL == 1'b0) 
                        begin
                            state_next = IDLE;
                        end 
                    else begin
                            state_next = LEFT;
                        end
                    end
                RIGHT:
                    begin
                    buttonR_pressed_next = 1'b0;
                    if(buttonR == 1'b0)
                        begin
                            state_next = IDLE;
                        end 
                    else begin
                            state_next = RIGHT;
                        end
                    end
                UP:
                    begin
                    buttonU_pressed_next = 1'b0;
                    if(buttonU == 1'b0) 
                        begin
                            state_next = IDLE;
                        end 
                    else begin
                            state_next = UP;
                        end
                    end
                DOWN:
                    begin
                    buttonD_pressed_next = 1'b0;
                    if(buttonD == 1'b0) 
                        begin
                            state_next = IDLE;
                        end 
                    else begin
                            state_next = RIGHT;
                        end
                    end
                default:
                    state_next = IDLE;
            endcase 
        end

endmodule
