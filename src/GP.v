module GP (
input clk,
input reset,
input we,
input [4:0] addr_a,
input [4:0] addr_b,
input [4:0] addr_c,
input [31:0] data_in,
output [31:0] data_out_a,
output [31:0] data_out_b
);
reg [31:0] registers[31:0];
assign data_out_a = (addr_a == 5'b00000) ? 32'b0 : registers[addr_a];
assign data_out_b = (addr_b == 5'b00000) ? 32'b0 : registers[addr_b];
integer i;
always @(posedge clk or posedge reset) begin
if (reset) begin
for (i = 0; i < 32; i = i + 1)
registers[i] <= 32'b0;
end else if (we && addr_c != 5'b00000) begin
registers[addr_c] <= data_in;
end
end
endmodule