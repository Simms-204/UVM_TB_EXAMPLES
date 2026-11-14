/************************************************************************************************************************************
File name : mod12_sequence.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/



class mod12_sequence extends uvm_sequence#(mod12_txn);
	
	`uvm_object_utils(mod12_sequence)
		
	extern function new(string name = "mod12_sequence");
	extern task body();
endclass

	function mod12_sequence :: new(string name = "mod12_sequence");
		super.new(name);
	endfunction
	
	
	task mod12_sequence :: body();
		repeat(10)
			begin
			req = mod12_txn::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			`uvm_info("MOD12_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_HIGH) 
			finish_item(req);
			end	
	endtask
	
	
	
	
	
	
class mod12_reset extends mod12_sequence;

	`uvm_object_utils(mod12_reset)
	
	extern function new(string name = "mod12_reset");
	extern task body();
endclass

	function mod12_reset :: new(string name = "mod12_reset");
		super.new(name);
	endfunction
	
	task mod12_reset :: body ();
		    repeat (1) 
		    	begin
      				req = mod12_txn::type_id::create("req");
      				start_item(req);
      				assert(req.randomize() with {rst_n == 0;});
      				finish_item(req);
      				
      				start_item(req);
      				assert(req.randomize() with {rst_n == 0;});
      				finish_item(req);
      				
      				start_item(req);
      				assert(req.randomize() with {rst_n == 1;load_in ==0;});
      				finish_item(req);
      				
      				start_item(req);
      				assert(req.randomize() with {rst_n == 1;load_in == 0;});
      				finish_item(req);
      				
    			end

    	endtask
    	
    	



class mod12_countup extends mod12_sequence;

	`uvm_object_utils(mod12_countup)
	
	extern function new(string name = "mod12_countup");
  	extern task body();
  	
endclass


	function mod12_countup :: new(string name = "mod12_countup");
		super.new(name);
	endfunction
	
	
	task mod12_countup :: body();
		repeat(12)
			begin
				req = mod12_txn::type_id::create("req");
				start_item(req);
      				assert(req.randomize() with {rst_n == 1; up_dwn==0; load_in == 0;});
      				finish_item(req);
			end
	endtask
	
	
	
class mod12_countdwn extends mod12_sequence;

	`uvm_object_utils(mod12_countdwn)
	
	extern function new(string name = "mod12_countdwn");
  	extern task body();
  	
endclass


	function mod12_countdwn :: new(string name = "mod12_countdwn");
		super.new(name);
	endfunction
	
	
	task mod12_countdwn :: body();
		repeat(12)
			begin
				req = mod12_txn::type_id::create("req");
				start_item(req);
      				assert(req.randomize() with {rst_n == 1; up_dwn==1; load_in == 0;});
      				finish_item(req);
			end
	endtask
	



	




    	
    	
