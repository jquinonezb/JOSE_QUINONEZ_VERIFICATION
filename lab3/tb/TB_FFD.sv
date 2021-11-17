`timescale 1ps / 1ps
module TB_FFD();
parameter WIDTH = 4; 
logic [WIDTH-1:0] D;
logic clk, reset;
logic [WIDTH-1:0] out;
logic [WIDTH-1:0] gold;
logic [WIDTH-1:0] error;

FF_D #(WIDTH) Test (.Data_Input(D), .clk(clk), .Data_Output(out), .reset(reset));

always
begin 
#8 clk = 1'b0;
#8 clk = 1'b1;
end

initial begin
//Values 
logic [WIDTH-1:0] gold;
reset <= 0;
D <= 4'b0101;
clk <= 0;
gold <= 4'b0;

#15 reset <= 1; 
#20 D <= 4'b0101; gold <= D;
#15 reset <= 0; 
#20 D <= 4'b0111;gold <= D;
#15 reset <= 0; 
#20 D <= 4'b0011; gold <= D;
end

task comprobar();
begin
error = | (gold^out);
`ifdef fatal
	if (error) $fatal($fatal,"Esta es la directiva fatal");
`elsif warning
	if (error) $warning($time,"WARNING!");
`elsif error
	if (error) $error($time,"ERROR");
`elsif info
	if (error) $info($time,"Aquí hay información");
`endif
end
endtask

endmodule  
