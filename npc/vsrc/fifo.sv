module fifo #(
	parameter DATA_WIDTH = 8,
	parameter DATA_DEPTH = 16,
	parameter ADDR_WIDTH = 4
	)(
	input 	rst,  
	input 	wr_clk,
	input	rd_clk,
	input 	wr_en,
	input   rd_en,
	input 	[DATA_WIDTH-1:0] wr_data,
	output	logic	[DATA_WIDTH-1:0] rd_data,
	output	logic	empty,
	output	logic	full
);

	logic 	[DATA_WIDTH-1:0] mem [DATA_DEPTH-1:0];
	logic	[DATA_WIDTH-1:0] data_in;
	logic 	[DATA_WIDTH-1:0] rd_data_r;

	logic	[ADDR_WIDTH:0] wr_ptr;
	logic	[ADDR_WIDTH:0] wr_ptr_r;
	logic	[ADDR_WIDTH:0] wr_ptr_gray;
	logic	[ADDR_WIDTH:0] rd_ptr;
	logic	[ADDR_WIDTH:0] rd_ptr_r;
	logic	[ADDR_WIDTH:0] rd_ptr_gray;
	logic	[ADDR_WIDTH:0] r_point_1_for_write;
	logic	[ADDR_WIDTH:0] r_point_2_for_write;
	logic	[ADDR_WIDTH:0] w_point1_for_read;
	logic	[ADDR_WIDTH:0] w_point2_for_read;


always_ff @(posedge wr_clk) begin : wr_mod
	if(rst) begin
		wr_ptr	<=	'0;
		mem[wr_ptr[ADDR_WIDTH-1:0]] <= '0;
	end else begin
		wr_ptr 	<=	wr_ptr_r;
		mem[wr_ptr[ADDR_WIDTH-1:0]] <= data_in;
	end
end

always_comb begin : proc_wr
	if (wr_en && ~full) begin
		wr_ptr_r = wr_ptr + 1'b1;
		data_in  = wr_data;
	end else begin
		wr_ptr_r = wr_ptr;
		data_in  = '0;
	end
	wr_ptr_gray  = wr_ptr ^ {1'b0,wr_ptr[ADDR_WIDTH:1]};
end

always_ff @(posedge rd_clk) begin: rd_mod
	if(rst) begin
		rd_ptr 	<=	'0;
		rd_data <=	'0;	
	end else begin
		rd_ptr 	<=	rd_ptr_r;
		rd_data <=	rd_data_r;
	end
end

always_comb begin : proc_rd
	rd_ptr_gray  	= rd_ptr ^ {1'b0,rd_ptr[ADDR_WIDTH:1]};
	if (~empty && rd_en) begin
		rd_data_r 	= mem[rd_ptr[ADDR_WIDTH-1:0]];
		rd_ptr_r  	= rd_ptr + 1'b1; 
	end else begin
		rd_data_r	= '0;
		rd_ptr_r 	= rd_ptr;
	end
	
end

always_ff @(posedge rd_clk) begin : rpoint_wr
	if(rst) begin
		w_point1_for_read <= '0;
		w_point2_for_read <= '0;
	end else begin
		w_point1_for_read <= wr_ptr_gray;
		w_point2_for_read <= w_point1_for_read;
	end
end

always_ff @(posedge rd_clk) begin : wpoint_rd
	if(rst) begin
		r_point_1_for_write <= '0;
		r_point_2_for_write <= '0;
	end else begin
		r_point_1_for_write <= rd_ptr_gray;
		r_point_2_for_write <= r_point_1_for_write;
	end
end
 
always_comb begin : proc_full_empty
	if (rd_ptr_gray == w_point2_for_read)begin
		empty = 1'b1;
	end else begin
		empty = 1'b0;
	end
	if ({ ~r_point_2_for_write[ADDR_WIDTH:ADDR_WIDTH-1],
			r_point_2_for_write[ADDR_WIDTH-2:0]}
			== wr_ptr_gray) begin
		full = 1'b1;	
	end else begin
		full = 1'b0;
	end	
end


endmodule : fifo
