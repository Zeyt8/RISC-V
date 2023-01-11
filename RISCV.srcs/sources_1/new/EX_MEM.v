module EX_MEM(
    input [31:0] pc_in,
    input [2:0] func3_in,
    input zero_in,
    input [31:0] ALU_in,
    input [31:0] reg2_data_in,
    input [4:0] rd_in,
    input write,
    input clk,
    input res,
    output reg [31:0] pc_out,
    output reg [2:0] func3_out,
    output reg [31:0] zero_out,
    output reg [31:0] alu_out,
    output reg [31:0] reg2_data_out,
    output reg [4:0] rd_out
);

    always @(posedge clk) begin
        if(res) begin
            pc_out <= 0;
            func3_out <= 0;
            zero_out <= 0;
            alu_out <= 0;
            reg2_data_out <= 0;
            rd_out <= 0;
        end
        else begin
            if (write) begin
                pc_out <= pc_in;
                func3_out <= func3_in;
                zero_out <= zero_in;
                alu_out <= ALU_in;
                reg2_data_out <= reg2_data_in;
                rd_out <= rd_in;
            end
        end
    end
    
endmodule
