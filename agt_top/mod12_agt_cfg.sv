/************************************************************************************************************************************
File name : mod12_agt_cfg.sv agnt configuration file


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/


class mod12_agt_cfg extends uvm_object;

	`uvm_object_utils(mod12_agt_cfg)
	
	virtual mod12_interface vif;
	
	uvm_active_passive_enum is_active ;
	
	
	
	extern function new(string name = "mod12_agt_cfg");
	
endclass


function mod12_agt_cfg :: new (string name = "mod12_agt_cfg");
	
		super.new(name);
endfunction


