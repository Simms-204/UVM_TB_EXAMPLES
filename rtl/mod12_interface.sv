interface mod12_interface(input bit clk);
	logic rst_n;
	logic [3:0]in;
	logic [3:0] qout;
	logic up_dwn;
	logic load_in;
	
	clocking drv_cb @(posedge clk)
	default input #1 output #1;
		output rst_n;
		output in;
		output up_dwn;
		output load_in;
	endclocking
	
	clocking mon_cb @(posedge clk)
	default input #1 output #1;
		input rst_n;
		input in;
		input qout;
		input up_dwn;
		input load_in;
	endclocking
	
	/*clocking rd_mon_cb @(posedge clk)
		input rst_n;
		input in;
	endclocking*/
	
	modport DRV(clocking drv_cb);
	modport MON(clocking mon_cb);
	//modport RD_MON(clocking rd_mon_cb);
	
endinterface
		
