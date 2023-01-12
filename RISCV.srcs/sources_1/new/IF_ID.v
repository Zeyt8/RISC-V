`timescale 1ns/1ps

module IF_ID(
    input clk, write, res,
    input [31:0] pc_in, instruction_in,
    output reg [31:0] pc_out, instruction_out
);

    always @(posedge clk) begin
       if (res) begin
           pc_out <= 0;
           instruction_out <= 0;
       end
       else begin
            if (write) begin
                pc_out <= pc_in;
                instruction_out <= instruction_in;
            end
	   end
    end

endmodule