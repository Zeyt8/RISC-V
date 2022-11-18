`timescale 1ns / 1ps

module IF(
input clk, reset,
input PCSrc, PC_write,
input [31:0] PC_Branch,
output [31:0] PC_IF, INSTRUCTION_IF
    );

	wire [31:0] PC_IF_4;
	wire [31:0] PC_mux;
	mux2_1 mux(PC_IF_4, PC_Branch, PCSrc, PC_mux);
	PC pc(clk, reset, PC_Write, PC_mux, PC_IF);
	adder add(PC_IF, -4, PC_IF_4);
	instruction_memory im(PC_IF[11:2], INSTRUCTION_IF);
endmodule