`timescale 1ns / 1ps

module registers(
input clk, reg_write,
input [4:0] read_reg1, read_reg2, write_reg,
input [31:0] write_data,
output [31:0] read_data1, read_data2
    );
    
    reg [31:0] registers[31:0];
    integer i;

    initial
    begin
        for(i = 0; i < 32; i=i+1) begin
            registers[i] = 0;
        end
    end
    
    // write
    always @(posedge clk)
    begin
        if(reg_write)
        begin
            registers[write_reg] <= write_data;
        end
    end
    
    // read
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    
endmodule
