`timescale 1 ns / 1 ps

module uart_rec

    (
     input logic clk, rst,
     input logic rx_done_tick,
     input logic [7:0] dout,

     output logic [3:0] outH, outL, outH2, outL2
    );

    logic [3:0] outH_next, outL_next, outH_next2, outL_next2;
    logic [1:0] state_reg, state_reg_next;

    localparam [1:0]
        s1=2'b00,
        s2=2'b01,
        s3 =2'b10;

    always_ff @(posedge clk) begin
        if (rst)
        begin
            outH <=0;
            outL <=0;
            outH2 <=0;
            outL2 <=0;
            state_reg <= s1;
        end
     else
        begin
            outH <= outH_next;
            outL <= outL_next;
            outH2 <= outH_next2;
            outL2 <= outL_next2;
            state_reg <= state_reg_next;
        end
    end



    always_comb begin

case(state_reg)
    s1: begin

        outH_next = outH;
        outL_next = outL;
        outH_next2 = outH2;
        outL_next2 = outL2;
        state_reg_next=s1;   

    if(rx_done_tick==1) begin
        state_reg_next=s2;
    end

    end

    s2: begin
            outH_next = dout[7:4];
            outL_next = dout[3:0];
            outH_next2 = outH;
            outL_next2 = outL;
            state_reg_next=s3;
    end


    s3: begin
        outH_next = outH;
        outL_next = outL;
        outH_next2 = outH2;
        outL_next2 = outL2;
        state_reg_next=s1;   

        if(rx_done_tick==0) 
        state_reg_next=s1;
        else
        state_reg_next=s3;
    end

endcase

    end



endmodule

