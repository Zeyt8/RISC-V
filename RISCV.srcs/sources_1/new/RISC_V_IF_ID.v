`timescale 1ns / 1ps

module RISC_V_IF_ID(
input clk, reset,
input IF_ID_WRITE,
input PCSrc, PC_Write,
input [31:0] PC_Branch,
input RegWrite_WB,
input [31:0] ALU_DATA_WB,
input [4:0] RD_WB,

output [31:0] PC_ID,
output [31:0] INSTRUCTION_ID,
output [31:0] IMM_ID,
output [31:0] REG_DATA1_ID,
output [31:0] REG_DATA2_ID,
output [2:0] FUNCT3_ID,
output [6:0] FUNCT7_ID,
output [6:0] OPCODE_ID,
output [4:0] RD_ID,
output [4:0] RS1_ID,
output [4:0] RS2_ID
);

endmodule