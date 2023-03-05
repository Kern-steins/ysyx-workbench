module mux_4_1 #(
    parameter DATA_LEN = 4
) (
    input [DATA_LEN-1:0] in_1,
    input [DATA_LEN-1:0] in_2,
    input [DATA_LEN-1:0] in_3,
    input [DATA_LEN-1:0] in_4,
    input [1:0] op_mux,
    output logic [DATA_LEN-1:0] out_1
);
  always_comb begin
    case (op_mux)
      2'h0: out_1 = in_1;
      2'h1: out_1 = in_2;
      2'h2: out_1 = in_3;
      2'h3: out_1 = in_4;
      default: out_1 = '0;
    endcase
  end

endmodule

