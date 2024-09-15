/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: �?ukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Top logic module.
 */

`timescale 1 ns / 1 ps

module top_logic (

    input wire clk,
    input wire rst,
    input wire buttonD, buttonU, buttonR, buttonL,
    input wire [7:0] uart_in, //new
    input wire tx_done,
    input wire mouse_left,
    input wire mouse_right,

    output logic turn,
    output logic [1:0] winner,
    output logic [1:0] player0_health,
    output logic [1:0] player1_health,
    output logic [7:0] lever_left,
    output logic [2:0] position,
    output logic [1:0] state_output,
    output logic player_selected,

    output logic [7:0] uart_out,
    output logic tx_start

);

    wire start_game, end_game, new_game;
    wire target_wire, lever_used, turn_flag;
    wire [1:0] lever_info, usability_uart;
    wire turn_uart, lever_used_uart, target_uart;
    wire [2:0] position_uart;
    
    wire buttonD_P, buttonU_P, buttonR_P, buttonL_P;
    wire [7:0] levers_lethality;
    wire data_received_wire;

//uart wires


game_state u_game_state(
    .clk,
    .rst,
    .start_game,
    .end_game,
    .new_game,

    .state_output
);

buttons_handler u_buttons_handler(
    .buttonD,
    .buttonU,
    .buttonR,
    .buttonL,
    .clk,
    .rst,
    .mouse_left,
    .mouse_right,

    .buttonD_pressed(buttonD_P),
    .buttonL_pressed(buttonL_P),
    .buttonR_pressed(buttonR_P),
    .buttonU_pressed(buttonU_P)

);

start_game u_start_game(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .buttonR(buttonR_P),
    .state_input(state_output),

    .start_game_out(start_game),
    .player_selected
);

new_game u_new_game(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .state_input(state_output),
    .new_game_out(new_game)
);

lever_selector u_lever_selector(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .buttonR(buttonR_P),
    .game_state_in(state_output),
    .player_selected,
    .position_uart,
    .turn,

    .position(position)
);

map_randomizer u_map_randomizer(
    .clk,
    .rst,
    .state_input(state_output),

    .table_lethality(levers_lethality)
);

levers_info u_levers_info(
    .clk,
    .rst,
    .position(position),
    .lever_used(lever_used),
    .game_state_in(state_output),
    .levers_lethality(levers_lethality),
    .player_selected,
    .turn_in(turn),
    .lever_used_uart,
    .position_uart,
    .usability_uart,

    .lever_info(lever_info),
    .lever_left(lever_left)
);

health_calculator u_health_calculator(
    .clk,
    .rst,
    .game_state_in(state_output),
    .target(target_wire),
    .lever_info(lever_info),
    .lever_used_in(lever_used),

    .player0_health(player0_health),
    .player1_health(player1_health),
    .end_game(end_game)
);

target u_target(
    .clk,
    .rst,
    .buttonD(buttonD_P),
    .buttonU(buttonU_P),
    .game_state_in(state_output),
    .lever_left_in(lever_left),
    .position(position),
    .player_selected,
    .turn_in(turn),
    .target_uart,
    .lever_used_uart,
    
    .target(target_wire),
    .lever_used(lever_used),
    .turn_flag
);

who_won u_who_won(
    .rst,
    .clk,
    .player0_health(player0_health), 
    .player1_health(player1_health),
    .game_state_in(state_output),

    .winner
);

uart_receiver u_uart_receiver(
    .clk,
    .rst,

    .uart_code(uart_in),
    
    .lever_used(lever_used_uart),
    .position(position_uart),
    .target(target_uart),
    .turn(turn_uart),
    .usability(usability_uart),
    .data_received(data_received_wire)
);

uart_transmiter u_uart_transmiter(
    .clk,
    .rst,

    .lever_used(lever_used),
    .position(position),
    .target(target_wire),
    .turn(turn_flag),
    .usability(lever_info),
    .tx_done,

    .uart_code(uart_out),
    .tx_start
);

turn_handler u_turn_handler(
    .clk,
    .rst,
    
    .game_state_in(state_output),
    .player_selected,
    .turn_flag,
    .turn_uart,
    .data_received(data_received_wire),

    .turn(turn)
);

endmodule
