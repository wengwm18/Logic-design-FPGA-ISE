`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:28 06/06/2016 
// Design Name: 
// Module Name:    buzzer_control 
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
module buzzer_control(clk, rst_n, note_div, au_left, au_right);
	input clk; // clock from crystal
	input rst_n; // active low reset
	input [19:0] note_div; // div for note generation
	output [15:0] au_left; // left sound au
	output [15:0] au_right; // right sound au
	reg [19:0] clk_cnt_next, clk_cnt;
	reg b_clk, b_clk_next;

 // Music note frequency generation
 always @(posedge clk or negedge rst_n)
	if (~rst_n)
	begin
	clk_cnt <= 20'd0;
	b_clk <= 1'b0;
	end
	
	else
	begin
	clk_cnt <= clk_cnt_next;
	b_clk <= b_clk_next;
	end
 
 always @*
	if (clk_cnt == note_div)
	begin
	clk_cnt_next = 20'd0;
	b_clk_next = ~b_clk;
	end
	
	else
	begin
	clk_cnt_next = clk_cnt + 1'b1;
	b_clk_next = b_clk;
	end

 // Assign the amplitude of the note

	
	assign au_left = (b_clk == 1'b0) ? 16'hC000 : 16'hFFF;
	assign au_right = (b_clk == 1'b0) ? 16'hC000 : 16'hFFF;
	endmodule
 