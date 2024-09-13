/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Info about usage UP and DOWN Buttons.
 */

`timescale 1 ns / 1 ps

module target (
    
    input wire clk,
    input wire rst,

    input wire buttonU,
    input wire buttonD,

    input wire [1:0] game_state_in,
    input wire [7:0] lever_left_in,
    input wire [2:0] position,
    input wire player_selected,
    input wire turn_in,
    input wire target_uart,
    input wire lever_used_uart,

    output logic target,
    output logic turn_flag,
    output logic lever_used
    
);

    //STATES
    typedef enum bit [1:0] {    
        IDLE = 2'b00,
        UP = 2'b01,
        DOWN = 2'b10} enum_direction;


    logic [1:0] state, state_next;
    logic turn_next, target_next, lever_used_next;

always_ff @(posedge clk)
begin
    if(rst)
        begin
        turn_flag <= 1'b0;
        state <= 2'b00;
        target <= 1'b0;
        lever_used <= 1'b0;
        end
    else
        begin   
            if(turn_in == player_selected)
                begin
                    state <= state_next;
                    turn_flag <= turn_next;
                    target <= target_next;
                    lever_used <= lever_used_next;
                end
            else
                begin
                    state <= state_next;
                    turn_flag <= turn_next;
                    target <= target_uart;
                    lever_used <= lever_used_next;
                end
        end
end

always_comb
    begin
        case(state)
            IDLE:
                begin
                    turn_next = turn_flag;
                    target_next = target;                   
                    
                    if(game_state_in == 2'b01)
                        begin
                            if(buttonU == 1'b1)
                                begin
                                    if(player_selected == turn_in)
                                        state_next = UP;
                                    else
                                        state_next = IDLE;
                                end
                            else if(buttonD == 1'b1)
                                begin
                                    if(player_selected == turn_in)
                                        state_next = DOWN;
                                    else
                                        state_next = IDLE;
                                end
                            else
                                state_next = IDLE;
                                lever_used_next = 1'b0;
                                turn_next = 1'b0;
                        end
                    else
                        begin                            
                            state_next = IDLE;
                            lever_used_next = 1'b0;
                            turn_next = 1'b0;
                            target_next = 1'b0;

                        end

                end
            UP:
                begin
                    if(turn_in == 1'b0)
                        target_next = 1'b1;
                    else
                        target_next = 1'b0;

                    lever_used_next = 1'b1;
                    if(lever_left_in[position] == 1'b1)
                        turn_next = 1'b1;
                    else
                        turn_next = 1'b0;
                    state_next = IDLE;
                    
                end
            DOWN:
                begin
                    if(turn_in == 1'b0)
                        target_next = 1'b0;
                    else
                        target_next = 1'b1;
                    
                    lever_used_next = 1'b1;
                    turn_next = 1'b0;
                    state_next = IDLE;
                end 
        endcase
    end

endmodule