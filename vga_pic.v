`timescale 1ns / 1ns

module vga_pic (
    input  wire vga_clk,
    input  wire sys_rst_n,
    input  wire [9:0] pix_x,
    input  wire [9:0] pix_y,
    output wire [15:0] pix_data
);

    localparam CHAR_COUNT = 4;  
    localparam CHAR_X = (640 - CHAR_COUNT*16) / 2;  
    localparam CHAR_Y = (480 - 32) / 2;
    localparam SCALE = 2;  


    reg [7:0] font_rom [0:63];
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1) 
            font_rom[i] = 8'b0;


         font_rom[0 * 16+0] = 8'b11111110; 
        font_rom[0 * 16+1] = 8'b11010110; 
        font_rom[0 * 16+2] = 8'b11010110; 
        font_rom[0 * 16+3] = 8'b11010110; 
        font_rom[0 * 16+4] = 8'b11010110; 
        font_rom[0 * 16+5] = 8'b11010110; 
        font_rom[0 * 16+6] = 8'b11010110; 
        font_rom[0 * 16+7] = 8'b11010110; 
        font_rom[0 * 16+8] = 8'b11010110; 
        font_rom[0 * 16+9] = 8'b11010110; 
        font_rom[0 * 16+10] = 8'b11010110; 
        font_rom[0 * 16+11] = 8'b11010110; 
        font_rom[0 * 16+12] = 8'b11010110;
        font_rom[0 * 16+13] = 8'b11000110; 
        font_rom[0 * 16+14] = 8'b11000110; 
        font_rom[0 * 16+15] = 8'b00000000; 


        font_rom[1 * 16+0] = 8'b11000110;
        font_rom[1 * 16+1] = 8'b11000110;
        font_rom[1 * 16+2] = 8'b11000110;
        font_rom[1 * 16+3] = 8'b11000110;
        font_rom[1 * 16+4] = 8'b11000110;
        font_rom[1 * 16+5] = 8'b11000110;
        font_rom[1 * 16+6] = 8'b11000110;
        font_rom[1 * 16+7] = 8'b11000110;
        font_rom[1 * 16+8] = 8'b11000110;
        font_rom[1 * 16+9] = 8'b11000110;
        font_rom[1 * 16+10] = 8'b11000110;
        font_rom[1 * 16+11] = 8'b11000110;
        font_rom[1 * 16+12] = 8'b11000110;
        font_rom[1 * 16+13] = 8'b11000110;
        font_rom[1 * 16+14] = 8'b11111110;
        font_rom[1 * 16+15] = 8'b01111100;


        font_rom[2 * 16+0] = 8'b01111100;
        font_rom[2 * 16+1] = 8'b11000110;
        font_rom[2 * 16+2] = 8'b11000000;
        font_rom[2 * 16+3] = 8'b11000000;
        font_rom[2 * 16+4] = 8'b11000000;
        font_rom[2 * 16+5] = 8'b01110000;
        font_rom[2 * 16+6] = 8'b00011100;
        font_rom[2 * 16+7] = 8'b00000110;
        font_rom[2 * 16+8] = 8'b00000110;
        font_rom[2 * 16+9] = 8'b00000110;
        font_rom[2 * 16+10] = 8'b00000110;
        font_rom[2 * 16+11] = 8'b11000110;
        font_rom[2 * 16+12] = 8'b11000110;
        font_rom[2 * 16+13] = 8'b11000110;
        font_rom[2 * 16+14] = 8'b11000110;
        font_rom[2 * 16+15] = 8'b01111100;


        font_rom[3 * 16+0] = 8'b11111111;
        font_rom[3 * 16+1] = 8'b00011000;
        font_rom[3 * 16+2] = 8'b00011000;
        font_rom[3 * 16+3] = 8'b00011000;
        font_rom[3 * 16+4] = 8'b00011000;
        font_rom[3 * 16+5] = 8'b00011000;
        font_rom[3 * 16+6] = 8'b00011000;
        font_rom[3 * 16+7] = 8'b00011000;
        font_rom[3 * 16+8] = 8'b00011000;
        font_rom[3 * 16+9] = 8'b00011000;
        font_rom[3 * 16+10] = 8'b00011000;
        font_rom[3 * 16+11] = 8'b00011000;
        font_rom[3 * 16+12] = 8'b00011000;
        font_rom[3 * 16+13] = 8'b00011000;
        font_rom[3 * 16+14] = 8'b00011000;
        font_rom[3 * 16+15] = 8'b00011000;
    end


    wire in_char = (pix_x >= CHAR_X && pix_x < CHAR_X + CHAR_COUNT*8*SCALE) &&
                   (pix_y >= CHAR_Y && pix_y < CHAR_Y + 16*SCALE);

    wire [9:0] local_x = pix_x - CHAR_X;
    wire [9:0] local_y = pix_y - CHAR_Y;


    wire [1:0] char_idx = local_x / (8*SCALE);
    

    wire [3:0] font_y = local_y / SCALE;
    

    wire [2:0] font_x = (local_x / SCALE) % 8;


    wire pixel_on = in_char ? font_rom[{char_idx, font_y}][7 - font_x] : 1'b0;


    assign pix_data = pixel_on ? 16'h0000 : 16'hFFFF;

endmodule
