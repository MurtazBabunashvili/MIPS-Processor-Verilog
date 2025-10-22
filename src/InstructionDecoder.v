module InstructionDecoder (
input [31:0] instruction,
output [5:0] opcode,
output [4:0] rs, rt, rd, sa,
output [5:0] func,
output [15:0] immediate,
output [25:0] jump_index,
output reg [1:0] pc_mux_sel,
output reg [1:0] gp_mux_sel,
output reg alu_src,
output reg gp_we,
output reg mem_we,
output reg mem_to_reg,
output reg [3:0] alu_op,
output reg [1:0] af,
output reg [2:0] bf,
output reg [4:0] cad
);
assign opcode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign sa = instruction[10:6];
assign func = instruction[5:0];
assign immediate = instruction[15:0];
assign jump_index = instruction[25:0];
always @(*) begin
pc_mux_sel = 2'b00; gp_mux_sel = 2'b00;

alu_src = 1'b0; gp_we = 1'b0;
mem_we = 1'b0; mem_to_reg = 1'b0;
alu_op = 4'b0000;
af = 2'b00; bf = 3'b000;
cad = rd;
case (opcode)
6'b000000: begin
gp_we = 1'b1; cad = rd;
case (func)
6'b000000, 6'b000010, 6'b000011,
6'b000100, 6'b000110, 6'b000111:
gp_mux_sel = 2'b10;
6'b100000: alu_op = 4'b0000;
6'b100001: alu_op = 4'b0111;
6'b100010: alu_op = 4'b0001;
6'b100011: alu_op = 4'b1000;
6'b100100: alu_op = 4'b0010;
6'b100101: alu_op = 4'b0011;
6'b100110: alu_op = 4'b0100;
6'b100111: alu_op = 4'b0101;
6'b101010: alu_op = 4'b0110;
6'b101011: alu_op = 4'b1001;
6'b001000: begin pc_mux_sel = 2'b01; gp_we = 1'b0; end
6'b001001: begin pc_mux_sel = 2'b01; gp_mux_sel = 2'b11; cad = rd; end
endcase
end
6'b100011: begin alu_src = 1'b1; gp_we = 1'b1; mem_to_reg = 1'b1; gp_mux_sel = 2'b01; alu_op = 4'b0000; af = 2'b00; cad = rt; end
6'b101011: begin alu_src = 1'b1; mem_we = 1'b1; alu_op = 4'b0000; af = 2'b00; end
6'b001000: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0000; af = 2'b00; cad = rt; end
6'b001001: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0111; af = 2'b00; cad = rt; end
6'b001100: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0010; af = 2'b01; cad = rt; end
6'b001101: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0011; af = 2'b01; cad = rt; end
6'b001110: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0100; af = 2'b01; cad = rt; end
6'b001111: begin alu_src = 1'b1; gp_we = 1'b1; alu_op = 4'b0011; af = 2'b10; cad = rt; end
6'b000001: begin pc_mux_sel = 2'b10; bf = (rt == 5'b00000) ? 3'b010 : 3'b011; af = 2'b00; end

6'b000100: begin pc_mux_sel = 2'b10; bf = 3'b100; af = 2'b00; end
6'b000101: begin pc_mux_sel = 2'b10; bf = 3'b101; af = 2'b00; end
6'b000110: begin pc_mux_sel = 2'b10; bf = 3'b110; af = 2'b00; end
6'b000111: begin pc_mux_sel = 2'b10; bf = 3'b111; af = 2'b00; end
6'b000010: begin pc_mux_sel = 2'b11; end
6'b000011: begin pc_mux_sel = 2'b11; gp_we = 1'b1; gp_mux_sel = 2'b11; cad = 5'd31; end
default: ;
endcase
end
endmodule