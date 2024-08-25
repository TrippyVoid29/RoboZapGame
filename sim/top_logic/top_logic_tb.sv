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
    logic ButtonD, ButtonL, ButtonR, ButtonU;
    
    logic turn_done;

    wire [2:0] state_output, position;
    wire [1:0] player0_health, player1_health, who_won;
    wire [7:0] lever_used_out, data_output;
    wire current_player;
    logic [7:0] uart_rx;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

top_logic dut(
    .buttonD(ButtonD),
    .buttonL(ButtonL),
    .buttonR(ButtonR),
    .buttonU(ButtonU),
    .clk,
    .rst,
    .uart_rx,

    .player0_health,
    .player1_health,
    .current_player,
    .state_output(state_output),
    .position,
    .data_output,
    .lever_used_out,
    .who_won
);

initial begin
    rst = 1'b0;
    #10 rst = 1'b1;
    #10 rst = 1'b0;

    turn_done <= 0;
    assert(state_output === 3'b000) else $error("wrong init value for state_next");

    #20 ButtonL <= 1; ButtonR <= 1;
    #20 assert(state_output === 3'b001) else $error("not in menu");

    #20 ButtonL <= 0; ButtonR <= 1;
    #20 assert(state_output === 3'b011) else $error("not in player0");
    assert(turn_done === 0) else $error("problem with turn_done?");
    
    #60 assert(state_output === 3'b011)

    //add code here

    $finish;
end

 endmodule