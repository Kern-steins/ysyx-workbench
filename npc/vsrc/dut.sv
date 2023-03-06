module dut #(
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	input in_valid,
	input rd_en,
	input logic [7:0] in_1,
	output logic empty,
	output logic full,
	output logic [7:0] out_1
);


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
			.wr_data (in_1),
			.rd_data (out_1),
			.empty   (empty),
			.full    (full)
		);



endmodule
