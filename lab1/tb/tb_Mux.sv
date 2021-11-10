`timescale 1ns / 1ps 
module tb_Mux();

//Declaration of data type 
	parameter  DW = 4;
	reg [DW-1:0] 	data1, data2;
	reg 		select;
	integer s_gold, Num_errors;
	integer i, j, k;
	wire [DW-1:0] result;
	
Mux2x1 uut(	.data1(data1), 
		.data2(data2), 
		.select(select), 
		.result(result)
);	
	
	`ifdef auto_init 
	//Here assign the initial values
   initial begin
   	i = 0; //Select
	j = 0; //data1
	k = 0; //data2
	select 	= 	i;
	data1 	= 	j;
	data2	= 	k;
	#1
	end 
	`endif 
	initial #1000 $finish;
	initial Num_errors = 0;

	
	initial begin
for (i = 0; i < 2; i = i + 1) 
	begin
		for (j = 0; j < 2**DW; j = j + 1)
			begin
				for (k = 0; k < 2**DW; k = k + 1)
					begin
					select		=	i; 
					data1		=	j; 
					data2		=	k; 
					case(i)
						0: begin
						s_gold = k;
						end
						1: begin
						s_gold = j;
						end
					endcase
	#1 if (result ^ s_gold) 
	begin  // Observe el tiempo de espera
	Num_errors = Num_errors + 1;
	$display ("Error: select = %b", i);
	$display ("Error: Valor Esperado = %h  Valor obtenido = %h", s_gold, result);
	end
end
end
end
	$display ("Num_errors = %d", Num_errors);

end
endmodule 						