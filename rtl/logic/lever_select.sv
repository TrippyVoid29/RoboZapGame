`timescale 1 ns / 1 ps

module lever_select #(
    
    logic [2:0] position ,
    logic target
    

    )(
    input wire clk,
    input wire rst,
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button
    input wire current_player,
    input logic [7:0] lever_used_in,
    input reg [7:0] table_lethality, 

    output wire [3:0] lever_select,
    output logic lever_lethality

    );

    logic turn = ^lever_used_in;

    //STATES
    localparam [2:0]
    idle = 3'b000,
    left = 3'b001,
    right = 3'b010,
    locked = 3'b011,
    up = 3'b100,
    down = 3'b101;

    logic [2:0] state_current, state_next;

    // body
    always @(posedge clk, posedge rst)
    if (rst)
       begin
          state_current <= idle;
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
                idle:
                    begin
                        if(buttonR == 1'b1)
                            begin
                                state_next = right;
                            end
                        else if(buttonL == 1'b1)
                            begin
                                state_next = left;
                            end
                        else if(buttonU == 1'b1)
                            begin
                                state_next = up;
                            end
                        else if(buttonD == 1'b1)
                            begin
                                state_next = down;
                            end
                        else if(current_player == turn)
                            begin
                                state_next = locked;
                            end
                        else
                            state_next = idle;
                    end
                left:
                    begin
                        position = position - 1;
                        state_next = idle;
                    end
                right:
                    begin
                        position = position + 1;
                        state_next = idle;
                    end
                up:
                    begin
                        lever_lethality = table_lethality[position - 1];
                        target = 1'b1;
                        state_next = locked;
                    end
                down:
                    begin
                        lever_lethality = table_lethality[position - 1];
                        target = 1'b0;
                        state_next = locked;
                    end
                locked:
                    begin
                        if(current_player != turn)
                            begin
                                state_next = idle;
                            end
                            else
                                state_next = locked;
                    end
            endcase 
        end

        assign lever_select = {position, target};

endmodule
