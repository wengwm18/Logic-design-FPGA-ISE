`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:03 06/07/2016 
// Design Name: 
// Module Name:    freq_div2_2 
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
`define FREQ_DIV_BIT 25 // #bits for freq divider
`define FTSD_SCAN_CTL_BIT_WIDTH 2 // #bits for 14-seg display scan control

module freq_div2_2(clk_decide,clk_4bit,clk1hz,clk_debounce, clk_ftsd_scan, clk, rst_n);
	output clk1hz; // ~ 1.2 Hz clock
	output clk_debounce; // clk for push button debounce
	output [1:0] clk_ftsd_scan; // clk for 14-segment display
	input clk; // system clock, ~ 40 MHz
	input rst_n; // active low reset
	reg clk1hz, clk_debounce; // for always
	reg [1:0] clk_ftsd_scan; // for always
	reg [7:0] clk_buff_high; // local signal
	reg [7:0] clk_buff_low; // local signal
	output reg clk_decide;
	output reg [3:0]clk_4bit;
	wire [`FREQ_DIV_BIT-1:0] clk_cnt; // local signal for clock counter//
	
	assign clk_cnt ={clk1hz,clk_buff_high,clk_debounce,clk_ftsd_scan,clk_buff_low,clk_4bit,clk_decide} +1'b1;

	
	always@(posedge clk or negedge rst_n)
		begin
			if(~rst_n)
			{clk1hz,clk_buff_high,clk_debounce,clk_ftsd_scan,clk_buff_low,clk_4bit,clk_decide}<= `FREQ_DIV_BIT'd0; 
			else
			{clk1hz,clk_buff_high,clk_debounce,clk_ftsd_scan,clk_buff_low,clk_4bit,clk_decide}<= clk_cnt;
		end
 endmodule
