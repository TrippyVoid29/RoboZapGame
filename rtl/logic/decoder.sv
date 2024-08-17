`timescale 1 ns / 1 ps

module decoder (
    input wire [3:0] lever_select,    

    output reg [7:0] lever_used_out 
);

    logic [2:0] temporary_position;

always @(*) begin
    temporary_position = lever_select [2:0];
    lever_used_out = 8'b00000001 << temporary_position; // Przesunięcie bitu o ilość pozycji równą input_val
end

//gej

endmodule