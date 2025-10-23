`timescale 1ns / 1ns

module DevelopmentBoard(
    input wire clk, //50MHz
    input wire reset, B2, B3, B4, B5,
    // reset is "a"
    // B2 is "s"
    // B3 is "d"
    // B4 is "f"
    // B5 is "g"
    output wire h_sync, v_sync,
    output wire [15:0] rgb,
    output wire led1,
    output wire led2,
    output wire led3,
    output wire led4,
    output wire led5
);

    // instance your model
    Lab3 Lab3_inst(
        .sys_clk(clk),
        .sys_rst_n(reset),
        .hsync(h_sync),
        .vsync(v_sync),
        .rgb(rgb)
    );

    assign led1 = 1'b0;
    assign led2 = 1'b0;
    assign led3 = 1'b0;
    assign led4 = 1'b0;
    assign led5 = 1'b0;

endmodule
