/************************************************************************************************************************************
File name : mod12_monitor.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/


class mod12_monitor extends uvm_monitor;

	`uvm_component_utils(mod12_monitor)
	
	uvm_analysis_port #(mod12_txn) ap;
	
	virtual mod12_interface.MON vif;
	
	mod12_txn txn;
	
	mod12_agt_cfg agt_cfg;
	
	
	
	extern function new(string name = "mod12_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
	
endclass

function mod12_monitor :: new (string name = "mod12_monitor", uvm_component parent);
	super.new(name,parent);
	ap= new("ap",this);
endfunction

function void mod12_monitor :: build_phase(uvm_phase phase);

	super.build_phase(phase);
	if(!(uvm_config_db#(mod12_agt_cfg)::get(this,"","agent_config",agt_cfg)))
		`uvm_fatal("MOD12_MONITOR","Cannot get the configuration file,have you set it?")
		//super.build_phase(phase);
endfunction


function void mod12_monitor :: connect_phase(uvm_phase phase);
	vif = agt_cfg.vif;
endfunction


task mod12_monitor :: run_phase(uvm_phase phase);
//	txn = mod12_txn :: type_id ::create("txn");
	
	forever
		collect_data();
endtask

task mod12_monitor :: collect_data();

	
	txn = mod12_txn :: type_id ::create("txn");
		@(vif.mon_cb);
		
		txn.rst_n = vif.mon_cb.rst_n;
		txn.load_in = vif.mon_cb.load_in;
		txn.up_dwn = vif.mon_cb.up_dwn;
		txn.qout = vif.mon_cb.qout;
		txn.in = vif.mon_cb.in;

		ap.write(txn);
		
endtask
		
		
		
		
		
		
		
		
		
		
		
		
		
		


