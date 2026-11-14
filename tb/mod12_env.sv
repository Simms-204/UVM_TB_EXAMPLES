/************************************************************************************************************************************
File name : mod12_env.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/

class mod12_env extends uvm_env;

	`uvm_component_utils(mod12_env)
	
	mod12_env_cfg env_cfg;   // Environment configuration file
	
	mod12_agt_cfg agt_cfg;    // Agent configuration file
	
	mod12_agent agt;         // Agent handle
	
	mod12_scoreboard sb; 	 // Scoreboard handle
	
	extern function new (string name= "mod12_env",uvm_component parent);
	extern function void build_phase (uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
	
	
endclass


	function mod12_env :: new (string name = "mod12_env",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void mod12_env :: build_phase (uvm_phase phase);
		duper.build_phase(phase)		
		if(!(uvm_config_db #(mod12_env_cfg):: get (this,"", "env_config", env_cfg)))
			
				`uvm_fatal("MOD12ENV","Error while getting the environment confguration object")
				
		if(env_cfg.has_agent)
			begin
				uvm_config_db #(mod12_agt_cfg) :: set (this,"*","agent_config",env_cfg.agt_cfg);
				agt = mod12_agent :: type_id :: create ("agt",this);
			end
		if(env_cfg.has_scoreboard)
			begin
				sb = mod12_scoreboard :: type_id :: create ("sb",this);
			end
	endfunction
	
	function void mod12_env :: connect_phase(uvm_phase phase);
		if(env_cfg.has_agent && env_cfg.has_scoreboard)
		agt.monh.ap.connect(sb.fifo_wdh.analysis_export);
	endfunction
	
