module CLA_4bit 
(
    input [3:0] in_1,
    input [3:0] in_2,
    input Cin,
    output Cout,
    output P_n,
    output G_n,
    output check,
    output zero,
    output [3:0] sum
);
	wire [3:0]C;
	wire [3:0] P;
	wire [3:0] G;
	assign P = in_1 ^ in_2;
	assign G = in_1 & in_2;
	assign C[0]= G[0] | (Cin&P[0]);
	assign C[1]= G[1] | (P[1]&G[0]) | (P[1]&P[0]&Cin);
	assign C[2]= G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin);
	assign C[3]= G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin);
 
	assign sum[0]=in_1[0]^in_2[0]^Cin;
	assign sum[1]=in_1[1]^in_2[1]^C[0];
	assign sum[2]=in_1[2]^in_2[2]^C[1];
	assign sum[3]=in_1[3]^in_2[3]^C[2];
	assign Cout= C[3];
	assign P_n = P[3]&P[2]&P[1]&P[0];
	assign G_n = G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0]);

	assign check = C[3] ^ C[2];
	assign zero = (sum[3:0] == 4'b0)?1'b1:1'b0;


endmodule
