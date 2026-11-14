/************************************************************************************************************************************
File name : mod12_top.sv definitions file


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/


module mod12_top;
	import mod12_test_pkg::*;
	
	import uvm_pkg::*;
	
	bit clock;  
	always 
		#10 clock=!clock; 
		
		
	mod12_interface in0 (clock);
	
	 mod12_counter DUV (
        .clk     (clock),
        .rst_n   (in0.rst_n),
        .load_in (in0.load_in),
        .up_dwn  (in0.up_dwn),
        .in      (in0.in),
        .qout    (in0.qout)
    );
	initial begin
        uvm_config_db#(virtual mod12_interface)::set(null, "*", "vif", in0);
        run_test();
    end
initial if ($test$plusargs("DUMP")) begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mod12_top);
end
endmodule
