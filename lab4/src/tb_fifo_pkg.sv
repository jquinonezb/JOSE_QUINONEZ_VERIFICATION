// Coder:       Jose Leonardo Quiñonez
// Info:        Package of fifo
`ifndef TB_FIFO_PKG_SV
    `define TB_FIFO_PKG_SV
package tb_fifo_pkg;
    localparam W_DATA    = 8;
    localparam W_ADDR   = 4;
    localparam W_DEPTH    = 2**W_ADDR;

    typedef logic [W_DATA-1:0]   data_t;
    typedef logic [W_ADDR-1:0]   addr_t;
    typedef enum logic {
        NO_POP  = 0,
        POP     = 1
    }pop_e_t;

    typedef enum logic {
        NO_PUSH = 0,
        PUSH    = 1
    }push_e_t;    
endpackage
`endif 