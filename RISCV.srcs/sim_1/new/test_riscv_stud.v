///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
    reg clk, reset;
    
    wire [31:0] PC_EX;
    wire [31:0] ALU_OUT_EX;
    wire [31:0] PC_MEM;
    wire PCSrc;
    wire [31:0] DATA_MEMORY_MEM;
    wire [31:0] ALU_DATA_WB;
    wire [1:0] forwardA, forwardB;
    wire pipeline_stall;
  
  RISC_V procesor(clk,reset,
         PC_EX,
         ALU_OUT_EX,
         PC_MEM,
         PCSrc,
         DATA_MEMORY_MEM,
         ALU_DATA_WB,
         forwardA,
         forwardB,
         pipeline_stall);    
         
  always #5 clk=~clk;
  
  /*initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
       IF_ID_write = 1'b1;      
       PCSrc = 1'b0;
       PC_write = 1'b1;    
       PC_Branch = 32'b0;  
       RegWrite_WB = 1'b0;       
       ALU_DATA_WB = 32'b0;
       RD_WB = 5'b0;           
       
    #10 reset=1'b0;
    #200 $finish;
   end
  
    begin: test_pc
        reg res, write;
        reg [31:0] in;
        wire [31:0] out;
        PC pc(clk, res, write, in, out);
        
        initial begin
            #5
            res = 0;
            write = 1;
            in = 24;
            #5
            write = 0;
            in = 19;
            #5
            res = 1;
        end
    end
    
    begin: test_inst_mem
        reg [9:0] address;
        wire [31:0] out;
    
        instruction_memory im(address, out);
        
        initial begin
            #5
            address = 0;
            #5
            address = 1;
            #5
            address = 2;
            #5
            address = 3;
        end
    end
    
    begin: test_registers
        reg reg_write;
        reg [4:0] read_reg1, read_reg2, write_reg;
        reg [31:0] write_data;
        wire [31:0] read_data1, read_data2;
    
        registers r(clk, reg_write, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2);
        
        initial begin
            #5
            reg_write = 0;
            write_reg = 0;
            write_data = 0;
            read_reg1 = 1;
            read_reg2 = 2;
            #5
            read_reg1 = 5;
            read_reg2 = 7;
            #5
            reg_write = 1;
            write_reg = 5;
            write_data = 2;
        end
    end
    
    begin: test_imm_gen
        reg [31:0] in;
        wire [31:0] out;
    
        imm_gen ig(in, out);
        
        initial begin
            #5
            in = 'hd1a02003;
            #5
            in = 'h108093;
            #5
            in = 'h1905013;
            #5
            in = 'h42a223;
            #5
            in = 'h4090e63;
        end
    end*/
endmodule