module ALUcontrol(
    input [1:0] ALUop,
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] ALUinput
);
    
    always @(*) begin
        case (ALUop)
            // ld, sd
            2'b00: ALUinput = 4'b0010; //add
            // beq
            2'b01: ALUinput = 4'b0110; //sub
            2'b10: 
                begin
                    case (funct3)
                        3'b000:
                            case (funct7)
                                // add
                                7'b0000000: ALUinput = 4'b0010; //add
                                // sub
                                7'b0100000: ALUinput = 4'b0110; //sub
                            endcase
                        // or
                        3'b110: ALUinput = 4'b0001; //or
                        // and
                        3'b111: ALUinput = 4'b0000; //and
                    endcase
                end
        endcase
    end
    
endmodule
