/************************************************************************************************************************************
File name : mod12_env_cfg.sv environment configuration file


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/



class mod12_env_cfg extends uvm_object;

	`uvm_object_utils(mod12_env_cfg)
	
	bit has_scoreboard;
	bit has_agent;
	
	mod12_agt_cfg agt_cfg;
	
	extern function new(string name = "mod12_env_cfg");
	
endclass



function mod12_env_cfg :: new(string name = "mod12_env_cfg");
	super.new(name)
endfunction	

