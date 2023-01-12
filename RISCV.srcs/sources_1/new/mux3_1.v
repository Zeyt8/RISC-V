`timescale 1ns/1ps

module mux3_1(
    input [31:0] ina, inb, inc,
    input [1:0] sel,
    output [31:0] out
);

	assign out = (sel == 0 ? ina : (sel == 1 ? inb : inc));
endmodule
