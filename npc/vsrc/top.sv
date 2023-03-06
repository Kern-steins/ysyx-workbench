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

wire [7:0]	out_1;
wire [7:0]	out_2;



ps2 u_ps2(
	//ports
	.clk      		( clk      		),
	.rst      		( rst      		),
	.ps2_clk  		( ps2_clk  		),
	.ps2_data 		( ps2_data 		),
	.out_1    		( out_1    		),
	.out_2    		( out_2    		)
);




/*
    wire empty;
    wire full;

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
			.empty   (empty),
			.full    (full)
		);

    assign out_valid = ~empty;
*/



endmodule
