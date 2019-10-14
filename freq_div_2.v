`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:07:42 06/06/2016 
// Design Name: 
// Module Name:    freq_div_2 
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
`define FREQ_DIV_BIT_25 25 // #bits for freq divider
`define FTSD_SCAN_CTL_BIT_WIDTH 2 // #bits for 14-seg display scan control

module freq_div_2( clk_32,clk_8,clk, rst_n);
	output clk_32;
	output clk_8;
	input clk; // system clock, ~ 40 MHz
	input rst_n; // active low reset
	reg [18:0] clk_buff_high; // local signal
	reg clk_32,clk_temp,clk_8;
	reg [2:0]clk_buff_low;	// local signal
	wire [`FREQ_DIV_BIT_25-1:0] clk_cnt; // local signal for clock counter//
	
	assign clk_cnt ={clk_buff_high,clk_32,clk_temp,clk_8,clk_buff_low} +1'b1;

	
	always@(posedge clk or negedge rst_n)
		begin
			if(~rst_n)
			{clk_buff_high,clk_32,clk_temp,clk_8,clk_buff_low}<= `FREQ_DIV_BIT_25'd0; 
			else
			{clk_buff_high,clk_32,clk_temp,clk_8,clk_buff_low}<= clk_cnt;
		end
 endmodule

