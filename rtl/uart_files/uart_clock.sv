`timescale 1 ns / 1 ps

module uart_clock
    (
     input logic clk, rst,
     output logic uclk
    );



logic [31:0] counter, counter_next;
logic uclk_next;

always_ff @(posedge clk) begin
    if (rst)
    begin
        uclk <=0;
        counter <=0;
    end
 else
    begin
        counter <= counter_next;
        uclk <= uclk_next;
    end

end



always_comb begin
    if(counter==651)begin
        counter_next=0;
        uclk_next=1;
    end
    else begin
        counter_next =counter+1;
        uclk_next=0;
    end
end


endmodule


