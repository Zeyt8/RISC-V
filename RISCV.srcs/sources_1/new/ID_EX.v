module ID_EX(
    input PC_in,
    input [2:0] func3_in,
    input [6:0] func7_in,
    input [31:0] ALU_A_in, ALU_B_in,
    input [4:0] RS1_in, RS2_in, RD_in,
    input write,
    input clk,
    input res,
    input [31:0] IMM_in,
    output PC_out,
    output [2:0] func3_out,
    output [6:0] func7_out,
    output [31:0] ALU_A_out, ALU_B_out,
    output [4:0] RS1_out, RS2_out, RD_out,
    output [31:0] IMM_out
);

    always @(posedge clk) begin
        if(res) begin
            PC_out <= 0;
            func3_out <= 0;
            func7_out <= 0;
            ALU_A_out <= 0;
            ALU_B_out <= 0;
            RS1_out <= 0;
            RS2_out <= 0;
            RD_out <= 0;
            IMM_out <= 0;
        end
        else begin
            if (write) begin
                PC_out <= PC_in;
                func3_out <= func3_in;
                func7_out <= func7_in;
                ALU_A_out <= ALU_A_in;
                ALU_B_out <= ALU_B_in;
                RS1_out <= RS1_in;
                RS2_out <= RS2_in;
                RD_out <= RD_in;
                IMM_out <= IMM_in;
            end
        end
    end
    
endmodule
