`timescale 1ns / 1ps

module IF_ID(
input clk, res,
input [31:0] pc_in, Instruction_IF, IF_ID_Write,
output [31:0] PC_out, Intruction_ID
);

	assign PC_out = pc_in;
	assign Instruction_out = Instruction_IF;

endmodule