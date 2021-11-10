module Mux2x1 
#(
	parameter  DW = 4
)
(
	input logic [DW-1:0] data1, data2,
	input logic select,
	output logic [DW-1:0] result
);
 assign result = select ? data1 : data2;

endmodule  

