/************************************************************************************************************************************
File name : mod12_seqr.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/


class mod12_seqr extends uvm_sequencer #(mod12_txn);

	`uvm_component_utils(mod12_seqr)
	
	
	extern function new (string name = "mod12_seqr",uvm_component parent);
endclass


function mod12_seqr :: new (string name = "mod12_seqr",uvm_component parent);
	super.new(name,parent);
endfunction
