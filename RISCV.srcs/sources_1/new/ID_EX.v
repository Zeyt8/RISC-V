`timescale 1ns/1ps

module ID_EX(
    input [31:0] PC_in,
    input [2:0] func3_in,
    input [6:0] func7_in,
    input [31:0] ALU_A_in, ALU_B_in,
    input [4:0] RS1_in, RS2_in, RD_in,
    input write,
    input clk,
    input res,
    input [31:0] IMM_in,
    input RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, Branch_ID,
    input [1:0] ALUOp_ID,
    input ALUSrc_ID,
    output reg [31:0] PC_out,
    output reg [2:0] func3_out,
    output reg [6:0] func7_out,
    output reg [31:0] ALU_A_out, ALU_B_out,
    output reg [4:0] RS1_out, RS2_out, RD_out,
    output reg [31:0] IMM_out,
    output reg RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
    output reg [1:0] ALUOp_EX,
    output reg ALUSrc_EX
);

    always @(posedge clk) begin
        if(res) begin
            PC_out <= 0;
            func3_out <= 0;
            func7_out <= 0;
            ALU_A_out <= 0;
            ALU_B_out <= 0;
            RS1_out <= 0;
            RS2_out <= 0;
            RD_out <= 0;
            IMM_out <= 0;
            RegWrite_EX <= 0;
            MemtoReg_EX <= 0;
            MemRead_EX <= 0;
            MemWrite_EX <= 0;
            Branch_EX <= 0;
            ALUOp_EX <= 0;
            ALUSrc_EX <= 0;
        end
        else begin
            if (write) begin
                PC_out <= PC_in;
                func3_out <= func3_in;
                func7_out <= func7_in;
                ALU_A_out <= ALU_A_in;
                ALU_B_out <= ALU_B_in;
                RS1_out <= RS1_in;
                RS2_out <= RS2_in;
                RD_out <= RD_in;
                IMM_out <= IMM_in;
                RegWrite_EX <= RegWrite_ID;
                MemtoReg_EX <= MemtoReg_ID;
                MemRead_EX <= MemRead_ID;
                MemWrite_EX <= MemWrite_ID;
                Branch_EX <= Branch_ID;
                ALUOp_EX <= ALUOp_ID;
                ALUSrc_EX <= ALUSrc_ID;
            end
        end
    end
    
endmodule
