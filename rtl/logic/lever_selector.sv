`timescale 1 ns / 1 ps

module lever_selector (

    input wire clk,
    input wire rst,

    input wire buttonL,
    input wire buttonR,

    input wire [1:0] game_state_in,

    output logic [2:0] position
);

//local signals

logic [1:0] state, state_next;
logic [2:0] position_next;

//STATES
typedef enum bit [1:0] {    
    IDLE = 2'b00,
    LEFT = 2'b01,
    RIGHT = 2'b10} enum_direction;

always_ff@(posedge clk)
    if (rst)
        begin
            state <= IDLE;
            position <= 3'b000;
        end
    else
        begin
            state <= state_next;
            position <= position_next;
        end

always_comb
    begin
        case(state)
            IDLE:
                begin
                    position_next = position;

                    if(game_state_in == 2'b01)
                        begin
                            if(buttonL == 1'b1)
                                begin
                                state_next = LEFT;
                                end
                            else if(buttonR == 1'b1)
                                begin
                                state_next = RIGHT;
                                end
                            else
                                begin
                                state_next = IDLE;
                                end
                        end
                    else
                        begin
                            state_next = IDLE;
                            position_next = 3'b000;
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
        endcase
    end

endmodule