`timescale 1ns / 1ps

module RISC_V(
    input clk, reset,
    
    output [31:0] PC_EX,
    output [31:0] ALU_OUT_EX,
    output [31:0] PC_MEM,
    output PCSrc,
    output [31:0] DATA_MEMORY_MEM,
    output [31:0] ALU_DATA_WB,
    output [1:0] forwardA, forwardB,
    output pipeline_stall
);

    wire RegWrite, MemtoReg, MemRead, MemWrite;
    wire Branch, ALUSrc;
    wire [1:0] ALUop; // ALU src and op

    // input
    wire PC_Write;
    // output
    wire [31:0] PC_IF, INSTRUCTION_IF;
    IF ifModule(clk, reset, PCSrc, PC_Write, PC_MEM, PC_IF, INSTRUCTION_IF);

    // input
    wire IF_ID_WRITE;
    // output
    wire [31:0] PC_ID, INSTRUCTION_ID;
    IF_ID ifIdReg(clk, IF_ID_WRITE, reset, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);

    // input
    wire RD_WB;
    // output
    wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire [2:0] FUNC3_ID;
    wire [6:0] FUNC7_ID;
    wire [4:0] RS1_ID, RS2_ID, RD_ID;
    ID idModule(clk, PC_ID, INSTRUCTION_ID, RegWrite, ALU_DATA_WB, RD_WB, IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
                RegWrite, MemtoReg, MemRead, MemWrite, ALUop, ALUSrc, Branch,
                FUNC3_ID, FUNC7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);

    // hazard detection unit
    hazard_detection Hazard(RD_ID, RS1_ID, RS2_ID, MemRead, PC_Write, IF_ID_WRITE, pipeline_stall);

    // output
    wire [2:0] FUNC3_EX;
    wire [6:0] FUNC7_EX;
    wire [31:0] REG_DATA1_EX, REG_DATA2_EX;
    wire [4:0] RS1_out, RS2_out, RD_EX;
    wire [31:0] IMM_out;
    ID_EX idExReg(PC_ID, FUNC3_ID, FUNC7_ID, REG_DATA1_ID, REG_DATA2_ID, RS1_ID, RS2_ID, RD_ID, 1'b1, clk, reset, IMM_ID,
                  PC_EX, FUNC3_EX, FUNC7_EX, REG_DATA1_EX, REG_DATA2_EX, RS1_out, RS2_out, RD_EX, IMM_out);

    // input
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_EX;
    wire [31:0] PC_BRANCH_EX;
    wire [31:0] REG_DATA2_EX_FINAL;
    wire [4:0] rd_out;
    EX exModule(IMM_out, REG_DATA1_EX, REG_DATA2_EX, PC_EX, FUNC3_EX, FUNC7_EX, rd_out, RS1_out, RS2_out,
                RegWrite, MemToReg, MemRead, MemWrite, ALUop, ALUSrc, Branch, forwardA, forwardB, ALU_DATA_WB, ALU_OUT_MEM,
                ZERO_EX, ALU_OUT_EX, PC_BRANCH_EX, REG_DATA2_EX_FINAL);
    
    wire [2:0] FUNC3_MEM;
    wire zero_out;
    wire [31:0] REG_DATA2_MEM;
    EX_MEM exMemReg(PC_BRANCH_EX, FUNC3_EX, ZERO_EX, ALU_OUT_EX, REG_DATA2_EX_FINAL, RD_EX, 1'b1, clk, reset,
                    PC_MEM, FUNC3_MEM, zero_out, ALU_OUT_MEM, REG_DATA2_MEM, rd_out);

    MEM memModule(clk, FUNC3_MEM, zero_out, ALU_OUT_MEM, REG_DATA2_MEM, Branch, MemRead, MemWrite, DATA_MEMORY_MEM, PCSrc);

    wire [31:0] DATA_Memory_WB;
    wire [31:0] ALU_OUT_WB;
    MEM_WB memWbReg(DATA_MEMORY_MEM, ALU_OUT_MEM, rd_out, 1'b1, clk, reset, DATA_Memory_WB, ALU_OUT_WB, RD_WB);

    WB wbModule(ALU_OUT_WB, DATA_Memory_WB, MemtoReg, ALU_DATA_WB);

endmodule