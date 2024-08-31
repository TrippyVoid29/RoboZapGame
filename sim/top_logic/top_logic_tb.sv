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

    wire [2:0] state_output; 
    logic [2:0] position;
    logic [1:0] player0_health, player1_health, who_won;
    wire [7:0] lever_left_out;
    wire current_player;

    wire buttonD_pressed, buttonL_pressed, buttonR_pressed, buttonU_pressed;
    wire [4:0] lever_select;
    wire turn_done;
    wire [2:0] tablecode;
/*
// microcode
// 0000 0000
// 0,1,2 - turn
// 3 - lever lethality
// 4,5,6 - which switch
// 7 - who was targeted

    STATES----------------

    PLAYER_SELECT = 3'b000,
    MENU = 3'b001,
    LEVERS = 3'b010,
    PLAYER_0 = 3'b011,
    PLAYER_1 = 3'b100,
    GAMEEND = 3'b101
    */

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


    buttons_handler u_buttons_handler(
        .clk,
        .rst,
        .buttonD(ButtonD),
        .buttonL(ButtonL),
        .buttonR(ButtonR),
        .buttonU(ButtonU),

        .buttonD_pressed(buttonD_pressed),
        .buttonL_pressed(buttonL_pressed),
        .buttonR_pressed(buttonR_pressed),
        .buttonU_pressed(buttonU_pressed)
    );

    game_state u_game_state(
        .clk,
        .rst,
        .buttonL(buttonL_pressed),
        .buttonR(buttonR_pressed),
        .lever_select(lever_select),
        .turn_done(turn_done),
        
        .current_player(current_player),
        .tableselected(tablecode),
        .who_won,
        .lever_left_out,
        .state_output(state_output),
        .player0_health,
        .player1_health
    );

    wire [7:0] lethality_table;
    

    lever_select u_lever_select(
        .clk,
        .rst,
        .buttonD(buttonD_pressed),
        .buttonL(buttonL_pressed),
        .buttonR(buttonR_pressed),
        .buttonU(buttonU_pressed),
        .current_player(current_player),
        .lever_select(lever_select),
        .lever_left_in(lever_left_out),
        .table_lethality(lethality_table),
        .turn_done(turn_done),
        .position,
        .game_state(state_output)
        
    );
    
    table_base u_table_base(
        .tablecode(tablecode),
        .table_lethality(lethality_table)
    );


task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;

        ButtonL = 1'b0;
        ButtonR = 1'b0;
        ButtonU = 1'b0;
        ButtonD = 1'b0;

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
        ButtonL = 1'b1;
        #20 ButtonL = 1'b0;
        #20;
    end else if (direction == right) begin
        ButtonR = 1'b1;
        #20 ButtonR = 1'b0;
        #20;
    end else if (direction == up) begin
        ButtonU = 1'b1;
        #10 ButtonU = 1'b0;
        #10;
    end else if (direction == down) begin
        ButtonD = 1'b1;
        #20 ButtonD = 1'b0;
        #20;
    end 
    end
endtask

task start_game();
    begin
    #20 ButtonL = 1; ButtonR = 1;
    #20 ButtonL = 0; ButtonR = 1;
    #20 ButtonR = 0;
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

    $finish;
end

 endmodule