module mux3_1(
    input [31:0] ina, inb, inc,
    input sel,
    output [31:0] out
);

	assign out = (sel == 0 ? ina : (sel == 1 ? inb : inc));
endmodule
