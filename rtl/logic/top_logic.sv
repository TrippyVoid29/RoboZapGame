`timescale 1 ns / 1 ps

module top_logic (


);


buttons_handler u_buttons_handler(
    .buttonD,
    .buttonU,
    .buttonR,
    .buttonL,
    .clk,
    .rst,

    .buttonD_pressed(),
    .buttonL_pressed(),
    .buttonR_pressed(),
    .buttonU_pressed()

);

endmodule