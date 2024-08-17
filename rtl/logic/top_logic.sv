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
    input wire buttonU, buttonD, buttonL, buttonR, buttonC,

    
    output wire [7:0] data_output,
    output wire [1:0] who_won
    );

    wire current_player, turn_done;
    wire [2:0] tablecode;
    wire [4:0] lever_select;
    wire [7:0] lever_used;

    game_state u_game_state(
        .clk,
        .rst,
        .uart_rx,
        .buttonU,
        .buttonD,
        .buttonL,
        .buttonR,
        .buttonC,
        .lever_select(lever_select),
        .turn_done(turn_done),
        
        .data_output,
        .current_player(current_player),
        .tablecode(tablecode),
        .who_won,
        .lever_used_out(lever_used)
    );

    wire [7:0] lethality_table;
    

    lever_select u_lever_select(
        .clk,
        .rst,
        .buttonD,
        .buttonL,
        .buttonR,
        .buttonU,
        .current_player(current_player),
        .lever_select(lever_select),
        .lever_used_in(lever_used),
        .table_lethality(lethality_table),
        .turn_done(turn_done)
        
    );
    
    table_base u_table_base(
        .tablecode(tablecode),
        .table_lethality(lethality_table)
    );


endmodule