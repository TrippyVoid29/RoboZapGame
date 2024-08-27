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
    logic tx_start;

    logic [7:0] uart_rx;

    wire [2:0] state_output; 
    logic [2:0] position;
    logic [1:0] player0_health, player1_health, who_won;
    wire [7:0] lever_used_out, data_output;
    wire current_player;

// microcode
// 0000 0000
// 0,1,2 - turn
// 3 - lever lethality
// 4,5,6 - which switch
// 7 - who was targeted

    /*                                 if(uart_rx[2:0] > turn)
                                    begin
                                        turn = uart_rx[2:0]; // update turn on this device
                                        lever_used_out[uart_rx[6:4]] = 1'b0; //update which lever was pulled for lever_select module

                                        if(uart_rx[3] == 1'b0 && uart_rx[7] == 1'b0)
                                        */

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
    .tx_start(tx_start),

    .player0_health,
    .player1_health,
    .current_player,
    .state_output(state_output),
    .position,
    .data_output,
    .lever_used_out,
    .who_won
);

task reset();
    begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #10 rst = 1'b0;
        position = 0;
        player0_health = 2'b10;
        player1_health = 2'b10;
        //uart_rx = 8'b00000000;
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
    #20 ButtonL <= 1; ButtonR <= 1;
    #20 ButtonL <= 0; ButtonR <= 1;
    #20 ButtonR <= 0;
    end
endtask

initial begin

    reset();
    start_game();

    #20 press_lever(left);
    press_lever(left);
    press_lever(left);
    press_lever(left);
    press_lever(left);
    press_lever(up);
    uart_rx = 8'b00011001;
    #20 
    uart_rx = 8'b00011010;
    #20
    //add code here

    $finish;
end

 endmodule