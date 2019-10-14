`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:29 06/16/2016 
// Design Name: 
// Module Name:    random_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module random_counter(dip1,dip2,en,clk,rst_n
    );
	 
input dip1,dip2;
output reg en;
input clk;
input rst_n;
reg [26:0]cnt_tmp;
reg [26:0]cnt;	 



always@*	
   begin
	if(dip1==0 && dip2==0)
	   begin
		if(cnt== 27'd80000000)
		en=1;
		else
		en=0;		
		end
		
	else if (dip1==1 && dip2==0)
	   begin
		if(cnt== 27'd40000000) 
		en=1;
		else
		en=0;
		end
		
	else if (dip1==0 && dip2==1)
	   begin
		if(cnt== 27'd20000000)
		en=1;
		else
		en=0;	 
		end
		
	else
	   begin
		if(cnt==27'd10000000)
		en=1;	
		else	
		en=0;
		end
	end
	 
	 
		
	always@*
	 begin
		if(cnt==27'd80000000 && dip1==0 && dip2==0)
			cnt_tmp = 27'd0;
		else if(cnt==27'd40000000 && dip1==1 && dip2==0)
			cnt_tmp = 27'd0;
		else if(cnt==27'D20000000 && dip1==0 && dip2==1)
			cnt_tmp = 27'd0;
		else if(cnt==27'd10000000 && dip1==1 && dip2==1)
			cnt_tmp = 27'd0;
		else 
			cnt_tmp = cnt +1'd1;
	 end
		
		
	// Sequential logics: Flip flops
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			cnt <= 27'd0;
		else
			cnt<=cnt_tmp;
				


endmodule
