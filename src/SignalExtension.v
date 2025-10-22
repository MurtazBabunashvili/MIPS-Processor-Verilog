module SignalExtension (
input [15:0] immediate,
input [1:0] af,
output reg [31:0] extended_immediate
);
always @(*) begin
case (af)
2'b00: extended_immediate = {{16{immediate[15]}}, immediate};
2'b01: extended_immediate = {16'b0, immediate};
2'b10: extended_immediate = {immediate, 16'b0};
default: extended_immediate = 32'b0;
endcase
end
endmodule