`timescale 1ps / 1ps
module TB_FFD(); 
logic  D;
bit clk, reset;
logic  q, q1;
logic  gold;
//logic [WIDTH-1:0] error;

FF_D  Test (.d(D), .clk(clk), .q(q), .reset(reset), .q1(q1));

always
begin 
#8 clk = 1'b0;
#8 clk = 1'b1;
end

initial begin
//Values 
//logic [WIDTH-1:0] gold;
reset <= 0;
D <= 1'b1;
clk <= 0;
gold <= 1'b0;

#15 reset <= 1; 
#20 D <= 1'b1; gold <= D;
#15 reset <= 0; 
#20 D <= 1'b0;gold <= D;
#15 reset <= 0; 
#20 D <= 1'b1; gold <= D;
#15 reset <= 1; 
#20 D <= 1'b1; gold <= D;
#15 reset <= 1; 
#20 D <= 1'b1; gold <= D;
#15 reset <= 0; 
#20 D <= 1'b0;gold <= D;
end

endmodule  
