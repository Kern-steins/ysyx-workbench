module top #(
    ) (
        input clk,  // Clock
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


    logic clk_test;

    wire empty;
    wire full;

    logic series_out;


    wire [7:0] out_1;
    wire [7:0] out_2;

    assign seg0 = out_1;
    assign seg1 = out_2;
    wire ps2_data = gpio_in_1[0];

    ps2 u_ps2 (
            //ports
            .clk     (clk),
            .rst     (rst),
            .ps2_clk (in_clk),
            .ps2_data(ps2_data),
            .out_1   (out_1),
            .out_2   (out_2)
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
/*
    //modelsim tb
	int time_count = 0;

    always #5 clk_test = ~clk_test;
    initial begin
        clk_test = 1'b0;
        series_out = 1'b0;
		in_clk_test = 1'b0;
		rst_test = 1'b1;		
        #20 rst_test = 1'b0;
        while(1) begin
            @(posedge in_clk_test);
            series(8'hFF, series_out);
        end
    end
	always @(posedge clk_test) begin
		if (time_count < 2) begin
			time_count = time_count + 1;
		end
		else begin
			time_count = 0;
			in_clk_test = ~in_clk_test;
		end
	end

    task  series(input [7:0] in, output series_out);
        static integer i = 0;
        static int data_count = 0;
        if (i == 0) begin
            series_out = 1'b0;
        end
        else if (i < 9) begin
            series_out = in[data_count];
            data_count = data_count + 1;
        end
		else begin 
			series_out = (^in)^1;
			i = 0;
			data_count = 0;
			return;
		end
        i = i + 1;

    endtask //

*/


endmodule

