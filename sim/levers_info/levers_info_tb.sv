/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:Łukasz Perczyński
 *
 * Description:
 * Testbench for game_state module.
 */

 `timescale 1 ns / 1 ps

 module levers_info_tb;

    logic clk, rst;
    logic [1:0] game_state;
    logic lever_used;
    logic [2:0] position;

    wire [1:0] lever_info;
    wire [7:0] lever_left; 
    logic [7:0] levers_lethality;


initial 
begin
    clk = 0;
    forever #5 clk = ~clk;
end



levers_info levers_dut(
    .clk,
    .rst,
    .game_state_in(game_state),
    .lever_used,
    .levers_lethality,
    .position,

    .lever_info,
    .lever_left
);

task init();
    begin
        rst = 1;
        #25 rst = 0;
        lever_used = 0;
        game_state = 2'b01;
        levers_lethality = 8'b11110000;
        position = 2'b00;        
    end
endtask

initial
begin
    init();
    #20
    lever_used = 1;
    #10 lever_used = 0;
    #80;
    $finish;
end

 endmodule