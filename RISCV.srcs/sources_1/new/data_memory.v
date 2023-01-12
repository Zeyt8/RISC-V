`timescale 1ns/1ps

module data_memory(
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);
    
    reg [31:0] memory [0:1023];

    always @(posedge clk) begin
        if (mem_read) begin
            read_data <= memory[address];
        end
        else if (mem_write) begin
            memory[address] <= write_data;
        end
    end
    
endmodule
