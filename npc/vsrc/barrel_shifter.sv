module barrel_shifter (
	input clk,
	input [7:0] in_1,
	input [2:0]	shamt,
	input L_R,
	input in_valid,
	input A_L, 
	input rst,  // Asynchronous reset active low
	output logic [7:0] out_1,
	output logic out_valid
	
);
	logic [7:0] temp_1;
	logic [7:0] temp_2;
	logic [7:0] temp_3;

	always_comb begin
		case ({shamt[0],L_R,A_L})
			3'b100: temp_1 = {1'b0,in_1[7:1]};
			3'b101: temp_1 = {in_1[7],in_1[7:1]};
			3'b110: temp_1 = {in_1[6:0],1'b0};
			3'b111: temp_1 = {in_1[6:0],1'b0};
		
			default : temp_1 = in_1;
		endcase
	end

	always_comb begin
		case ({shamt[1],L_R,A_L})
			3'b100: temp_2 = {2'b0,temp_1[7:2]};
			3'b101: temp_2 = {temp_1[7],temp_1[7],temp_1[7:2]};
			3'b110: temp_2 = {temp_1[5:0],2'b0};
			3'b111: temp_2 = {temp_1[5:0],2'b0};
		
			default : temp_2 = temp_1;
		endcase
	end

	always_comb begin
		case ({shamt[2],L_R,A_L})
			3'b100: temp_3 = {4'b0,temp_2[7:4]};
			3'b101: temp_3 = {{4{temp_2[7]}}, temp_2[7:4]};
			3'b110: temp_3 = {temp_2[3:0],4'b0};
			3'b111: temp_3 = {temp_2[3:0],4'b0};
		
			default : temp_3 = temp_2;
		endcase
	end

	always_ff @(posedge clk) begin : proc_out_1
		if(rst) begin
			out_1 <= '0;
			out_valid <= 1'b0;
		end else begin
			out_1 <= temp_3;
			out_valid <= in_valid;
		end
	end



endmodule : barrel_shifter