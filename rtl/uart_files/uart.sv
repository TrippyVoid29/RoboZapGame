
`timescale 1 ns / 1 ps

module uart(
    input logic clk,
    input logic rst,
    input logic rx,
    input logic loopback_enable,
    output logic tx,
    output logic rx_monitor,
    output logic tx_monitor
);


logic tx_next;

always_ff @(posedge clk) begin 
    if (rst) begin
        rx_monitor <=0;
        tx_monitor <=0;
        tx <=1;

        end else begin
        rx_monitor <= rx;
        tx_monitor <= tx;
        tx <= tx_next;
    end
end

always_comb begin

    if(loopback_enable==1)
        tx_next = rx;
    else
        tx_next = 1;


end


endmodule