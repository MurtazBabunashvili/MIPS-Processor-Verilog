module MEMORY #(
    parameter INIT = 1
) (
    input clk,
    input we,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    reg [31:0] memory [0:1023];

    always @(posedge clk) begin
        if (we)
            memory[addr[11:2]] <= data_in;
        data_out <= memory[addr[11:2]];
    end

    initial begin
        if (INIT) begin
            // Dummy path placeholder
            $readmemb("your/path/to/Instructions.txt", memory);
        end
    end
endmodule
