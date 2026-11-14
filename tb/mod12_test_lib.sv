/************************************************************************************************************************************
File name : mod12_test_lib.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/


/************************************************************************************************************************************
Base class test: contains creation of configuration classes, getting virtual interface and setting environment config
		 creation of environment handle object
*************************************************************************************************************************************/

class mod12_base_test extends uvm_test;

	`uvm_component_utils(mod12_base_test)
	
	
	mod12_env envh; // environment handle creation
	mod12_env_cfg env_cfg; // environment configuration haandle
	mod12_agt_cfg agt_cfg; // agent configuration handle
	bit has_agent = 1; // has_agent handle
	
	
	extern function new(string name "mod12_base_test",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
endclass


	function mod12_base_test :: new (string name "mod12_base_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	
	function mod12_base_test :: build_phase (uvm_phase phase);
		env_cfg = mod12_env_cfg :: type_id :: create("env_cfg");
		agt_cfg = mod12_agt_cfg :: type_id :: create("agt_cfg");
		if(has_agent)
			begin
				agt_cfg.is_active = UVM_ACTIVE;
		
				if(!(uvm_config_db #(virtual mod12_interface) :: get (this,"","vif",agt_cfg.vif)))
					`uvm_fatal("MOD12_BASE_TEST","Cannot get the virtual interface to the  configuration object ")
			
				env_cfg.agt_cfg = agt_cfg;
			end
		
		env_cfg.has_agent = has_agent;
		
		uvm_config_db #(mod12_env_cfg) :: set (this,"*","env_config",env_cfg);
		
		envh = mod12_env :: type_id :: create ("envh", this);
	endfunction
	
/************************************************************************************************************************************
Random class test : Runs the randomized sequence
*************************************************************************************************************************************/
	
	
class mod12_rand_test extends mod12_base_test;
	`uvm_component_utils(mod12_rand_test)
	
	mod12_sequence rand_tst;
	
	extern function new(string name "mod12_rand_test",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

	function mod12_rand_test :: new (string name "mod12_rand_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function mod12_rand_test :: build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task mod12_rand_test :: run_phase (uvm_phase phase);
		phase.raise_objection(this)
		rand_tst = mod12_sequence :: type_id :: create ("rand_tst");
		rand_tst.start(envh.agt.seqrh);
		phase.drop_objection(this)
	endtask
	
/************************************************************************************************************************************
Reset class test : Runs the reset sequence
*************************************************************************************************************************************/	
	
	
	
class mod12_rst_test extends mod12_base_test;

	`uvm_component_utils(mod12_rst_test)
	
	mod12_reset rst_tst;
	
	extern function new(string name "mod12_rst_test",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

	function mod12_rst_test :: new (string name "mod12_rest_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function mod12_rst_test :: build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task mod12_rst_test :: run_phase (uvm_phase phase);
		phase.raise_objection(this)
		rst_tst = mod12_reset :: type_id :: create ("rst_tst");
		rst_tst.start(envh.agt.seqrh);
		phase.drop_objection(this)
	endtask
	
/************************************************************************************************************************************
Counting up class test : Runs the sequence which counts up till 11
*************************************************************************************************************************************/	

	
class mod12_count_up_test extends mod12_base_test;

	`uvm_component_utils(mod12_count_up_test)
	
	mod12_countup countup_tst;
	
	extern function new(string name "mod12_count_up_test",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

	function mod12_count_up_test :: new (string name "mod12_count_up_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function mod12_count_up_test :: build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task mod12_count_up_test :: run_phase (uvm_phase phase);
		phase.raise_objection(this)
		countup_tst = mod12_countup :: type_id :: create ("rst_tst");
		countup_tst.start(envh.agt.seqrh);
		phase.drop_objection(this)
	endtask
	
/************************************************************************************************************************************
Counting down class test : Runs the sequence which counts down from 11 to 0
*************************************************************************************************************************************/
	
	
class mod12_count_dwn_test extends mod12_base_test;

	`uvm_component_utils(mod12_count_dwn_test)
	
	mod12_countdwn countdwn_tst;
	
	extern function new(string name "mod12_count_dwn_test",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

	function mod12_count_dwn_test :: new (string name "mod12_count_dwn_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function mod12_count_dwn_test :: build_phase (uvm_phase phase);
		super.build_phase(phase);
	endfunction
	
	task mod12_count_dwn_test :: run_phase (uvm_phase phase);
		phase.raise_objection(this)
		countdwn_tst = mod12_countdwn :: type_id :: create ("rst_tst");
		countdwn_tst.start(envh.agt.seqrh);
		phase.drop_objection(this)
	endtask
	
	
	
	
	
		

	
	
	
