`timescale 1 ns / 1 ps

module levers_info (
    input wire clk,
    input wire rst,

    input wire [2:0] position,

    input wire lever_used,

    input wire [1:0] game_state_in,

    input wire [7:0] lever_lethality,

    output logic [1:0] lever_info // lethality, usability
);

//local signals
logic [7:0] lever_left, lever_left_next;
logic is_lethal, is_lethal_next;
logic is_usable, is_usable_next;

always_ff@(posedge clk)
    if (rst)
        begin
            is_usable <= 1'b0;
            is_lethal <= 1'b0;
            lever_left <= 8'b11111111;
            lever_info <= 2'b00;
        end
    else 
        begin
            lever_left <= lever_left_next;
            is_lethal <= is_lethal_next;
            is_usable <= is_usable_next;
            lever_info <= {is_lethal, is_usable};
        end

    always_comb
        begin
            if(game_state_in == 2'b01)
                begin
                    if(lever_used == 1'b1)
                        begin
                            lever_left_next[position] = 1'b0;
                        end
                    is_lethal_next = lever_lethality[position];
                    is_usable_next = lever_left[position];
                end
            else
                begin
                    is_lethal_next = is_lethal;
                    is_usable_next = is_usable;
                end
        end
endmodule