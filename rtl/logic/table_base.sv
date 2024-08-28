`timescale 1 ns / 1 ps

module table_base #(

    )(
    input logic [2:0] tablecode,

    output reg [7:0] table_lethality
    );

always_comb begin
    case (tablecode)
        3'b000: table_lethality = 8'b10101010;
        3'b001: table_lethality = 8'b01010101;
        3'b010: table_lethality = 8'b11001100;
        3'b011: table_lethality = 8'b00110011;
        3'b100: table_lethality = 8'b10011001;
        3'b101: table_lethality = 8'b01100110;
        3'b110: table_lethality = 8'b11100011;
        3'b111: table_lethality = 8'b00011110;
        default: table_lethality = 8'b00000000; // wartość domyślna
    endcase
end

endmodule