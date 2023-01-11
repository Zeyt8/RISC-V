module EX(
    input [31:0] IMM_EX,
    input [31:0] REG_DATA1_EX, REG_DATA2_EX,
    input [31:0] PC_EX,
    input [2:0] FUNCT3_EX,
    input [6:0] FUNCT7_EX,
    input [4:0] RD_EX, RS1_EX, RS2_EX,
    input RegWrite_EX,
    input MemToReg_EX,
    input MemRead_EX,
    input MemWrite_EX,
    input [1:0] ALUop_EX,
    input ALUSrc_EX,
    input Branch_EX,
    input [1:0] forwardA, forwardB,
    
    input [31:0] ALU_DATA_WB,
    input [31:0] ALU_OUT_MEM,
    
    output ZERO_EX,
    output [31:0] ALU_OUT_EX,
    output [31:0] PC_Branch_EX,
    output [31:0] REG_DATA2_EX_FINAL
);

    wire ALU_Source1;
    wire ALU_Source2;
    wire [3:0] ALU_Control;
    
    adder add(IMM_EX, PC_EX, PC_Branch_EX);

    mux3_1 mux_a(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, ALU_Source1);
    mux3_1 mux_b(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, REG_DATA2_EX_FINAL);
    mux2_1 mux_c(IMM_EX, REG_DATA2_EX_FINAL, ALUSrc_EX, ALU_Source2);
    
    ALU alu(ALU_Control, ALU_Source1, ALU_Source2, ZERO_EX, ALU_out_EX);
    ALUcontrol ALUInput(ALUop_EX, FUNCT3_EX, FUNCT7_EX, ALU_Control);
    
    forwarding ForwardingUnit(RS1_EX, RS2_EX, RD_EX, RD_EX, MemWrite_EX, RegWrite_EX, forwardA, forwardB);

endmodule
