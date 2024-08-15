`timescale 1 ns / 1 ps

module table_base #(

    )(
    input logic [2:0] tablecode,

    output reg [7:0] tablelethality
    );

always @(*) begin
    case (tablecode)
        3'b000: tablelethality = 8'b10101010;
        3'b001: tablelethality = 8'b01010101;
        3'b010: tablelethality = 8'b11001100;
        3'b011: tablelethality = 8'b00110011;
        3'b100: tablelethality = 8'b10011001;
        3'b101: tablelethality = 8'b01100110;
        3'b110: tablelethality = 8'b11100011;
        3'b111: tablelethality = 8'b00011110;
        default: tablelethality = 8'b00000000; // wartość domyślna
    endcase
end

endmodule