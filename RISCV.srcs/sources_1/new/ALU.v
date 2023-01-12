`timescale 1ns/1ps

module ALU(
    input [3:0] ALUop,
    input [31:0] ina, inb,
    output zero,
    output reg [31:0] out
);
    
    always @(*) begin
        case (ALUop)
            4'b0010: //addi
                out = ina + inb;
            4'b0100: //sll
                out = ina << inb;
            4'b0110: //sub
                out = ina - inb;
            4'b1000: //slti
                out = ($signed(ina) < $signed(inb));
            4'b0111: //sltiu
                out = (ina < inb);
            4'b0011: //xori
                out = ina ^ inb;
            4'b0101: //srli
                out = ina >> inb;
            4'b1001: //srai
                out = ina >>> inb;
            4'b0001: //ori
                out = ina | inb;
            4'b0000: //andi
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
