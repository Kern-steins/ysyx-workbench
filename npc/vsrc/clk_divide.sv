typedef enum logic [1:0] {
	IDLE=0, _50M_1, _50M_100
}clk_mod;


module clk_divide #(
	parameter CLK_WIDTH = 32
)(
	input clk,    // Clock
	input clk_mod mod,
	input rst,  // Asynchronous reset active low
	output logic clk_out	
);

	logic	clk_out_r;
	logic 	[CLK_WIDTH-1:0]	clk_count;
	logic 	[CLK_WIDTH-1:0]	clk_count_r;

always_ff @(posedge clk) begin
	if(rst) begin
		clk_out 	<= 	1'b0;
		clk_count 	<=	'0;
	end else begin
		clk_out 	<= clk_out_r;
		clk_count 	<= clk_count_r;
	end 
end

always_comb begin : proc_
	case (mod)
		IDLE: begin
			clk_out_r = '0;
			clk_count_r = '0;
		end
		_50M_1: begin
			if ( clk_count < 32'd24_999_999) begin
				clk_count_r = clk_count + 1'b1;
				clk_out_r 	= clk_out;
			end else begin
				clk_count_r = '0;
				clk_out_r 	= ~clk_out;
			end
		end
		_50M_100: begin
			if ( clk_count < 32'd249_999) begin
				clk_count_r = clk_count + 1'b1;
				clk_out_r 	= clk_out;
			end else begin
				clk_count_r = '0;
				clk_out_r 	= ~clk_out;
			end

		end
		default: begin
			clk_out_r = '0;
			clk_count_r = '0;
		end
	endcase
end

endmodule : clk_divide