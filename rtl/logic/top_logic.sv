`timescale 1 ns / 1 ps

module top_logic (

    input wire clk,
    input wire rst,
    input wire buttonD, buttonU, buttonR, buttonL,

    output logic turn,
    output logic [1:0] winner,
    output logic [1:0] player0_health,
    output logic [1:0] player1_health,
    output logic [7:0] lever_left,
    output logic [2:0] position

);

    wire start_game, end_game, new_game;
    wire target_wire, lever_used;
    wire [1:0] state_output, lever_info;
    
    wire buttonD_P, buttonU_P, buttonR_P, buttonL_P;
    wire [7:0] levers_lethality;

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

    .buttonD_pressed(buttonD_P),
    .buttonL_pressed(buttonL_P),
    .buttonR_pressed(buttonR_P),
    .buttonU_pressed(buttonU_P)

);

start_game u_start_game(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .state_input(state_output),

    .start_game_out(start_game)
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
    
    .target(target_wire),
    .lever_used(lever_used),
    .turn(turn)
);

who_won u_who_won(
    .rst,
    .clk,
    .player0_health(player0_health), 
    .player1_health(player1_health),
    .game_state_in(state_output),

    .winner
);

endmodule