module alu (
input [31:0] operand1,
input [31:0] operand2,
input [3:0] alu_op,
output reg [31:0] result,
output zero
);
always @* begin
case (alu_op)
4'b0000: result = operand1 + operand2;
4'b0001: result = operand1 - operand2;
4'b0010: result = operand1 & operand2;
4'b0011: result = operand1 | operand2;
4'b0100: result = operand1 ^ operand2;
4'b0101: result = ~(operand1 | operand2);
4'b0110: result = ($signed(operand1) < $signed(operand2)) ? 1 : 0;
4'b0111: result = operand1 + operand2;
4'b1000: result = operand1 - operand2;
4'b1001: result = (operand1 < operand2) ? 1 : 0;

default: result = 32'b0;
endcase
end
assign zero = (result == 32'b0);
endmodule