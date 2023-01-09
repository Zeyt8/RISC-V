module WB(
    input [31:0] ALU_OUT_WB,
    input [31:0] DATA_Memory_WB,
    input MemtoReg_WB,
    output [31:0] ALU_DATA_WB
);

    mux2_1 mux(ALU_OUT_WB, DATA_Memory_WB, MemtoReg_WB, ALU_DATA_WB)

endmodule