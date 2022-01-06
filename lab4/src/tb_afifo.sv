`timescale 1ns / 1ps
`include "tester_afifo.svh";
module tb_afifo();

import fifo_pkg::*;
//integer text_id;
bit 	clk_r, 
	clk_w, 
	rst_w, 
	rst_r;
int  i;


// Definition of tester
tester_afifo  t;

// Instance of interface
tb_if_aFIFO   itf(
	.clock_r(clk_r),
	.clock_w(clk_w),
	.reset_r(rst_r), 
	.reset_w(rst_w)
);

fifo_wrapper dut(
    	.wrclk(clk_w),
    	.wr_rst(rst_w),
    	.rdclk(clk_r),
   	.rd_rst(rst_r),
	.data_in(itf.data_in),
	.push(itf.push),
    	.full(itf.full),
    	.data_out(itf.data_out),
    	.pop(itf.pop),
	.empty(itf.empty)
    );

initial begin
                t   = new(itf);
                clk_r = 'd0; 
                rst_r = 'd1;
		clk_w = 'd0; 
                rst_w = 'd1; 
  #(2)   
  		rst_r = 'd0;
		rst_w = 'd0; 
  #(2)   	rst_r = 'd1;
		rst_w = 'd1; 

        //Write
        for (i = 0; i <= 10; i++) begin
            #10 t.Push_Validation();
        end
      
        //Read
        for (i = 0; i <= 10; i++) begin
            #10 t.Pop_validation(.counter(i));
        end
    end

    //2nd case: Overflow
    initial begin
	//Write
        for (i = 0; i <= 20; i++) begin
            #10 t.Push_Validation();
        end
        
        //Read
          for (i = 0; i <= 20; i++) begin
            #10 t.Pop_validation(.counter(i));
        end
    end

    //3rd case: Underflow
    initial begin
        for (i = 0; i <= 15; i++) begin
            #10 t.Push_Validation();
        end

        //Read
         for (i = 0; i <= 20; i++) begin
            #10 t.Pop_validation(.counter(i));
        end
	  $stop;
    end

    initial begin
    	forever #1 clk_r = !clk_r;
	forever #1 clk_w = !clk_w;
    end
  
endmodule