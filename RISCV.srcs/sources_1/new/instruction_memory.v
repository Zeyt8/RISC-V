`timescale 1ns / 1ps

module instruction_memory(
input [9:0] address,
output reg[31:0] out
);

    reg [31:0] codeMemory[0:1023];
    
    initial $readmemh("code.mem", codeMemory);
    
    always @(address) begin
        out <= codeMemory[address];
    end
    
endmodule