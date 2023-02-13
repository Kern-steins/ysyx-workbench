typedef enum logic [1:0] {
    nop = 2'b0
    
}operation_t;



module dut #(
    parameter WIDTH = 6 
) (
	input clk,    // Clock
	input rst,  // Asynchronous reset active low
	output logic [15:0] led
);
    logic [15:0] led_r;

	always_ff @(posedge clk or posedge rst) begin 
		if(rst) begin
			led <= 16'h0;
		end else begin
			led <= led_r;
		end
	end

	always_comb begin
		if (led[15] == 1'b0) begin
			led_r = (led << 1) + 16'h1;	
		end
		else begin
			led_r = (led << 1);
		end
	end

endmodule 
