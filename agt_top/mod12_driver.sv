/************************************************************************************************************************************
File name : mod12_driver.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/

class mod12_driver extends uvm_driver #(mod12_txn);

	`uvm_component_utils(mod12_driver)
	
	virtual mod12_interface.DRV vif;
	
	mod12_agt_cfg agt_cfg;
	
	extern function new(string name = "mod12_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task drive_item(mod12_txn txn);
	
endclass

function mod12_driver :: new (string name = "mod12_driver", uvm_component parent);
	super.new(name,parent);
endfunction

function void mod12_driver :: build_phase(uvm_phase phase);
	if(!(uvm_config_db#(mod12_agt_cfg)::get(this,"","agent_config",agt_cfg)))
		`uvm_fatal("MOD12_DRIVER","Cannot get the configuration file,have you set it?")
		super.buil_phase(phase);
endfunction


function void mod12_driver :: connect_phase(uvm_phase phase);
	vif = agt_cfg.vif;
endfunction

task mod12_driver::run_phase(uvm_phase phase);
	forever
		begin
			seq_item_port.get_next_item(req);
			drive_item(req);
			seq_item_port.item_done(req);
		end
endtask

task mod12_driver::drive_item(mod12_txn txn);

	@(vif.drv_cb)
	vif.rst_n <= txn.rst_n;
	vif.in <= txn.in;
	vif.load_in <= txn.load_in;
	vif.up_dwn <= txn.up_dwn;
endtask








	
