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

    wire [31:0] PC_IF, INSTRUCTION_IF;

    IF ifModule(clk, reset, PCSrc, PC_Write, PC_Branch, PC_IF, INSTRUCTION_IF);
    IF_ID ifIdReg(clk, reset, PC_IF, INTRUCTION_IF, IF_ID_WRITE, PC_ID, INSTRUCTION_ID);
    ID idModule(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, IMM_ID, REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);

endmodule