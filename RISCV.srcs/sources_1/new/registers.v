`timescale 1ns/1ps

module registers(
    input clk, reg_write,
    input [4:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    output [31:0] read_data1, read_data2
);
    
    reg [31:0] registers[0:31];
    integer i;

    initial begin
        for(i = 0; i < 32; i=i+1) begin
            registers[i] = i;
        end
    end
    
    // write
    always @(posedge clk) begin
        if(reg_write && write_reg != 0) begin
            registers[write_reg] <= write_data;
        end
    end
    
    // read
    assign read_data1 = (read_reg1 != 5'b0) ? //it is different from x0
                        (((reg_write == 1'b1) && (read_reg1 == write_reg)) ? 
                            write_data :
                            registers[read_reg1]) :
                        32'b0;
                      
    assign read_data2 = (read_reg2 != 5'b0) ? //it is different from x0
                        (((reg_write == 1'b1) && (read_reg2 == write_reg)) ? 
                            write_data :
                            registers[read_reg2]) :
                        32'b0;
    
endmodule
