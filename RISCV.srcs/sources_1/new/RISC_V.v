`timescale 1ns/1ps

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

    wire RegWrite_ID, MemToReg_ID, MemRead_ID, MemWrite_ID, Branch_ID;
    wire [1:0] ALUop_ID;
    wire ALUSrc_ID;

    wire RegWrite_EX, MemToReg_EX, MemRead_EX, MemWrite_EX, Branch_EX;
    wire [1:0] ALUop_EX;
    wire ALUSrc_EX;
    
    wire RegWrite_MEM, MemToReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM;

    wire RegWrite_WB, MemToReg_WB;

    // input
    wire PC_Write;
    // output
    wire [31:0] PC_IF, INSTRUCTION_IF;
    IF ifModule(
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .PC_write(PC_Write),
        .PC_Branch(PC_MEM),
        .PC_IF(PC_IF),
        .INSTRUCTION_IF(INSTRUCTION_IF)
    );

    // input
    wire IF_ID_WRITE;
    // output
    wire [31:0] PC_ID, INSTRUCTION_ID;
    IF_ID ifIdReg(
        .clk(clk),
        .write(IF_ID_WRITE),
        .res(reset),
        .pc_in(PC_IF),
        .instruction_in(INSTRUCTION_IF),
        .pc_out(PC_ID),
        .instruction_out(INSTRUCTION_ID)
    );

    // input
    wire [4:0] RD_WB, RD_EX;
    // output
    wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire [2:0] FUNC3_ID;
    wire [6:0] FUNC7_ID;
    wire [4:0] RS1_ID, RS2_ID, RD_ID;
    ID idModule(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, pipeline_stall, IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
                RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, Branch_ID, ALUop_ID, ALUSrc_ID,
                FUNC3_ID, FUNC7_ID, RD_ID, RS1_ID, RS2_ID);

    // hazard detection unit
    hazard_detection Hazard(RD_EX, RS1_ID, RS2_ID, MemRead_ID, PC_Write, IF_ID_WRITE, pipeline_stall);

    // output
    wire [2:0] FUNC3_EX;
    wire [6:0] FUNC7_EX;
    wire [31:0] REG_DATA1_EX, REG_DATA2_EX;
    wire [4:0] RS1_out, RS2_out;
    wire [31:0] IMM_EX;
    ID_EX idExReg(PC_ID, FUNC3_ID, FUNC7_ID, REG_DATA1_ID, REG_DATA2_ID, RS1_ID, RS2_ID, RD_ID, 1'b1, clk, reset, IMM_ID,
                  RegWrite_ID, MemToReg_ID, MemRead_ID, MemWrite_ID, Branch_ID, ALUop_ID, ALUSrc_ID,
                  PC_EX, FUNC3_EX, FUNC7_EX, REG_DATA1_EX, REG_DATA2_EX, RS1_out, RS2_out, RD_EX, IMM_EX,
                  RegWrite_EX, MemToReg_EX, MemRead_EX, MemWrite_EX, Branch_EX, ALUop_EX, ALUSrc_EX);

    // input
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_EX;
    wire [31:0] PC_BRANCH_EX;
    wire [31:0] REG_DATA2_EX_FINAL;
    wire [4:0] RD_MEM;
    EX exModule(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX, FUNC3_EX, FUNC7_EX, RD_EX, RS1_out, RS2_out,
                RD_WB, RD_MEM, RegWrite_EX, MemToReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc_EX, Branch_EX, RegWrite_MEM, RegWrite_WB, forwardA, forwardB, ALU_DATA_WB, ALU_OUT_MEM,
                ZERO_EX, ALU_OUT_EX, PC_BRANCH_EX, REG_DATA2_EX_FINAL);
    
    wire [2:0] FUNC3_MEM;
    wire ZERO_MEM;
    wire [31:0] REG_DATA2_MEM;
    EX_MEM exMemReg(PC_BRANCH_EX, FUNC3_EX, ZERO_EX, ALU_OUT_EX, REG_DATA2_EX_FINAL, RD_EX, 1'b1, clk, reset,
                    RegWrite_EX, MemToReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
                    PC_MEM, FUNC3_MEM, ZERO_MEM, ALU_OUT_MEM, REG_DATA2_MEM, RD_MEM,
                    RegWrite_MEM, MemToReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM);

    MEM memModule(clk, FUNC3_MEM, ZERO_MEM, ALU_OUT_MEM, PC_MEM, REG_DATA2_MEM, RD_MEM,
                  RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
                  DATA_MEMORY_MEM, PCSrc);

    wire [31:0] DATA_Memory_WB;
    wire [31:0] ALU_OUT_WB;
    MEM_WB memWbReg(DATA_MEMORY_MEM, ALU_OUT_MEM, RD_MEM, 1'b1, clk, reset,
                    RegWrite_MEM, MemToReg_MEM,
                    DATA_Memory_WB, ALU_OUT_WB, RD_WB,
                    RegWrite_WB, MemToReg_WB);

    WB wbModule(ALU_OUT_WB, DATA_Memory_WB, MemtoReg_WB, RegWrite_WB, RD_WB, ALU_DATA_WB);

endmodule