`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:58 06/06/2016 
// Design Name: 
// Module Name:    upcounters_4 
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
module upcounters_4(s1000, s100, s10, s1, clk, rst_n,increase);

output [3:0]s1000;
output [3:0]s100;
output [3:0]s10;
output [3:0]s1;
input clk;
input rst_n;
input increase;
reg load_def_10;
reg load_def_1000;
wire cout_s1;
wire cout_s10;
wire cout_s100;
wire cout_s1000;


always@(s10 or s1)//second resets at 99
	if((s10==4'd9)&&(s1==4'd9))
		begin
		load_def_10=1'd1;
		end
	else
		begin
		load_def_10=1'd0;
		end
		
always@(s100 or s1000)//minute resets at 99
	if((s100==4'd9)&&(s1000==4'd9))
		begin
		load_def_1000=1'd1;
		end
	else
		begin
		load_def_1000=1'd0;
		end
	
	
	


upcounter U2(.value(s1), .carry(cout_s1), .clk(clk), .rst_n(rst_n), .inc(increase), .ld_def(load_def_sec), .def_value(4'd0));
upcounter U3(.value(s10), .carry(cout_s10), .clk(clk), .rst_n(rst_n), .inc(cout_s1 && increase), .ld_def(load_def_10), .def_value(4'd0));
upcounter U4(.value(s100), .carry(cout_s100), .clk(clk), .rst_n(rst_n), .inc(increase), .ld_def(load_def_1000), .def_value(4'd0));
upcounter U5(.value(s1000), .carry(cout_s1000), .clk(clk), .rst_n(rst_n), .inc(cout_s100 && increase), .ld_def(load_def_min), .def_value(4'd0));

endmodule
