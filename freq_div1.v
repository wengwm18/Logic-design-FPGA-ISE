`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:21 06/06/2016 
// Design Name: 
// Module Name:    freq_div1 
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
//FROM¶À¤h°a
module freq_div1
(
	clk_slow,
	clk_out,					// 2s
	clk_out2,				// 1s
	clk_out3,				// 0.5s
	clk_out4,				// 0.25s
	ftsd_clk,
	clk,						// global clock input
	rst_n						// active low reset

);
	output clk_slow;
	output reg clk_out; 	// divided output
	output clk_out2;
	output clk_out3;
	output clk_out4;
	output [1:0] ftsd_clk; 
	input clk; 				// global clock input
	input rst_n;		 	// active low reset
   reg [25:0] cnt;		// remainder of the counter
	reg [25:0] cnt_tmp; 	// input to dff (in always block)
	
	
	assign clk_slow = cnt[24];
	assign ftsd_clk = cnt[17:16];
	assign clk_out2 = cnt[23];
	assign clk_out3 = cnt[22];
	assign clk_out4 = cnt[21];
	// Combinational logics: increment, neglecting overflow
	always @(cnt)
		begin
			cnt_tmp = cnt + 1'b1;
		end
	// Sequential logics: Flip flops
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			begin
				cnt <= 26'd0;
				clk_out <= 1'b0;
			end
		else if(cnt_tmp == 26'd40000000)
			begin
				clk_out <= ~clk_out;
				cnt <= 26'd0;
			end
		else
			cnt<=cnt_tmp;
				
endmodule