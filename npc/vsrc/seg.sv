typedef enum logic [8-1:0] {
	seg_0 = 8'b1100_0000,
	seg_1 = 8'b1111_1001,
	seg_2 = 8'b1010_0100,
	seg_3 = 8'b1011_0000,
	seg_4 = 8'b1001_1001,
	seg_5 = 8'b1001_0010,
	seg_6 = 8'b1000_0010,
	seg_7 = 8'b1111_1000,
	seg_8 = 8'b1000_0000,
	seg_9 = 8'b1001_0000,
	seg_a = 8'b1000_1000,
	seg_b = 8'b1000_0011,
	seg_c = 8'b1100_0110,
	seg_d = 8'b1010_0001,
	seg_e = 8'b1000_0110,
	seg_f = 8'b1000_1110,
	seg_0_p = 8'b0100_0000,
	seg_1_p = 8'b0111_1001,
	seg_2_p = 8'b0010_0100,
	seg_3_p = 8'b0011_0000,
	seg_4_p = 8'b0001_1001,
	seg_5_p = 8'b0001_0010,
	seg_6_p = 8'b0000_0010,
	seg_7_p = 8'b0111_1000,
	seg_8_p = 8'b0000_0000,
	seg_9_p = 8'b0001_0000,
	seg_a_p = 8'b0000_1000,
	seg_b_p = 8'b0000_0011,
	seg_c_p = 8'b0100_0110,
	seg_d_p = 8'b0010_0001,
	seg_e_p = 8'b0000_0110,
	seg_f_p = 8'b0000_1110,
	seg_default = 8'hff
}op_seg;

module seg #(
	parameter DATA_LEN = 4
	) (
	input 	in_valid,
	input 	[DATA_LEN-1:0] in_1,
	input	in_p,
	output	op_seg	out_1,	
    output  out_valid
);

	always_comb begin : proc_
		if (in_valid == 1) begin
			case ({in_p,in_1})
				5'h0: out_1 = seg_0;
				5'h1: out_1 = seg_1;
				5'h2: out_1 = seg_2;
				5'h3: out_1 = seg_3;
				5'h4: out_1 = seg_4;
				5'h5: out_1 = seg_5;
				5'h6: out_1 = seg_6;
				5'h7: out_1 = seg_7;
				5'h8: out_1 = seg_8;
				5'h9: out_1 = seg_9;
				5'ha: out_1 = seg_a;
				5'hb: out_1 = seg_b;
				5'hc: out_1 = seg_c;
				5'hd: out_1 = seg_d;
				5'he: out_1 = seg_e;
				5'hf: out_1 = seg_f;
				5'h10: out_1 = seg_0_p;
				5'h11: out_1 = seg_1_p;
				5'h12: out_1 = seg_2_p;
				5'h13: out_1 = seg_3_p;
				5'h14: out_1 = seg_4_p;
				5'h15: out_1 = seg_5_p;
				5'h16: out_1 = seg_6_p;
				5'h17: out_1 = seg_7_p;
				5'h18: out_1 = seg_8_p;
				5'h19: out_1 = seg_9_p;
				5'h1a: out_1 = seg_a_p;
				5'h1b: out_1 = seg_b_p;
				5'h1c: out_1 = seg_c_p;
				5'h1d: out_1 = seg_d_p;
				5'h1e: out_1 = seg_e_p;
				default : out_1 = seg_default;
			endcase
            out_valid = 1'b1;
		end else begin
			out_valid = 1'b0;
			out_1 = seg_default;
		end
	end

endmodule :	seg 
