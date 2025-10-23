`timescale 1ns / 1ns

module Lab3(
    input  wire sys_clk,      // System Clock, 50MHz
    input  wire sys_rst_n,    // Reset signal. Low level is effective
    output wire hsync,        // Line sync signal
    output wire vsync,        // Field sync signal
    output wire [15:0] rgb    // RGB565 color data
);

 
    wire vga_clk;             // VGA working clock, 25MHz
    wire [9:0] pix_x;         // x coordinate of current pixel
    wire [9:0] pix_y;         // y coordinate of current pixel
    wire [15:0] pix_data;     // color information

    // VGA working clock, 25MHz (50MHz -> 25MHz by toggle)
    reg vga_clk_reg;
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            vga_clk_reg <= 0;
        else
            vga_clk_reg <= ~vga_clk_reg;
    end
    assign vga_clk = vga_clk_reg;


    vga_ctrl vga_ctrl_inst (
        .vga_clk   (vga_clk),
        .sys_rst_n (sys_rst_n),
        .pix_data  (pix_data),
        .pix_x     (pix_x),
        .pix_y     (pix_y),
        .hsync     (hsync),
        .vsync     (vsync),
        .rgb       (rgb)
    );


    vga_pic vga_pic_inst (
        .vga_clk   (vga_clk),
        .sys_rst_n (sys_rst_n),
        .pix_x     (pix_x),
        .pix_y     (pix_y),
        .pix_data  (pix_data)
    );

endmodule
