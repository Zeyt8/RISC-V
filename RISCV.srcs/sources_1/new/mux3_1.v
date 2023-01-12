`timescale 1ns/1ps

module mux3_1(
    input [31:0] ina, inb, inc,
    input [1:0] sel,
    output [31:0] out
);

	assign out = (sel == 2'b00 ? ina : (sel == 2'b01 ? inb : (sel == 2'b10 ? inc : 0)));
endmodule
