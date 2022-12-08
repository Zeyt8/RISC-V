`timescale 1ns / 1ps

module ID(
input clk,
input [31:0] PC_ID, INSTRUCTION_ID,
input RegWrite_WB,
input [31:0] ALU_DATA_WB,
input [4:0] RD_WB,
output [31:0] IMM_ID,
output [31:0] REG_DATA1_ID, REG_DATA2_ID,
output RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,
output [1:0] ALUop_ID,
output ALUSrc_ID,
output Branch_ID
);

    wire [2:0] FUNCT3_ID; assign FUNCT3_ID = INSTRUCTION_ID[14:12];
    wire [6:0] FUNCT7_ID; assign FUNCT7_ID = INSTRUCTION_ID[31:25];
    wire [6:0] OPCODE_ID; assign OPCODE_ID = INSTRUCTION_ID[6:0];
    wire [4:0] RD_ID; assign RD_ID = INSTRUCTION_ID[11:7];
    wire [4:0] RS1_ID; assign RS1_ID = INSTRUCTION_ID[19:15];
    wire [4:0] RS2_ID; assign RS2_ID = INSTRUCTION_ID[24:20];

    control_path Control_Path(OPCODE_ID, Branch_ID, MemRead_ID, MemtoReg_ID, ALUop_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID);
    registers Register(clk, RegWrite_WB, RS1_ID, RS2_ID, RD_WB, ALU_DATA_WB, REG_DATA1_ID, REG_DATA2_ID);
    imm_gen Imm_Gen(INSTRUCTION_ID, IMM_ID);

endmodule