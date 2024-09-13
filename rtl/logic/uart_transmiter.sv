/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: Łukasz Perczyński & Tymon Ryś
 *
 * Description:
 * Prepare message to send for uart.
 */
/*
 bit 0 - czyja tura
 bit 1/2/3 - która dźwignia
 bit 4/5 - czy bije / kogo
 bit 6/7 - bity na zasadzie: jeśli nie ma tu zer to wyślij informację
*/

 `timescale 1 ns / 1 ps

module uart_transmiter (
    input wire clk,
    input wire rst,

    input wire lever_used, //target
    input wire [1:0] usability, //lever_info lethality, uasbility
    input wire [2:0] position, //lever_selector
    input wire target,  //target
    input wire turn,     //target

    output logic uart_code

);

 always_ff@(posedge clk)
    if (rst)
        begin
            uart_code <= 8'b00000000;
        end
    else
        begin
            if(usability[0] == 1'b1 && lever_used == 1'b1)
                begin
                    uart_code <= {lever_used, usability[0], usability[1], target, position, turn};
                end
            else
                begin
                    uart_code <= 8'b00000000;
                end
        end

 endmodule
