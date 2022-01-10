// Coder:       Jose Leonardo Quiñonez
// Info:        Class that receives the if.
import tb_fifo_pkg::*;
class tester_afifo;

localparam DW 		= 4;
localparam LIMSUP 	= 2**(DW);
localparam INC 		= 1;


// Interface
virtual tb_if_aFIFO itf;

// Queue
addr_t Q_1[$]; 
integer count_queue;
data_t x_all;
data_t v_random, expected_value;

// Virtualization of interface
function new(virtual tb_if_aFIFO.fifo t);
	itf = t;
endfunction

// Generate random flags 
function Random_flags();
	logic Random;
	Random = $urandom_range(0,1);
return Random;
endfunction 

// Inject one data at a time
task automatic inj_one_data(output logic full);
	data_t x_in;
	@(posedge itf.clock_r or negedge itf.reset_r)
	//if(!itf.reset_r)begin
	itf.push = push_e_t'($random());
	x_in = $random();
	itf.data_in = x_in;
	//end
	@(posedge itf.clock_w or negedge itf.reset_w)
	//if(!itf.reset_r)begin
		if (itf.push)begin
			if(Q_1.size < 16)begin
			Q_1.push_front(itf.data_in);
			end
			else begin
			full = 1'b1;
			itf.full = full;
			end
		end
	
endtask

// Inject the maximum amount of data
task automatic inj_all_data(output logic full);
for (x_all = 0; x_all < LIMSUP; x_all = x_all+INC) 
begin
	inj_one_data(.full(full));
end
endtask

// Extraction of one data at a time
task automatic ext_one_data(output data_t data_out, output data_t empty);
	data_t x_out;
	@(posedge itf.clock_r or negedge itf.reset_r)
	//if(!itf.reset_r)begin
	itf.pop = pop_e_t'($random());
	if (itf.pop)begin
	data_out = Q_1.pop_front();
	itf.data_out = data_out;
		if(Q_1.size == 0)begin
			empty = 1;
			itf.empty = empty;
		end
	end
endtask

/*========== Verify results ==========================*/
task Fifos_Comparison(input data_t expected, obtained);
	if (expected == obtained) begin
	$display($time, " SUCCESS: Expected = %b, Obtained = %b", expected, obtained);
	end
	else begin
	$display($time, " ERROR: Expected = %b, Obtained = %b", expected, obtained);
	end
endtask

//Verify size
task OverFlow_NoDataLost(input data_t obtained);
	if (obtained && Q_1.size > 15) begin 
	$display($time, " OVERFLOW: More data has been received than expected: Total = %d", Q_1.size);
	end
endtask

//Error if full flag does not up when more than 16 registers are added.
task Full_Error();
	$display($time, "OVERFLOW: More than 16 data has been inserted and FULL FLAG value is: %d", itf.full);
endtask

//========== Golden Models =================================================================

task Push_Validation();
        logic full;
        push_e_t push;
	data_t x_ref;
	push = (Random_flags()) ? PUSH : NO_PUSH;
        inj_one_data(.full(full));

        if (Q_1.size > 15 && full) begin
            Full_Error();
        end
endtask

task Pop_validation();
	pop_e_t  pop;
	data_t data_out;
	logic empty;

	pop = (Random_flags()) ? POP : NO_POP;

        ext_one_data(.data_out(data_out), .empty(empty));
        expected_value = Q_1.pop_back();
	Fifos_Comparison(.expected(expected_value), .obtained(data_out));
        OverFlow_NoDataLost(.obtained(data_out));
endtask

endclass 