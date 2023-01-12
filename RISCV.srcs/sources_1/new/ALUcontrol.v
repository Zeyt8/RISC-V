`timescale 1ns/1ps

module ALUcontrol(
    input [1:0] ALUop,
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] ALUinput
);
    
    always @(*) begin
        case (ALUop)
            2'b00: //lw and sw
                ALUinput = 4'b0010;
            2'b01: //branch
                case (funct3)
                    3'b000, 3'b001: //beq, bne
                        ALUinput = 4'b0110;
                    3'b100, 3'b101: //blt, bge
                        ALUinput = 4'b1000;
                    3'b110, 3'b111: //bltu, bgeu
                        ALUinput = 4'b0111;
                    default:
                        ALUinput = 4'b0000;
                endcase
            2'b10, 2'b11:
                case (funct3)
                    3'b000: //addi, sub
                        case (funct7)
                            7'b0000000: //addi
                                ALUinput = 4'b0010;
                            7'b0100000: //sub
                                ALUinput = 4'b0110;
                            default:
                                ALUinput = 4'b0000;
                        endcase
                    3'b001: //slli
                        ALUinput = 4'b0100;
                    3'b010: //slti
                        ALUinput = 4'b1000;
                    3'b011: //sltiu
                        ALUinput = 4'b0111;
                    3'b100: //xori
                        ALUinput = 4'b0011;
                    3'b101: //srli, srai
                        case (funct7)
                            7'b0000000: //srli
                                ALUinput = 4'b0101;
                            7'b0100000: //srai
                                ALUinput = 4'b1001;
                            default:
                                ALUinput = 4'b0000;
                        endcase
                    3'b110: //ori
                        ALUinput = 4'b0001;
                    3'b111: //andi
                        ALUinput = 4'b0000;
                endcase
        endcase
    end
    
endmodule
