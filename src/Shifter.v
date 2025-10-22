module Shifter (
input [1:0] funct,
input [31:0] a,
input [4:0] N,
output reg [31:0] R
);
wire [31:0] logical_right_result = a >> N;
wire sign_bit = a[31];
wire [31:0] sign_mask = (N == 0) ? 32'b0 : ({32{sign_bit}} << (32 - N));
always @(*) begin
case (funct)
2'b00: R = a << N;
2'b10: R = a >> N;
2'b11: R = logical_right_result | sign_mask;
default: R = a;
endcase
end
endmodule