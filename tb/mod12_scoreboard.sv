/************************************************************************************************************************************
File name : mod12_scoreboard.sv


Author name : Simhadri M H


Version : 1.1
*************************************************************************************************************************************/

class mod12_scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(mod12_scoreboard)
	
	uvm_tlm_analysis_fifo#(mod12_txn) fifo_wdh;
	
	mod12_txn txn;

	mod12_txn txn_cov;
	
	int txns_compared;

	covergroup mod12_count;
		
		reset : coverpoint rst_n {bins val[]= {0,1};}

		loadin : coverpoint load_in {bins val1 = 0;
					     bins val2 = 1;}
		
		updown : coverpoint up_dwn {bins val1 = 0;
					    bins val2 = 1;}

		countup : coverpoint qout {bins cntup = (0=>1=>2=>3=>4=>5=>6=>7=>8=>9=>10=>11);}
		
		countdwn : coverpoint qout {bins cntdwn = (11=>10=>9=>8=>7=>6=>5=>4=>3=>2=>1=>0);}

		randin : coverpoint in {bins a[] = {[0:11]};}

	endgroup


	
	extern function new (string name = "mod12_scoreboard", uvm_component parent);
	extern task run_phase (uvm_phase phase);
	extern task check_data(mod12_txn txn);
	extern task check_counter(mod12_txn txn);

endclass

	function mod12_scoreboard :: new (string name = "mod12_scoreboard", uvm_component parent);
		super.new(name,parent);
		fifo_wdh = new("fifo_wdh",this);
	endfunction
	
	
	task mod12_scoreboard :: run_phase (uvm_phase phase);
		forever
			begin
				fifo_wdh.get(txn);
				check_data(txn);
				txn_cov = txn;
				mod12_count.sample(txn_cov);
			end
	endtask
	
	
	task mod12_scoreboard :: check_data(mod12_txn txn);
		mod12_txn ref_txn1;
		$cast(ref_txn1,txn.clone());
		if(check_counter(ref_txn1))
			begin
				if(txn.compare(txn1))
					begin
						`uvm_info(get_type_name(),$sformatf("Scoreboard datamatch successful"),UVM_MEDIUM)
						txns_compared ++;
					end
				else
					`uvm_error(get_type_name(),$sformatf("\n scoreboard error[Data mismatch] :\n received transaction : \n  %s\n Expected transaction :\n %s 						",txn,ref_txn1))
			end
	endtask
	
	task mod12_scoreboard :: check_counter(mod12_txn txn);
	
		if(!txn.rst_n)
			txn.qout <= 4'd0;
		else if(txn.load_in)
			txn.qout <= in;
		else 
			begin
				if(txn.up_dwn)
					begin
						if(txn.qout == 4'd0)
							txn.qout <= 4'd12;
						else
							tn.qout <= txn.qout - 1'b1;
					end
				else
					begin
						if(txn.qout == 4'd12)
							txn.qout <= 4'd0;
						else
							txn.qout <= txn.qout + 1'b1;
					end
						
			end
		return (1);
	endtask
	
	
	
	
	
	
	
	
	
	
	
	
	
	
