`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:54 06/18/2016 
// Design Name: 
// Module Name:    one_pulse 
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
module one_pulse(out_pulse,clk,rst_n,in_trig);
	output out_pulse; // output one pulse
	input clk; // clock input
	input rst_n; // active low reset
	input in_trig; // input trigger	
	reg out_pulse; // for always
	reg in_trig_delay; // local signal
	wire out_pulse_next; // local signal

 // combinational block
	assign out_pulse_next = in_trig & (~in_trig_delay);
 // Buffer input
	always @(posedge clk or negedge rst_n)
		if (~rst_n) in_trig_delay <= 1'b0;
		else in_trig_delay <= in_trig;
 // output register
	always @(posedge clk or negedge rst_n)
		if (~rst_n) out_pulse <=1'b0;
		else out_pulse <= out_pulse_next;
		
endmodule
