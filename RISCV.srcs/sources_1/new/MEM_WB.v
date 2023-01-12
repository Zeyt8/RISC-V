`timescale 1ns/1ps

module MEM_WB(
    input [31:0] data_in,
    input [31:0] alu_in,
    input [4:0] rd_in,
    input write,
    input clk,
    input res,
    input RegWrite_MEM, MemtoReg_MEM,
    output reg [31:0] data_out,
    output reg [31:0] alu_out,
    output reg [4:0] rd_out,
    output reg RegWrite_WB, MemtoReg_WB
);

    always @(posedge clk) begin
        if(res) begin
            alu_out <= 0;
            data_out <= 0;
            rd_out <= 0;
            RegWrite_WB <= 0;
            MemtoReg_WB <= 0;
        end
        else begin
            if (write) begin
                alu_out <= alu_in;
                data_out <= data_in;
                rd_out <= rd_in;
                RegWrite_WB <= RegWrite_MEM;
                MemtoReg_WB <= MemtoReg_MEM;
            end
        end
    end

endmodule
