module FF_D
#(
	parameter WIDTH = 4
)
(
	input logic [WIDTH-1:0] Data_Input,
	input logic clk, reset,
	output logic [WIDTH-1:0] Data_Output
);

`ifdef pos_reset	
	always @(posedge clk or posedge reset)   
	begin
	if(reset)
	Data_Output = 0;
	else
	Data_Output <= Data_Input;
	end

`else
	always @(posedge clk or negedge reset)	   
	begin
	if(!reset)
	Data_Output = 0;
	else
	Data_Output  <= Data_Input;
	end
	
`endif
endmodule 