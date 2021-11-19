module FF_D 
(
// clock
input bit      clk,
// reset
input bit      reset, 
// Data to store
input logic    d, 
// Stored data
output logic   q, q1
);

`include "macro_FFD.def"
`include "macro_ST.def"

`Macro_FFD(clk, "negedge", reset, d, q);
`Macro_ST("info");
`Macro_FFD(clk, "posedge", reset, d, q1);
`Macro_ST("fatal", 1);
endmodule