module ALU(
    input [3:0] ALUop,
    input [31:0] ina, inb,
    output zero,
    output reg [31:0] out
);
    
    always @(*) begin
        case (ALUop)
            4'b0000: //nop
                out = 0;
            4'b0010: //add(i)
                out = ina + inb;
            4'b0100: //sll
                out = ina << inb;
            4'b0110: //sub
                out = ina - inb;
            4'b1000: //slt(i)
                out = ($signed(ina) < $signed(inb));
            4'b0111: //slt(i)u
                out = (ina < inb);
            4'b0011: //xor(i)
                out = ina ^ inb;
            4'b0101: //srl(i)
                out = ina >> inb;
            4'b1001: //sra(i)
                out = ina >>> inb;
            4'b0001: //or(i)
                out = ina | inb;
            4'b0000: //and(i)
                out = ina & inb;
            4'b0110: //beq, bne
                out = (ina != inb);
            4'b1000: //blt, bge
                out = ($signed(ina) < $signed(inb));
            4'b0111: //bltu, bgeu
                out = (ina < inb);
        endcase
    end
    
    assign zero = (out == 1);
    
endmodule
