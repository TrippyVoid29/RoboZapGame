`timescale 1 ns / 1 ps

module game_state (
    input wire clk,
    input wire rst,

    input wire start_game,
    input wire end_game,
    input wire new_game,

    output logic [1:0] state_output
);

//STATES
typedef enum bit [1:0] {    
    INIT = 2'b00,
    GAME = 2'b01,
    GAME_END = 2'b10} egame_state;


//local signals
logic [1:0] state, state_next;


always_ff@(posedge clk)
    if (rst)
        begin
            state <= INIT;
            state_output <= INIT;
        end
    else
        begin
            state <= state_next;
            state_output <= state_next;
        end

    always_comb
        begin
            case(state)
                INIT:
                begin
                    if(start_game == 1'b1)
                        begin
                            state_next = GAME;
                        end
                    else
                        begin
                            state_next = INIT;
                        end
                end
                GAME:
                begin
                    if(end_game == 1'b1)
                        begin
                            state_next = GAME_END;
                        end
                    else
                        begin
                            state_next = GAME;
                        end
                end
                GAME_END:
                begin
                    if(new_game == 1'b1)
                        begin
                            state_next = INIT;
                        end
                    else
                        begin
                            state_next = GAME_END;
                        end
                end
            endcase
        end

endmodule