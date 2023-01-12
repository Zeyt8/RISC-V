`timescale 1ns/1ps

module ALU(
    input [3:0] ALUop,
    input [31:0] ina, inb,
    output zero,
    output reg [31:0] out
);
    
    always @(*) begin
        case (ALUop)
            4'b0010: //add
                out = ina + inb;
            4'b0100: //sll
                out = ina << inb;
            4'b0110: //sub
                out = ina - inb;
            4'b1000: //slt
                out = ($signed(ina) < $signed(inb));
            4'b0111: //sltu
                out = (ina < inb);
            4'b0011: //xor
                out = ina ^ inb;
            4'b0101: //srl
                out = ina >> inb;
            4'b1001: //sra
                out = ina >>> inb;
            4'b0001: //or
                out = ina | inb;
            4'b0000: //and
                out = ina & inb;
            4'b0110: //beq, bne
                out = (ina != inb);
            4'b1000: //blt, bge
                out = ($signed(ina) < $signed(inb));
            4'b0111: //bltu, bgeu
                out = (ina < inb);
        endcase
    end
    
    assign zero = (out == 0);
    
endmodule
