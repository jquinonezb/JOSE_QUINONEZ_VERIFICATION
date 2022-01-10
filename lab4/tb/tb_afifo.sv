`timescale 100ps / 1ps
`include "tester_afifo.svh";
module tb_afifo();

import fifo_pkg::*;
//integer text_id;
bit 	clk_r, 
	clk_w, 
	rst_w, 
	rst_r;
int  reset = 3;
localparam 	times_push 	= 18,
		times_pop 	= 16,
		times_rep 	= 5;


data_t empty, data_out;
logic full;
// Definition of tester
tester_afifo  t;

// Instance of interface
tb_if_aFIFO   itf(
	.clock_w(clk_w),
    	.reset_w(rst_w),
    	.clock_r(clk_r),
   	.reset_r(rst_r)
);

fifo_wrapper dut(
    	.wr_clk(clk_w),
    	.wr_rst(rst_w),
    	.rd_clk(clk_r),
   	.rd_rst(rst_w),
	.data_in(itf.data_in),
	.push(itf.push),
    	.full(itf.full),
    	.data_out(itf.data_out),
    	.pop(itf.pop),
	.empty(itf.empty)
	
    );

initial begin
fork
    	forever #1 clk_r = !clk_r;
	forever #2 clk_w = !clk_w;
join
end

initial begin
                t   = new(itf);
        
	repeat(reset) begin 		
		#3 	rst_w = ~rst_w;
			rst_r = ~rst_r;
	end

	repeat(times_rep)begin 
	//Random_flags();
	
	//PUSH
	#2 repeat(times_push)begin
	t.inj_one_data(.full(full));
	end
        //POP
        #2 repeat(times_pop)begin
	t.ext_one_data(.data_out(data_out), .empty(empty));
	end 
	end
end 
endmodule