module MIPS_Processor (
input clk,
input reset,
output [31:0] aluresout,
output [31:0] shift_resultout,
output [31:0] GP_DATA_INout
);

reg [31:0] PC;
wire [31:0] next_PC;
wire [31:0] PC_plus_4;
assign PC_plus_4 = PC + 4;
wire [31:0] instruction;
wire [5:0] opcode, func;
wire [4:0] rs, rt, rd, sa;
wire [15:0] immediate;
wire [25:0] jump_index;
wire [1:0] pc_mux_sel, gp_mux_sel, af;
wire [2:0] bf;
wire [3:0] alu_op;
wire [4:0] cad;
wire alu_src, gp_we, mem_we, mem_to_reg;
wire [31:0] rs_data, rt_data;
wire [31:0] alu_result;
wire [31:0] extended_immediate;
wire [31:0] shift_result;
wire [31:0] mem_data_out;
wire [31:0] gp_write_data;
wire alu_zero;
wire bcres;
reg gp_we_d, mem_we_d, mem_to_reg_d;
reg [4:0] cad_d;
reg [31:0] gp_data_d;
reg [31:0] alu_result_d;
always @(posedge clk or posedge reset) begin
if (reset) PC <= 32'h00400000;
else PC <= next_PC;
end
always @(posedge clk) begin
gp_we_d <= gp_we;
mem_we_d <= mem_we;
cad_d <= cad;

gp_data_d <= gp_write_data;
end
wire [31:0] branch_target = PC_plus_4 + (extended_immediate << 2);
wire [31:0] jump_target = {PC_plus_4[31:28], jump_index, 2'b00};
assign next_PC = (pc_mux_sel == 2'b00) ? PC_plus_4 :
(pc_mux_sel == 2'b01) ? rs_data :
(pc_mux_sel == 2'b10) ? (bcres ? branch_target : PC_plus_4) :
jump_target;
assign gp_write_data = (gp_mux_sel == 2'b00) ? alu_result :
(gp_mux_sel == 2'b01) ? mem_data_out :
(gp_mux_sel == 2'b10) ? shift_result :
PC_plus_4;
wire [31:0] alu_operand2 = alu_src ? extended_immediate : rt_data;
wire [1:0] shift_funct = (func == 6'b000000 || func == 6'b000100) ? 2'b00 :
(func == 6'b000010 || func == 6'b000110) ? 2'b10 :
(func == 6'b000011 || func == 6'b000111) ? 2'b11 : 2'b00;
wire [4:0] shift_amount = (func[2] == 1'b0) ? sa : rs_data[4:0];
assign aluresout = alu_result;
assign shift_resultout = shift_result;
assign GP_DATA_INout = gp_write_data;
InstructionDecoder decoder(
.instruction(instruction), .opcode(opcode),
.rs(rs), .rt(rt), .rd(rd), .sa(sa),
.func(func), .immediate(immediate),
.jump_index(jump_index), .pc_mux_sel(pc_mux_sel),
.gp_mux_sel(gp_mux_sel), .alu_src(alu_src),
.gp_we(gp_we), .mem_we(mem_we),
.mem_to_reg(mem_to_reg), .alu_op(alu_op),
.af(af), .bf(bf), .cad(cad)
);
GP register_file(

.clk(clk), .reset(reset), .we(gp_we_d),
.addr_a(rs), .addr_b(rt), .addr_c(cad_d),
.data_in(gp_data_d),
.data_out_a(rs_data), .data_out_b(rt_data)
);
alu alu_unit(
.operand1(rs_data), .operand2(alu_operand2),
.alu_op(alu_op), .result(alu_result),
.zero(alu_zero)
);
SignalExtension ext_unit(
.immediate(immediate), .af(af),
.extended_immediate(extended_immediate)
);
BCE branch_eval(
.a(rs_data), .b(rt_data),
.bf(bf), .bcres(bcres)
);
Shifter shifter_unit(
.funct(shift_funct), .a(rt_data),
.N(shift_amount), .R(shift_result)
);
MEMORY #(.INIT(1)) instr_mem(
.clk(clk), .we(1'b0), .addr(PC),
.data_in(32'b0), .data_out(instruction)
);
MEMORY #(.INIT(0)) data_mem(
.clk(clk), .we(mem_we_d),
.addr(alu_result), .data_in(rt_data),
.data_out(mem_data_out)
);
endmodule