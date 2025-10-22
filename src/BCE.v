module BCE (
input [31:0] a,
input [31:0] b,
input [2:0] bf,
output reg bcres
);
always @(*) begin
case (bf)
3'b010:
bcres = (a[31] == 1);
3'b011:
bcres = (a[31] == 0);
3'b100:
bcres = (a == b);
3'b101:
bcres = (a != b);
3'b110:
bcres = (a[31] == 1 || a == 0);
3'b111:
bcres = (a[31] == 0 && a != 0);
default:
bcres = 0;
endcase
end
endmodule