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

    // output
    wire [31:0] PC_IF, INSTRUCTION_IF;
    IF ifModule(clk, reset, PCSrc, PC_Write, PC_MEM, PC_IF, INSTRUCTION_IF);

    // input
    wire IF_ID_WRITE;
    // output
    wire [31:0] PC_ID, INSTRUCTION_ID;
    IF_ID ifIdReg(clk, IF_ID_WRITE, reset, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);

    // input
    wire RegWrite_WB, ALU_DATA_WB, RD_WB;
    // output
    wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
    wire [1:0] ALUop_ID;
    wire ALUSrc_ID;
    wire Branch_ID;
    wire [2:0] FUNC3_ID;
    wire [6:0] FUNC7_ID;
    wire [4:0] RS1_ID, RS2_ID, RD_ID;
    ID idModule(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
                RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUop_ID, ALUSrc_ID, Branch_ID,
                FUNC3_ID, FUNC7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);

    // output
    wire [2:0] FUNC3_EX;
    wire [6:0] FUNC7_EX;
    wire [31:0] ALU_A_out, ALU_B_out;
    wire [4:0] RS1_out, RS2_out, RD_out;
    wire [31:0] IMM_out;
    ID_EX idExReg(PC_ID, FUNC3_ID, FUNC7_ID, REG_DATA1_ID, REG_DATA2_ID, RS1_ID, RS2_ID, RD_ID, 1b'1, clk, reset, IMM_ID,
                  PC_EX, FUNC3_EX, FUNC7_EX, REG_DATA1_ID, ALU_A_out, ALU_B_out, RS1_out, RS2_out, RD_out, IMM_out);

    // input
    wire [4:0] RD_WB, RD_MEM;
    wire RegWrite_MEM;
    wire rd_out;
    EX exModule(IMM_out, ALU_A_out, ALU_B_out, PC_EX, FUNC3_EX, FUNC7_EX, RD_out, RS1_out, RS2_out, );
    
    EX_MEM exMemReg();

    MEM memModule();
    MEM_WB memWbReg();
    WB wbModule();

    MEM_WB memWbReg();

endmodule