`timescale 1ns/1ps

module PC(
	input clk, res, write,
	input [31:0] in,
	output reg [31:0] out
);

	always @(posedge clk) begin
	   if (res)
	       out <= 0;
	   else if (write)
	       out <= in;
	end

endmodule