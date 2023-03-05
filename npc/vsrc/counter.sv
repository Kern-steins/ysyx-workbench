module counter #(
	parameter WIDTH = 4
	) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	input [WIDTH-1:0]	count_ref,
	input in_carry_valid,
	input carry_enforce,
	output logic [WIDTH-1:0] count,
	output logic out_carry_valid
	
);
	logic 	[3:0]	count_r;
	logic 	out_carry_valid_r;


always_ff @(posedge clk) begin
	if(rst) begin
		count <= '0;
	end else begin
		count <= count_r;
	end
end

always_comb begin : proc_
	casez ({	carry_enforce,
			in_carry_valid})
		2'b1?: begin
			count_r = '0;
			out_carry_valid = 1'b1;
		end
		2'b01: begin
			if (count < count_ref) begin
				count_r = count + 1'b1;
				out_carry_valid = 1'b0;
			end else begin
				count_r = '0;
				out_carry_valid = 1'b1;
			end
		end
	
		default : begin
			count_r = count;
			out_carry_valid = 1'b0;
		end
	endcase
end

endmodule : counter