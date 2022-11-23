`timescale 1ns / 1ps

module IF_ID(
input clk, res,
input [31:0] pc_in, Instruction_IF, IF_ID_Write,
output reg [31:0] PC_out, Instruction_ID
);

    always @(posedge clk)
    begin
       if (res)
       begin
           PC_out <= 0;
           Instruction_ID <= 0;
       end
       else
       begin
	       PC_out <= pc_in;
	       Instruction_ID <= Instruction_IF;
	   end
    end

endmodule