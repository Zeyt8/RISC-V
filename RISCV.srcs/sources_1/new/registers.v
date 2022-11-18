`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 04:10:27 PM
// Design Name: 
// Module Name: registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module registers(
input clk, reg_write,
input [4:0] read_reg1, read_reg2, write_reg,
input [31:0] write_data,
output [31:0] read_data1, read_data2
    );
    
    reg [31:0] registers[31:0];
    
    initial
    begin
        for(int i = 0; i < 32; i++) begin
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
    always @(read_reg1, read_reg2)
    begin
        read_data1 <= registers[read_reg1];
        read_data2 <= registers[read_reg2];
    end
    
endmodule
