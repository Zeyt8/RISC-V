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

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            memory[i] = 32'b0;
    end

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[11:2]] <= write_data;
        end
    end

    always @(mem_read) begin
        if (mem_read) begin
            read_data <= memory[address[11:2]];
        end
    end
    
endmodule
