module ps2 (
        input clk,    // Clock
        input rst,  // Asynchronous reset active low
        input ps2_clk,
        input ps2_data,
        output [7:0] out_1,
        output [7:0] out_2

    );

    logic [9:0] buffer;
    logic [9:0]	buffer_r;

    logic [7:0] fifo_data;
    logic	ready_r;

    logic [3:0] count;
    logic [3:0] count_r;
    logic [2:0] ps2_clk_sync;
    logic [2:0]	state;
    logic [2:0] next_state;

    wire	ps2_clk_neg;

    always_ff @(posedge clk) begin
        if(rst) begin
            ps2_clk_sync <= '0;
            state 	<= 	'0;
            count 	<= 	'0;
            buffer 	<= 	'0;
        end
        else begin
            ps2_clk_sync <= {ps2_clk,ps2_clk_sync[2:1]};
            state 	<= 	next_state;
            count 	<= 	count_r;
            buffer 	<= 	buffer_r;
        end
    end

    assign	ps2_clk_neg = ~ps2_clk_sync[1] & ps2_clk_sync[0];

    always_comb begin : proc_
        case (state)
            3'h0: begin
                if (ps2_clk != 1'b1) begin
                    next_state = 3'h1;
                    ready_r = '0;
                end
                else begin
                    next_state = 3'h0;
                    ready_r = '0;
                end
            end
            3'h1: begin
                if (ps2_clk_neg) begin
                    if (count == 4'd9) begin
                        count_r 	= 4'd0;
                        next_state 	= 3'h2;
                        buffer_r 	= {ps2_data,buffer[9:1]};
                        ready_r = '0;
                    end
                    else begin
                        count_r 	= count + 1'b1;
                        buffer_r 	= {ps2_data,buffer[9:1]};
                        next_state 	= state;
                        ready_r = '0;
                    end
                end
                else begin
                    count_r 	= 	count;
                    next_state	=	state;
                    buffer_r 	= 	buffer;
                    ready_r = '0;
                end
            end
            3'h2: begin
                if ((^buffer[9:1]) &&
                        (buffer[0] == 1'b0)) begin
                    fifo_data   = buffer[8:1];
                    buffer_r 	= '0;
                    ready_r 	= 1'b1;
                    next_state 	= 3'h0;
                    $display("receive %x",buffer[8:1]);
                end
                else begin
                    fifo_data	= 8'b0;
                    buffer_r 	= '0;
                    ready_r 	= 1'b0;
                    next_state 	= 3'h0;
                    $display("error %x",buffer[9:0]);
                end
            end

            default : begin
                count_r     = '0;
                next_state  = '0;
                buffer_r    = '0;
                fifo_data   = '0;
                ready_r     = '0;
            end
        endcase
    end

    logic [7:0] fifo_out;

    fifo #(
             .DATA_WIDTH(8),
             .DATA_DEPTH(16),
             .ADDR_WIDTH(4)
         ) inst_fifo (
             .rst     (rst),
             .wr_clk  (clk),
             .rd_clk  (clk),
             .wr_en   (ready_r),
             .rd_en   (1'b1),
             .wr_data (fifo_data),
             .rd_data (fifo_out),
             .empty   (),
             .full    ()
         );

    seg #(
            .DATA_LEN(4)
        ) inst_seg_1 (
            .in_valid  (1'b1),
            .in_1      (fifo_out[3:0]),
            .in_p      (1'b0),
            .out_1     (out_1),
            .out_valid ()
        );

    seg #(
            .DATA_LEN(4)
        ) inst_seg_2 (
            .in_valid  (1'b1),
            .in_1      (fifo_out[7:4]),
            .in_p      (1'b0),
            .out_1     (out_2),
            .out_valid ()
        );


endmodule :ps2
