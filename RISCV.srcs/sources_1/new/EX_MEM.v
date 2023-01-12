`timescale 1ns/1ps

module EX_MEM(
    input [31:0] pc_in,
    input [2:0] func3_in,
    input zero_in,
    input [31:0] ALU_in,
    input [31:0] reg2_data_in,
    input [4:0] rd_in,
    input write,
    input clk,
    input res,
    input RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_EX,
    output reg [31:0] pc_out,
    output reg [2:0] func3_out,
    output reg zero_out,
    output reg [31:0] alu_out,
    output reg [31:0] reg2_data_out,
    output reg [4:0] rd_out,
    output reg RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM
);

    always @(posedge clk) begin
        if(res) begin
            pc_out <= 0;
            func3_out <= 0;
            zero_out <= 0;
            alu_out <= 0;
            reg2_data_out <= 0;
            rd_out <= 0;
            RegWrite_MEM <= 0;
            MemtoReg_MEM <= 0;
            MemRead_MEM <= 0;
            MemWrite_MEM <= 0;
            Branch_MEM <= 0;
        end
        else begin
            if (write) begin
                pc_out <= pc_in;
                func3_out <= func3_in;
                zero_out <= zero_in;
                alu_out <= ALU_in;
                reg2_data_out <= reg2_data_in;
                rd_out <= rd_in;
                RegWrite_MEM <= RegWrite_EX;
                MemtoReg_MEM <= MemtoReg_EX;
                MemRead_MEM <= MemRead_EX;
                MemWrite_MEM <= MemWrite_EX;
                Branch_MEM <= Branch_EX;
            end
        end
    end
    
endmodule
