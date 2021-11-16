`timescale 1ns / 1ps
module TB_FFD();
parameter WIDTH = 4; 
logic [WIDTH-1:0] D;
logic clk, reset;
logic [WIDTH-1:0] out;

FF_D #(WIDTH) Test (.Data_Input(D), .clk(clk), .Data_Output(out), .reset(reset));

initial begin 

	clk=0;
	repeat(200)begin
	#15 clk = ~clk;
	end  
end 
initial begin
 reset = 1;
 D = 4'b0101;
 if(reset)
 out = 0;
 else
 out <= D; 
 #100;
 reset = 0;
 D = 4'b0001;
 if(reset)
 out = 0;
 else
 out <= D;
 #100;
 reset = 1;
 D = 4'b0011;
 if(reset)
 out = 0;
 else
 out <= D;
 #100;
 reset = 0;
 D = 4'b0001;
 if(reset)
 out = 0;
 else
 out <= D;
end 
endmodule  
