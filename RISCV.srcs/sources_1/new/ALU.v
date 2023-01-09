module ALU(
    input [3:0] ALUop,
    input [31:0] ina, inb,
    output zero,
    output reg [31:0] out
);
    
    always @(*) begin
        case (ALUop)
            // add
            4'b0010: out = ina + inb;
            // sub
            4'b0110: out = ina - inb;
            // or
            4'b0001: out = ina | inb;
            // and
            4'b0000: out = ina & inb;
        endcase
        if (out == 0)
            zero = 1;
        else
            zero = 0;
    end
    
endmodule
