`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:06 06/06/2016 
// Design Name: 
// Module Name:    upcounter 
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
module upcounter(value, carry, clk, rst_n, inc, ld_def, def_value);

output [3:0]value;
output carry;
input clk;
input rst_n;
input inc;
input [3:0]def_value;
input ld_def;
reg [3:0]value_tmp;
reg carry;
reg [3:0]value;

always@*
	if(ld_def==1'd1)
		begin
		value_tmp=def_value;//when some condition is being satisfied,load default value
		end
	else if(inc==1'd0)
		begin
		value_tmp=value;//not counting
		end
	else if((inc==1'd1) && (value==4'd9))
		begin
		value_tmp=4'd0;//reset value_tmp=0 when value=9
		end
	else
		begin
		value_tmp=value+4'd1;
		end
		
always@(inc or value)
	if((inc==1'd1)&&(value==4'd9))
		begin
		carry=1'd1;//¶i¦ìwhen value=9
		end
	else
		begin
		carry=1'd0;
		end
		
//for flipflop
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		begin
		value<=def_value;
		end
	else
		begin
		value<=value_tmp;
		end

endmodule

