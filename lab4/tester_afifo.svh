// Coder:       Jose Leonardo Quiñonez
// Info:        Class that receives the if.

class tester_afifo;
import fifo_pkg::*;
virtual tb_if_aFIFO itf;
addr_t q_1[$]; //Queue
integer count_queue;
    function new(virtual tb_if_aFIFO.fifo t);
        itf = t;
    endfunction


endclass //tester_afifo