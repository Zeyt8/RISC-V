`timescale 1ns / 1ps

module imm_gen(
input [31:0] in,
output reg [31:0] out
);

    reg opcode = in[6:0];
    reg func = in[14:12];

    case(opcode)
        // lw
        2'b0000011: assign out[11:0] = in[31:20];
        2'b0010011: begin
            case(func)
                // addi, andi, ori, xori, slti, sltiu
                2'b000, 2'b111, 2'b110, 2'b100, 2'b010, 2'b011: assign out[11:0] = in[31:20] << 1;
                // srli, srai, slli
                2'b101, 2'b101, 2'b001: assign out[5:0] = in[24:20] << 1;
            endcase
        end
        // sw
        2'b0100011: assign out[11:0] = {in[31:25], in[11:7]} << 1;
        // beq, bne, blt, bge, bltu, bgeu
        2'b1100011: assign {out[12], out[10:5], out[4:1], out[11]} = {in[31:25], in[11:7]};
    endcase

endmodule