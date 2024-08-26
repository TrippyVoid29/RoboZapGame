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
    output wire [1:0] who_won,
    output wire [2:0] state_output,
    output logic [2:0] position,
    output logic [7:0] lever_used_out,
    output wire current_player,
    output wire [1:0] player0_health,
    output wire [1:0] player1_health
    );

    wire turn_done;
    wire [2:0] tablecode;
    wire [4:0] lever_select;

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
        .tableselected(tablecode),
        .who_won,
        .lever_used_out,
        .state_output,
        .player0_health,
        .player1_health
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
        .lever_used_in(lever_used_out),
        .table_lethality(lethality_table),
        .turn_done(turn_done),
        .position
        
    );
    
    table_base u_table_base(
        .tablecode(tablecode),
        .table_lethality(lethality_table)
    );


endmodule