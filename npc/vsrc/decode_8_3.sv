module decode_8_3 #(
		parameter DATA_LEN = 3
	) (
	input	[7:0] in_1,
	input 		 in_valid,
	output logic [DATA_LEN-1:0] out_1,
	output logic out_valid
	
);
	always_comb begin
		if (in_valid == 1'b1) begin
			casez (in_1)
				8'b1???_????: out_1 = 3'b111;
				8'b01??_????: out_1 = 3'b110;	
				8'b001?_????: out_1 = 3'b101;	
				8'b0001_????: out_1 = 3'b100;	
				8'b0000_1???: out_1 = 3'b011;	
				8'b0000_01??: out_1 = 3'b010;	
				8'b0000_001?: out_1 = 3'b001;	
				8'b0000_0001: out_1 = 3'b000;	
				default : out_1 = 3'b0;
			endcase
			out_valid = 1'b1;
		end else begin
			out_1 = 3'b0;
			out_valid = 1'b0;
		end
	end

endmodule
