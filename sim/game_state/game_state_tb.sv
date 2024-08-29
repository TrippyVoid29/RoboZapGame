/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module game_state_tb;
    //inputs -> logic/reg    outputs -> wires
    logic clk;
    logic rst;
    logic ButtonC, ButtonD, ButtonL, ButtonR, ButtonU;
    
    logic turn_done;

    wire [2:0] state_output;

    

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

game_state dut(
    .buttonC(ButtonC),
    .buttonD(ButtonD),
    .buttonL(ButtonL),
    .buttonR(ButtonR),
    .buttonU(ButtonU),
    .clk,
    //.current_player,
    //.data_output,
    //.lever_select,
    //.lever_used_out,
    //.player0_health,
    //.player1_health,
    .rst,
    .state(state_output),
    //.tablecode,
    .turn_done(turn_done)
    //.uart_rx,
    //.who_won
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
    #60

    //add code here

    $finish;
end

 endmodule