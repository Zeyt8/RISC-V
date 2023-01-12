`timescale 1ns/1ps

module ID(
    input clk,
    input [31:0] PC_ID, INSTRUCTION_ID,
    input RegWrite_WB,
    input [31:0] ALU_DATA_WB,
    input [4:0] RD_WB,
    input pipeline_stall,
    output [31:0] IMM_ID,
    output [31:0] REG_DATA1_ID, REG_DATA2_ID,
    output RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID,
    output Branch_ID,
    output [1:0] ALUop_ID,
    output ALUSrc_ID,
    output [2:0] FUNCT3_ID,
    output [6:0] FUNCT7_ID,
    output [4:0] RD_ID,
    output [4:0] RS1_ID,
    output [4:0] RS2_ID
);
    assign FUNCT3_ID = INSTRUCTION_ID[14:12];
    assign FUNCT7_ID = INSTRUCTION_ID[31:25];
    wire [6:0] OPCODE_ID = INSTRUCTION_ID[6:0];
    assign RD_ID = INSTRUCTION_ID[11:7];
    assign RS1_ID = INSTRUCTION_ID[19:15];
    assign RS2_ID = INSTRUCTION_ID[24:20];
    wire [31:0] Mux_OUT;

    control_path Control_Path(OPCODE_ID, Branch_ID, MemRead_ID, MemtoReg_ID, ALUop_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID);
    registers Register(clk, RegWrite_WB, RS1_ID, RS2_ID, RD_WB, ALU_DATA_WB, REG_DATA1_ID, REG_DATA2_ID);
    imm_gen Imm_Gen(INSTRUCTION_ID, IMM_ID);
    mux2_1 Mux({ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemRead_ID,MemWrite_ID,Branch_ID,ALUop_ID, 24'b0}, 0, pipeline_stall, Mux_OUT);

    assign {ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemRead_ID,MemWrite_ID,Branch_ID,ALUop_ID} = Mux_OUT[31:24];

endmodule