`timescale 1ns / 1ps

module imm_gen(
input [31:0] in,
output reg [31:0] out
);

    wire [6:0] opcode;
    assign opcode = in[6:0];
    wire [2:0] func;
    assign func = in[14:12];

    always @(in)
        case(opcode)
            // lw
            'b0000011: out[11:0] <= in[31:20];
            'b0010011: begin
                case(func)
                    // addi, andi, ori, xori, slti, sltiu
                    'b000, 'b111, 'b110, 'b100, 'b010, 'b011: out[11:0] <= (in[31:20] << 1);
                    // srli, srai, slli
                    'b101, 'b101, 'b001: out[5:0] <= (in[24:20] << 1);
                endcase
            end
            // sw
            'b0100011: out[11:0] <= ({in[31:25], in[11:7]} << 1);
            // beq, bne, blt, bge, bltu, bgeu
            'b1100011: {out[12], out[10:5], out[4:1], out[11]} <= {in[31:25], in[11:7]};
        endcase

endmodule