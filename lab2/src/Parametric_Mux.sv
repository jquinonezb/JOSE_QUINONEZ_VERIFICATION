module Parametric_Mux
#(
	parameter WIDTH = 4,
	parameter SELECT_SIZE = 2
)
( 
	input 	logic [WIDTH-1:0] in [2**SELECT_SIZE] ,
	input 	logic [SELECT_SIZE-1:0] selector,
	output 	logic [WIDTH-1:0] out
);
	genvar i;
	generate;
	for (i = 0; i < 2**SELECT_SIZE; i++) begin 
	assign out = (selector == i) ? in[i] : 0;
	end
	endgenerate
endmodule 