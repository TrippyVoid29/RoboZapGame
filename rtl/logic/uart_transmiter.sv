/**
 * 2024  AGH University of Science and Technology
 * MTM UEC2
 * Author: �?ukasz Perczyński & Tymon Ryś
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
    input wire tx_done,

    output logic [7:0] uart_code,
    output logic tx_start

);

//STATES
typedef enum bit {    
    IDLE = 1'b0,
    SENDING = 1'b1} etx_state;
    
    logic state, state_next; 
    logic [7:0] uart_code_next;

 always_ff@(posedge clk)
    if (rst)
        begin
            uart_code <= 8'b00000000;
            state <= IDLE;
        end
    else
        begin
            uart_code <= uart_code_next;
            state <= state_next;
        end
        
always_comb
    begin
        case(state)
            IDLE:
                begin
                    if(usability[0] == 1'b1)
                        begin
                            uart_code_next = {lever_used, usability[0], usability[1], target, position, turn};
                            tx_start = 1'b1;
                            state_next = SENDING;
                        end
                    else
                        begin
                            uart_code_next = 8'b00000000;
                            tx_start = 1'b0;
                            state_next = IDLE;
                        end
                end
            SENDING:
                begin
                    if(tx_done)
                        begin
                            tx_start = 1'b0;
                            state_next = IDLE;
                        end
                    else
                        begin
                            uart_code_next = uart_code;
                            state_next = SENDING;
                            tx_start = 1'b0;
                        end
                end
        endcase
    end
endmodule
