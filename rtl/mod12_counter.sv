module mod12_counter(clk,rst_n,load_in,up_dwn,in,qout);
	input wire clk,rst_n,load_in,up_dwn;
	input [3:0]in;
	output reg[3:0]qout;
	
	always@(posedge clk, negedge rst_n)
		begin
		if(!rst_n)
			qout <= 4'd0;
		else if(load_in)
			qout <= in;
		else 
			begin
				if(up_dwn)// up_dwn = 1 will make the counter a downcounter
					begin
						if(qout == 4'd0)
							qout <= 4'd11;
						else
							qout <= qout - 1'b1;
					end
				else
					begin
						if(qout == 4'd11)
							qout <= 4'd0;
						else
							qout <= qout + 1'b1;
					end
						
			end
		end
endmodule
