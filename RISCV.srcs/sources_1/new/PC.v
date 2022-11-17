`timescale 1ns / 1ps

module PC(
input clk, res, write,
input [31:0] in,
output reg [31:0] out
    );

	always @(posedge clk)
	begin
		if (write)
			out <= in;
	end

	always @(posedge res)
	begin
		out <= 0;
	end
endmodule