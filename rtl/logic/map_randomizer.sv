/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Levers lethality selector.
 */

`timescale 1 ns / 1 ps

module map_randomizer (

    input wire clk,
    input wire rst,
    input wire [1:0] state_input,

    output logic [7:0] table_lethality
    );

logic [2:0] map_number;

always_ff@(posedge clk)
    if (rst)
        begin
            map_number <= 3'b000;
        end
    else if(state_input == 2'b00)
        begin
            map_number <= map_number + 1;
        end
    else
        begin
            map_number <= map_number;
        end

always_comb begin
    case (map_number)
        /*
        3'b000: table_lethality = 8'b10101011;
        3'b001: table_lethality = 8'b01011101;
        3'b010: table_lethality = 8'b11001101;
        3'b011: table_lethality = 8'b01110011;
        3'b100: table_lethality = 8'b11011001;
        3'b101: table_lethality = 8'b01110110;
        3'b110: table_lethality = 8'b11101011;
        3'b111: table_lethality = 8'b01011110;
        */
        default: table_lethality = 8'b11111111; // wartość domyślna
    endcase
end

endmodule