module mod12_counter(clk,rst_n,load_in,up_dwn,in,qout);
	wire clk,rst_n,load_in,up_dwn;
	reg[3:0]in;
	reg[3:0]qout;
	
	always@(posedge clk, negedge rst_n)
		begin
		if(!rst_n)
			qout <= 4'd0;
		else if(load_in)
			qout <= in;
		else 
			begin
				if(up_dwn)
					begin
						if(qout == 4'd0)
							qout <= 4'd12;
						else
							qout <= qout - 1'b1;
					end
				else
					begin
						if(qout == 4'd12)
							qout <= 4'd0;
						else
							qout <= qout + 1'b1;
					end
						
			end
		end
endmodule
