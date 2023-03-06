module top #(
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	input in_clk(* unused *),
	input in_valid(* unused *),
	output out_valid(* unused *),
	input [7:0] gpio_in_1,
	input [7:0] gpio_in_2(* unused *),
	input [7:0] gpio_in_3(* unused *),
	output [15:0] led(* unused *),
	output [7:0] VGA_R(* unused *),
	output [7:0] VGA_G(* unused *),
	output [7:0] VGA_B(* unused *),
	output [7:0] seg0(* unused *),
	output [7:0] seg1(* unused *),
	output [7:0] seg2(* unused *),
	output [7:0] seg3(* unused *),
	output [7:0] seg4(* unused *),
	output [7:0] seg5(* unused *),
	output [7:0] seg6(* unused *),
	output [7:0] seg7(* unused *),
	output [7:0] gpio_out_1,
	output [7:0] gpio_out_2(* unused *)

);

/*
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

*/

endmodule
