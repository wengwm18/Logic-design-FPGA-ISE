`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:25:39 06/06/2016 
// Design Name: 
// Module Name:    downcounter 
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
module downcounter(value, borrow, clk, inc, rst_n, max_value,ini_value,key);

output [3:0]value;
output borrow;
input clk;
input rst_n;
input key;
input inc;
input [3:0]ini_value;
input [3:0]max_value;
reg [3:0]value_tmp;
reg borrow;
reg [3:0]value;


always@*
	if(inc==1'd0)
		begin
		value_tmp=value;//not counting
		end
	else if((inc==1'd1) && (value==4'd0))
		begin
		value_tmp=max_value;//reset value_tmp=initial value when value=0
		end
	else
		begin
		value_tmp=value-4'd1;
		end
		
always@(inc or value)
	if((inc==1'd1)&&(value==4'd0))
		begin
		borrow=1'd1;//­É¦ìwhen value=0
		end
	else
		begin
		borrow=1'd0;
		end
		
//for flipflop
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		begin
		value<=4'd0;
		end
	else if(key==1)
		begin
		value<=value_tmp;
		end
	else
		begin
		value<=ini_value;
		end
		

endmodule
