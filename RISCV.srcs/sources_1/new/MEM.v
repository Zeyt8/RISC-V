module MEM(
    input clk,
    input [2:0] func3_MEM,
    input Zero_MEM,
    input [31:0] ALU_OUT_MEM,
    input [31:0] REG_DATA2_MEM,
    input Branch_MEM,
    input MemRead_MEM,
    input MemWrite_MEM,
    output [31:0] DATA_MEMORY_MEM,
    output PCSrc
);

    data_memory Data_Mem(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM, REG_DATA2_MEM, DATA_MEMORY_MEM);
    branch_control BC(Zero_MEM, ALU_OUT_MEM, Branch_MEM, func3_MEM, PCSrc);

endmodule