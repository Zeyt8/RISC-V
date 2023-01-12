`timescale 1ns/1ps

module imm_gen(
    input [31:0] in,
    output reg [31:0] out
);

    reg [6:0] opcode;
    reg [2:0] func;

    always @(in) begin
        opcode = in[6:0];
        func = in[14:12];
        case(opcode)
            // lw
            'b0000011: {out[31:12], out[11:0]} <= {20'b0, in[31:20]};
            'b0010011: begin
                case(func)
                    // addi, andi, ori, xori, slti, sltiu
                    'b000, 'b111, 'b110, 'b100, 'b010, 'b011: {out[31:12], out[11:0]} <= {20'b0, in[31:20]};
                    // srli, srai, slli
                    'b101, 'b101, 'b001: {out[31:6], out[5:0]} <= {26'b0, in[24:20]};
                endcase
            end
            // sw
            'b0100011: {out[31:12], out[11:0]} <= {20'b0, {in[31:25], in[11:7]}};
            // beq, bne, blt, bge, bltu, bgeu
            'b1100011: {out[31:13], out[12], out[10:5], out[4:1], out[11], out[0]} <= {19'b0, in[31:25], in[11:7], 1'b0};
            default: out <= 0;
        endcase
    end

endmodule