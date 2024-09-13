/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Decode message from uart.
 */
/*
 bit 0 - czyja tura
 bit 1/2/3 - która dźwignia
 bit 4/5 - czy bije / kogo
 bit 6/7 - bity na zasadzie: jeśli nie ma tu zer to wyślij informację
*/

`timescale 1 ns / 1 ps

module uart_receiver (
    input wire clk,
    input wire rst,

    input wire [7:0] uart_code,

    output logic lever_used, //target
    output logic [1:0] usability, //lever_info lethality, usability
    output logic [2:0] position, //lever_selector
    output logic target,  //target
    output logic turn,     //target
    output logic data_received
);

 always_ff@(posedge clk)
    if (rst)
        begin
            lever_used <= 1'b0;
            usability <= 2'b00;
            position <= 3'b000;
            target <= 1'b0;
            turn <= 1'b0;
            data_received <= 1'b0;
        end
    else
        begin
            if(uart_code[7:6] == 2'b11)
                begin
                    lever_used <= uart_code[7];
                    usability[0] <= uart_code[6];
                    usability[1] <= uart_code[5];
                    position <= uart_code[3:1];
                    target <= uart_code[4];
                    turn <= uart_code[0];
                    data_received <= 1'b1;
                end
            else
                begin
                    lever_used <= 1'b0;
                    usability <= 2'b00;
                    position <= 3'b000;
                    target <= 1'b0;
                    turn <= 1'b0;
                    data_received <= 1'b0;
                end
        end

endmodule
