`timescale 1 ns / 1 ps

module lever_select #(

    )(
    input wire clk,
    input wire rst,
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button
    input wire current_player,
    input wire [7:0] lever_used_in,
    input reg [7:0] table_lethality, 

    output wire [4:0] lever_select,
    output logic turn_done,
    output logic [2:0] position = 3'b000,
    output logic [2:0] state_current_lever
    

    );

    logic turn = 1'b0;
    logic turn_next = 1'b0;
    logic lever_lethality;
    logic target;
    logic turn_done_flag =1'b0;
    logic button_pressed = 0;
    logic [2:0] position_next = 3'b000;

    //STATES
    localparam [2:0]
    idle = 3'b000,
    left = 3'b001,
    right = 3'b010,
    locked = 3'b011,
    up = 3'b100,
    down = 3'b101;

    logic [2:0] state_current, state_next = idle;

    // body
    always @(posedge clk, posedge rst)
    if (rst)
       begin
          state_current <= idle;
          position <= 3'b000;
          turn <= 1'b0;
       end
    else
       begin
          state_current <= state_next;
          position <= position_next;
          turn <= turn_next;
          //add signals
       end

    always @*
        begin
            
            //add signals
            case(state_current)
                idle:
                    begin
                        if(buttonR == 1'b1)
                            begin
                                button_pressed = 1'b1;
                                state_next = right;
                            end
                        else if(buttonL == 1'b1)
                            begin
                                button_pressed = 1'b1;
                                state_next = left;
                            end
                        else if(buttonU == 1'b1)
                            begin
                                button_pressed = 1'b1;
                                state_next = up;
                            end
                        else if(buttonD == 1'b1)
                            begin
                                button_pressed = 1'b1;
                                state_next = down;
                            end
                        else if(current_player != turn)
                            begin
                                state_next = locked;
                            end
                        else
                            state_next = idle;
                    end
                left:
                    begin
                        if(buttonL == 1'b0 && button_pressed == 1'b1) 
                        begin
                            position_next = position - 1;
                            button_pressed = 0;
                            state_next = idle;
                        end else begin
                            state_next = left;
                        end
                    end
                right:
                    begin
                        if(buttonR == 1'b0 && button_pressed == 1'b1) 
                        begin
                            position_next = position + 1;
                            button_pressed = 0;
                            state_next = idle;
                        end else begin
                            state_next = right;
                        end
                    end
                up:
                    begin
                        if(lever_used_in[position_next] == 1'b1) begin
                            if(buttonU == 1'b0 && button_pressed == 1'b1) 
                            begin
                                lever_lethality = table_lethality[position_next];
                                state_next = locked;
                                turn_done_flag = 1'b1;
                                if(current_player == 1'b0)
                                begin
                                    target = 1'b1;
                                end 
                                else if(current_player == 1'b1)
                                begin
                                    target = 1'b0;
                                end
                            end else begin
                                state_next = up;
                            end
                        end else if(lever_used_in[position_next] == 1'b0) begin
                            state_next = idle;
                        end
                    end
                down:
                    begin
                        if(lever_used_in[position_next] == 1'b1) begin
                            if(buttonD == 1'b0 && button_pressed == 1'b1)
                            begin
                                lever_lethality = table_lethality[position_next];
                                state_next = locked;
                                turn_done_flag = 1'b1;
                                if(current_player == 1'b0) 
                                begin
                                    target = 1'b0;
                                end 
                                else if(current_player == 1'b1)
                                begin
                                    target = 1'b1;
                                end
                            end else begin
                                state_next = down;
                            end
                        end else if(lever_used_in[position_next] == 1'b0) begin
                            state_next = idle;
                        end
                    end
                locked:
                    begin
                        turn_done_flag = 1'b0;
                        turn_next = ^lever_used_in;
                        if(current_player == turn)
                            begin
                                state_next = idle;
                            end
                            else
                                state_next = locked;
                    end
            endcase 
        end

        assign lever_select = {target, position, lever_lethality};
        assign turn_done = turn_done_flag;
        assign state_current_lever = state_next;
endmodule
