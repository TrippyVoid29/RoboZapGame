`timescale 1 ns / 1 ps

module lever_select #(
    
    logic position [2:0]

    )(
    input wire clk,
    input wire rst,
    input wire buttonU, //upper button
    input wire buttonD, //down button
    input wire buttonL, //left button
    input wire buttonR, //right button
    input reg [7:0] tablelethality,
    input logic [7:0] leverusedin, 

    output logic [7:0] leverusedout,
    output wire [3:0] leverselect

    );

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
                        else
                            state_next = idle;
                    end
                left:
                    begin

                    end
                right:
                    begin
                    end
                up:
                    begin
                    end
                down:
                    begin
                    end
                locked:
                    begin
                        
                    end
            endcase 
        end
endmodule
