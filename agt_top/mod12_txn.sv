class mod12_txn extends uvm_sequence_item;

	rand bit rst_n;
	rand bit [3:0] in;
	rand bit load_in;
	rand bit up_dwn;
	bit [3:0] qout;
	
	`uvm_object_utils_begin(mod12_txn)
		`uvm_field_int(rst_n,UVM_ALL_ON)
		`uvm_field_int(in,UVM_ALL_ON)
		`uvm_field_int(qout,UVM_ALL_ON)
		`uvm_field_int(load_in,UVM_ALL_ON)
		`uvm_field_int(up_dwn,UVM_ALL_ON)
	`uvm_object_utils_end
	
	constraint in_range {in inside {[0:11]};}
	constraint rst_dist {rst_n dist {0 := 20, 1:= 80};}
	constraint loadin_dist {load_in dist {0:=20, 1:= 80};}
	constraint updwn_dist {up_dwn dist {0:= 20, 1:= 80};}
	
	extern function new(string name = "mod12_txn");
	
endclass

	function mod12_txn :: new(string name = "mod12_txn");
		super.new(name);
	endfunction
  			
