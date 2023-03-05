typedef enum logic [2:0]{
	nop, timimg, 
	adj_time, alarm_m,
	stopwatch
}main;

typedef enum logic [2:0] {
	t_1, t_2, 
	t_3, t_4,
	t_5, t_6
}adj; 


module count#(
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	input alarm_valid,
	output logic [7:0] out_1,
	output logic [7:0] out_2,
	output logic [7:0] out_3,
	output logic [7:0] out_4,
	output logic [7:0] out_5,
	output logic [7:0] out_6
);

	main 	main_state;
	adj 	adj_state;

	logic	[1:0]	clk_mod;
	wire 	std_clk;



clk_divide inst_clk_divide (
		.clk       (clk),
		.mod       (clk_mod),
		.rst       (rst),
		.clk_out   (std_clk)
);

always_comb begin : proc_
	
	case (main_state)
		timimg: 	clk_mod = 2'd1;
		stopwatch: 	clk_mod = 2'd2;	
		default : 	clk_mod = 2'd0;
	endcase
end

	logic 	[3:0]	count_ref [0:5];	

	logic	in_carry_valid [0:5];

	logic	carry_enforce [0:5];

	wire	[3:0]	count 	[0:5];
    wire    out_carry_valid_0 ;
    wire    out_carry_valid_1 ;
    wire    out_carry_valid_2 ;
    wire    out_carry_valid_3 ;
    wire    out_carry_valid_4 ;
    wire    out_carry_valid_5 ;

	logic 	[3:0]	count_time[0:5];
	logic 	[7:0]	seg_out[0:5];

always_comb begin
	count_ref[0] = 4'd9;
	count_ref[1] = 4'd5;
	count_ref[2] = 4'd9;
	count_ref[3] = 4'd5;
	count_ref[4] = 4'd9;
	count_ref[5] = 4'd2;

	count_time[0]= count[0];
	count_time[1]= count[1];
	count_time[2]= count[2];
	count_time[3]= count[3];
	count_time[4]= count[4];
	count_time[5]= count[5];

/*
	if ( {count[5],count[4]} == 8'h23 
		&& out_carry_valid[3] == 1'b1) begin
		carry_enforce[4] = 1'b1;	
	end else begin
		carry_enforce[4] = 1'b0;
	end
*/
	out_1 	= seg_out[0];
	out_2 	= seg_out[1];
	out_3 	= seg_out[2];
	out_4 	= seg_out[3];
	out_5 	= seg_out[4];
	out_6 	= seg_out[5];
end

counter #(
		.WIDTH(4)
	) inst_counter_0(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[0]),		
		.in_carry_valid	 (1'b1),
		.carry_enforce   (1'b0),
		.count          (count[0]),
		.out_carry_valid(out_carry_valid_0)
);

counter #(
		.WIDTH(4)
	) inst_counter_1(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[1]),		
		.in_carry_valid	 (out_carry_valid_0),
		.carry_enforce   (1'b0),
		.count          (count[1]),
		.out_carry_valid(out_carry_valid_1)
);

counter #(
		.WIDTH(4)
	) inst_counter_2(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[2]),		
		.in_carry_valid	 (out_carry_valid_1),
		.carry_enforce   (1'b0),
		.count          (count[2]),
		.out_carry_valid(out_carry_valid_2)
);
counter #(
		.WIDTH(4)
	) inst_counter_3(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[3]),		
		.in_carry_valid	 (out_carry_valid_2),
		.carry_enforce   (1'b0),
		.count          (count[3]),
		.out_carry_valid(out_carry_valid_3)
);
counter #(
		.WIDTH(4)
	) inst_counter_4(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[4]),		
		.in_carry_valid	 (out_carry_valid_3),
		.carry_enforce   (1'b0),
		.count          (count[4]),
		.out_carry_valid(out_carry_valid_4)
);

counter #(
		.WIDTH(4)
	) inst_counter_5(
		.clk             (std_clk),
		.rst             (rst),
		.count_ref       (count_ref[5]),		
		.in_carry_valid	 (out_carry_valid_4),
		.carry_enforce   (1'b0),
		.count          (count[5]),
		.out_carry_valid()
);

generate
	for (genvar i = 0; i < 6; i = i + 1) begin
		seg #(
			.DATA_LEN(4)
		) inst_seg_0 (
			.in_valid  (1'b1),
			.in_1      (count_time[i]),
			.in_p      (1'b0),
			.out_1     (seg_out[i]),
			.out_valid ()
		);
	end
endgenerate



 
endmodule
