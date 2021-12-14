interface tb_if_aFIFO(
    input clock[1:0], 
    input reset[1:0]
    );
import fifo_pkg::*;

// Write process
push_e_t    push;
logic       full;
data_t      data_in;
// Read process
pop_e_t     pop;
logic       empty;
data_t      data_out;

modport fifo(
    input   push,
    output  full,
    input   data_in,
    input   pop, 
    output  empty,
    output  data_out,
    input   clock[0], //wrt_clk
    input   clock[1], //rd_clk
    input   reset[0], //wrt_reset
    input   reset[1] //rd_reset
);

modport dvr(
    output   push,
    input    full,
    output   data_in,
    output   pop, 
    input    empty,
    input    data_out,
    output   clock[0],
    output   clock[1],
    output   reset[0],
    output   reset[1]
);

endinterface 