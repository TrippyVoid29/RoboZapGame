`timescale 1 ns / 1 ps

module uart_rec

    (
     input logic clk, rst,
     input logic rx_done_tick,
     input logic [7:0] din,

     output logic [7:0] dout
    );

    logic [7:0] dout_next;
    logic [1:0] state_reg, state_reg_next;

    localparam [1:0]
        s1=2'b00,
        s2=2'b01,
        s3 =2'b10;

    always_ff @(posedge clk) begin
        if (rst)
        begin
            dout <=8'b00000000;

            state_reg <= s1;
        end
     else
        begin
            dout <= dout_next;
            state_reg <= state_reg_next;
        end
    end



    always_comb begin

case(state_reg)
    s1: begin

        dout_next = dout;
        state_reg_next=s1;   

    if(rx_done_tick==1) begin
        state_reg_next=s2;
    end

    end

    s2: begin
        dout_next = din;
            state_reg_next=s3;
    end


    s3: begin
        dout_next = dout;
        state_reg_next=s1;   

        if(rx_done_tick==0) 
        state_reg_next=s1;
        else
        state_reg_next=s3;
    end

endcase

    end



endmodule

