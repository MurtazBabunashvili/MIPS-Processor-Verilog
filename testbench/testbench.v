// ==============================================
//  Testbench for Single-Cycle MIPS Processor
//  Author: Murtaz Babunashvili
//  Description: Generates clock/reset and monitors key outputs
// ==============================================

module testbench();
reg clk, reset;
wire [31:0] aluresout, shift_resultout, GP_DATA_INout;
MIPS_Processor uut (
.clk(clk),
.reset(reset),
.aluresout(aluresout),
.shift_resultout(shift_resultout),
.GP_DATA_INout(GP_DATA_INout)
);
always #5 clk = ~clk;

initial begin
clk = 0;
reset = 1;
#20 reset = 0;
end
always @(posedge clk) begin
$display("%4t | %b | %b | %b | %b | %b",
$time,
uut.PC,
uut.instruction,
aluresout,
shift_resultout,
GP_DATA_INout);
end
initial begin
#1000 $finish;
end
endmodule