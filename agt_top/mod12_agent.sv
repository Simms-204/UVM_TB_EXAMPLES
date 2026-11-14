/************************************************************************************************************************************
File name : mod12_agent.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/

class mod12_agent extends uvm_agent;

	`uvm_component_utils(mod12_agent)

	
	
	mod12_seqr seqrh;
	mod12_driver drvh;
	mod12_monitor monh;
	mod12_agt_cfg agt_cfg;
	
	
	extern function new (string name = "mod12_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


	function mod12_agent :: new(string name = "mod12_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	
	function void mod12_agent :: build_phase (uvm_phase phase);
		if(!(uvm_config_db #(mod12_txn):: get(this,"",agent_config,agt_cfg)))
			`uvm_fatal("MOD12AGENT","Error in getting the agent configuration object ")
		
		monh = mod12_monitor :: type_id :: create ("monh",this);
		
		if(agt_cfg.is_active == UVM_ACTIVE)
			begin
			drvh = mod12_driver :: type_id :: create ("drvh",this);
			seqrh = mod12_seqr :: type_id :: create ("seqrh",this);
			end
	endfunction
	
	function void mod12_agent :: connect_phase (uvm_phase phase);
		if(agt_cfg.is_active == UVM_ACTIVE)
			drvh.seq_item_port.connect(seqr.seq_item_export);
	endfunction
	
		
			
			
			
			
			
			
