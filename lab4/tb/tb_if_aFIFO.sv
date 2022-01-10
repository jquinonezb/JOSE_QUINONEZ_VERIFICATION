interface tb_if_aFIFO(
    input bit clock_r, clock_w,  
    input bit reset_r, reset_w
    );
import tb_fifo_pkg::*;

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
    input   data_in,
    input   pop,
    input   clock_r, //rd_clk
    input   clock_w, //wrt_clk
    input   reset_r, //rd_reset
    input   reset_w, //wrt_reset
    output  full, 
    output  empty,
    output  data_out
);

modport dvr(
    input    full, 
    input    empty,
    input    data_out, 
    output   push,
    output   data_in,
    output   pop,
    input   clock_r, //rd_clk
    input   clock_w, //wrt_clk
    output   reset_r, //rd_reset
    output   reset_w //wrt_reset
);

endinterface 