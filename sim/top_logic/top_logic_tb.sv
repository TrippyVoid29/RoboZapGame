/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module top_logic_tb;

    //inputs -> logic/reg    outputs -> wires
    logic clk;
    logic rst;
    logic buttonD, buttonL, buttonR, buttonU;
    logic buttonD_P, buttonL_P, buttonR_P, buttonU_P;
    logic [7:0] uart_in;

    wire lever_used;
    wire turn; //turn -> VGA
    wire [1:0] winner, lever_info; //winner -> VGA
    wire [1:0] player0_health, player1_health;
    wire [7:0] lever_left;
    wire wire_start_game, new_game;
    wire [1:0] state_game_wire;
    wire [2:0] position;
    wire [7:0] levers_lethality, uart_out;
    wire end_game_wire, player_selected_wire;


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

game_state u_game_state(
    .clk,
    .rst,
    .start_game(wire_start_game),
    .end_game(end_game_wire),
    .new_game,

    .state_output(state_game_wire)
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
    .buttonR(buttonR_P),
    .state_input(state_game_wire),

    .start_game_out(wire_start_game),
    .player_selected(player_selected_wire)
);

new_game u_new_game(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .state_input(state_game_wire),
    .new_game_out(new_game)
);

lever_selector u_lever_selector(
    .clk,
    .rst,
    .buttonL(buttonL_P),
    .buttonR(buttonR_P),
    .game_state_in(state_game_wire),
    .player_selected(player_selected_wire),

    .position(position)
);

map_randomizer u_map_randomizer(
    .clk,
    .rst,
    .state_input(state_game_wire),

    .table_lethality(levers_lethality)
);

levers_info u_levers_info(
    .clk,
    .rst,
    .position(position),
    .lever_used(lever_used),
    .game_state_in(state_game_wire),
    .levers_lethality(levers_lethality),
    .player_selected(player_selected_wire),

    .lever_info(lever_info),
    .lever_left(lever_left)
);

health_calculator u_health_calculator(
    .clk,
    .rst,
    .game_state_in(state_game_wire),
    .target(target),
    .lever_info(lever_info),
    .lever_used_in(lever_used),

    .player0_health(player0_health),
    .player1_health(player1_health),
    .end_game(end_game_wire)
);

target u_target(
    .clk,
    .rst,
    .buttonD(buttonD_P),
    .buttonU(buttonU_P),
    .game_state_in(state_game_wire),
    .lever_left_in(lever_left),
    .position,
    .player_selected(player_selected_wire),
    
    .target(target),
    .lever_used(lever_used),
    .turn(turn)
);

who_won u_who_won(
    .rst,
    .clk,
    .player0_health(player0_health), 
    .player1_health(player1_health),
    .game_state_in(state_game_wire),

    .winner(winner)
);

uart_receiver u_uart_receiver(
    .clk,
    .rst,

    .uart_code(uart_in),
    
    .lever_used(lever_used_uart),
    .position(position_uart),
    .target(target_uart),
    .turn(turn_uart),
    .usability(usability_uart)
);

uart_transmiter u_uart_transmiter(
    .clk,
    .rst,

    .lever_used(lever_used),
    .position(position),
    .target(target_wire),
    .turn(turn),
    .usability(lever_info),

    .uart_code(uart_out)
);



task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;

        buttonL = 1'b0;
        buttonR = 1'b0;
        buttonU = 1'b0;
        buttonD = 1'b0;

        #10 rst = 1'b0;
    end
endtask

localparam [1:0]
up = 2'b00,
left = 2'b10,
right = 2'b01,
down = 2'b11;

task press_lever(input [1:0] direction);
    begin
    if(direction == left) begin
        buttonL = 1'b1;
        #20 buttonL = 1'b0;
        #20;
    end else if (direction == right) begin
        buttonR = 1'b1;
        #20 buttonR = 1'b0;
        #20;
    end else if (direction == up) begin
        buttonU = 1'b1;
        #10 buttonU = 1'b0;
        #10;
    end else if (direction == down) begin
        buttonD = 1'b1;
        #20 buttonD = 1'b0;
        #20;
    end 
    end
endtask

task start_game();
    begin
    #20 buttonL = 1; buttonR = 1;
    #20 buttonL = 0; buttonR = 1;
    #20 buttonR = 0;
    end
endtask

initial begin

    reset();
    #50
    press_lever(right);
    #100
    press_lever(left);
    #100
    press_lever(right);
    press_lever(up);
    #100
    press_lever(right);
    press_lever(down);
    #100
    press_lever(right);
    press_lever(down);
    #100
    press_lever(right);
    press_lever(down);
    #100
    press_lever(right);
    press_lever(down);
    #100
    press_lever(right);
    press_lever(down);
    #100
    press_lever(left);
    #100

    $finish;
end

 endmodule