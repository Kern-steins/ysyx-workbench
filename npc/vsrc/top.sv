module top #(
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	input in_clk,
	input in_valid,
	output out_valid,
	input [7:0] gpio_in_1,
	input [7:0] gpio_in_2,
	input [7:0] gpio_in_3,
	output [15:0] led,
	output [7:0] VGA_R,
	output [7:0] VGA_G,
	output [7:0] VGA_B,
	output [7:0] seg0,
	output [7:0] seg1,
	output [7:0] seg2,
	output [7:0] seg3,
	output [7:0] seg4,
	output [7:0] seg5,
	output [7:0] seg6,
	output [7:0] seg7,
	output [7:0] gpio_out_1,
	output [7:0] gpio_out_2

);

    wire in_clk_r = in_clk;
    wire [7:0] gpio_in_2_r =gpio_in_2;
    wire [7:0] gpio_in_3_r =gpio_in_3; 
    
    assign out_valid = 1'b0;
    assign led = '0;
    assign VGA_R = '0;
    assign VGA_G = '0;
    assign VGA_B = '0;
    assign seg0 = '0;
    assign seg1 = '0;
    assign seg2 = '0;
    assign seg3 = '0;
    assign seg4 = '0;
    assign seg5 = '0;
    assign seg6 = '0;
    assign seg7 = '0;
    assign gpio_out_1 = '0;
    assign gpio_out_2 = '0;


	fifo #(
			.DATA_WIDTH(8),
			.DATA_DEPTH(16),
			.ADDR_WIDTH(4)
		) inst_fifo (
			.rst     (rst),
			.wr_clk  (clk),
			.rd_clk  (clk),
			.wr_en   (in_valid),
			.rd_en   (1'b1),
			.wr_data (gpio_in_1),
			.rd_data (gpio_out_1),
			.empty   (),
			.full    ()
		);



endmodule
