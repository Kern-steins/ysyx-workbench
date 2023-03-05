module light #(
	parameter DATA_LEN = 16
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	output logic [DATA_LEN-1:0]out_1
);
    localparam COUNT_LEN = 16;

	logic [DATA_LEN-1:0] out_1_r;
	logic [COUNT_LEN-1:0] count;
	logic [COUNT_LEN-1:0] count_r;

always_ff @(posedge clk or posedge rst) begin 
	if(rst) begin
		out_1 <= 'h0;
		count <= 'h0;
	end else begin
		out_1 <= out_1_r;
		count <= count_r;
	end
end

always_comb begin 
	if (count < 99) begin
		count_r = count + 1'b1;
	end else begin
		count_r = '0;
	end
	if (count == 99) begin
        if( out_1[COUNT_LEN-1] == 1'b0 )begin
		    out_1_r = (out_1 << 1) + 1'b1; 
        end else begin
            out_1_r = out_1 << 1;
        end
	end else begin
		out_1_r = out_1;
	end
end
endmodule
