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


 	mod12_txn prev_txn; bit [3:0] exp_q; bit exp_known;
	covergroup mod12_count with function sample(mod12_txn t);
		
		reset : coverpoint t.rst_n {bins val[]= {0,1};}

		loadin : coverpoint t.load_in {bins val1 = {0};
					     bins val2 = {1};}
		
		updown : coverpoint t.up_dwn {bins val1 = {0};
					    bins val2 = {1};}

		countup : coverpoint t.qout {bins cntup = (0=>1=>2=>3=>4=>5=>6=>7=>8=>9=>10=>11);}
		
		countdwn : coverpoint t.qout {bins cntdwn = (11=>10=>9=>8=>7=>6=>5=>4=>3=>2=>1=>0);}

		randin : coverpoint t.in {bins a[] = {[0:11]};}

	endgroup


	
	extern function new (string name = "mod12_scoreboard", uvm_component parent);
	extern task run_phase (uvm_phase phase);
//	extern task check_data(mod12_txn txn);
//	extern function bit check_counter(mod12_txn txn);
	extern function bit [3:0] next_q(mod12_txn p, bit [3:0] q);
	extern function void check_data(mod12_txn txn);
endclass

	function mod12_scoreboard :: new (string name = "mod12_scoreboard", uvm_component parent);
		super.new(name,parent);
		fifo_wdh = new("fifo_wdh",this);
		mod12_count = new();
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
	
	
/*	task mod12_scoreboard :: check_data(mod12_txn txn);
		mod12_txn ref_txn1;
		$cast(ref_txn1,txn.clone());
		if(check_counter(ref_txn1))
			begin
				if(txn.compare(ref_txn1))
					begin
						`uvm_info(get_type_name(),$sformatf("Scoreboard datamatch successful"),UVM_MEDIUM)
						txns_compared ++;
					end
				else
					`uvm_error(get_type_name(),$sformatf("\n scoreboard error[Data mismatch] :\n received transaction : \n  %s\n Expected transaction :\n %s 						",txn,ref_txn1))
			end
	endtask
	
	function bit mod12_scoreboard :: check_counter(mod12_txn txn);
	
		if(!txn.rst_n)
			txn.qout = 4'd0;
		else if(txn.load_in)
			txn.qout = txn.in;
		else 
			begin
				if(txn.up_dwn)
					begin
						if(txn.qout == 4'd0)
							txn.qout = 4'd12;
						else
							txn.qout = txn.qout - 1'b1;
					end
				else
					begin
						if(txn.qout == 4'd12)
							txn.qout = 4'd0;
						else
							txn.qout = txn.qout + 1'b1;
					end
						
			end
		return (1);
	endfunction*/



 

	function bit[3:0] mod12_scoreboard ::  next_q(mod12_txn p, bit [3:0] q);
		if(!p.rst_n)        return 4'd0;
	//	else if(p.load_in)  return p.in;
		else if(p.load_in) begin
			if(p.in > 4'd11)
				`uvm_error(get_type_name(), $sformatf("Illegal load value %0d (legal range is 0..11)", p.in))
			return p.in;
		end
		else if(p.up_dwn)   return (q == 4'd0)  ? 4'd11 : q - 1'b1;
		else                return (q == 4'd11) ? 4'd0  : q + 1'b1;
	endfunction

	function void mod12_scoreboard :: check_data(mod12_txn txn);
		mod12_txn ref_txn;
		if(!txn.rst_n) begin               // async reset: qout is 0 right away
		exp_q = 4'd0;  exp_known = 1;
		end
		
		else if(!exp_known) begin          // NEW: no reset seen yet, start from what the DUT shows
		exp_q = txn.qout;  exp_known = 1;
		end

		else if(prev_txn != null)          // CHANGED: exp_known is already 1 here, so the check is dropped
		exp_q = next_q(prev_txn, exp_q);

		
		/*else if(exp_known && prev_txn != null)
		exp_q = next_q(prev_txn, exp_q);*/

		if(exp_known) begin
		$cast(ref_txn, txn.clone());
		ref_txn.qout = exp_q;
		
		if(txn.compare(ref_txn)) txns_compared++;
		else `uvm_error(get_type_name(), $sformatf("Mismatch\n received:\n%s expected:\n%s", txn.sprint(), ref_txn.sprint()))
		end	
	
		prev_txn = txn;
	endfunction
	
	
	
	
	
	
	
	
	
	
	
	
	
	
