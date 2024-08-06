`timescale 1 ns / 1 ps

// microcode
// 0000 0000
// 0 - parity bit
// 1,2,3 - turn
// 4,5,6 - which switch
// 7 - who was targeted

module top_logic (
    input wire clk,
    input wire rst,
    input wire [7:0] uart_rx,
    
    output wire [7:0] data_output
    );

    game_state u_game_state(
        .clk,
        .rst,
        .gtablein,
        .uart_rx,
    
        .gtableout,
        .data_output
    );


endmodule