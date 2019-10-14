`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:28:35 06/06/2016 
// Design Name: 
// Module Name:    downcounters_4 
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
module downcounters_4(s1000, s100, s10, s1, clk, rst_n, is1000, is100, is10, is1, decrease,key);

input clk;
input rst_n;
input [3:0]is1000;
input [3:0]is100;
input [3:0]is10;
input [3:0]is1;
input decrease;
input key;
output [3:0]s1000;
output [3:0]s100;
output [3:0]s10;
output [3:0]s1;
wire b_s1;
wire b_s10;
wire b_s100;
wire b_s1000;
reg inc_s100;
reg end_count;

always@(s10 or s1)
	if(s10==4'd0 && s1==4'd0)
		begin	
		inc_s100=1'd1;
		end
	else
		begin
		inc_s100=1'd0;
		end


always@(s1000 or s100 or s10 or s1)
	if(s1000==4'd0 && s100==4'd0 && s10==4'd0 && s1==4'd0)
		begin
		end_count=1'd0;
		end
	else
		begin
		end_count=1'd1;
		end




downcounter U0(.value(s1), .borrow(b_s1), .clk(clk), .inc( end_count && decrease), .rst_n(rst_n), .max_value(4'd9) ,.ini_value(is1),.key(key));//always counting down
downcounter U1(.value(s10), .borrow(b_s10), .clk(clk), .inc(b_s1 && end_count && decrease), .rst_n(rst_n), .max_value(4'd9) ,.ini_value(is10),.key(key));
downcounter U2(.value(s100), .borrow(b_s100), .clk(clk), .inc(inc_s100 && end_count && decrease), .rst_n(rst_n), .max_value(4'd9) ,.ini_value(is100),.key(key));
downcounter U3(.value(s1000), .borrow(b_s1000), .clk(clk), .inc(b_s100 && end_count && decrease), .rst_n(rst_n), .max_value(4'd9) ,.ini_value(is1000),.key(key));

endmodule

