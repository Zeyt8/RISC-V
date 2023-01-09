`timescale 1ns / 1ps

module MEM_WB(
    input [31:0] data_in,
    input [31:0] alu_in,
    input [4:0] rd_in,
    input write,
    input clk,
    input res,
    output [31:0] data_out,
    output [31:0] alu_out,
    output [4:0] rd_out
);

    always @(posedge clk) begin
        if(res) begin
            alu_out <= 0;
            data_out <= 0;
            rd_out <= 0;
        end
        else begin
            if (write) begin
                alu_out <= alu_in;
                data_out <= data_in;
                rd_out <= rd_in;
            end
        end
    end

endmodule
