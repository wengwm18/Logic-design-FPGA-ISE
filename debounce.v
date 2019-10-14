`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:52 06/18/2016 
// Design Name: 
// Module Name:    debounce 
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
module debounce_circuit(pb_debounced,clk,rst_n,pb_in);
output pb_debounced; // debounced push button output
input clk; // ~100Hz clock
input rst_n; // active low reset
input pb_in; //push button input
reg pb_debounced; // for always block
reg [3:0] db_window; // shift register flip flop
wire pb_debounced_next; // debounce result

 // combinational block
	assign pb_debounced_next=(db_window == 4'b1111) ? 1'b1 : 1'b0;
 // output register
	always @(posedge clk or negedge rst_n)
		if (~rst_n) 
		pb_debounced <= 1'b0;
		else 
		pb_debounced <= pb_debounced_next;
 // Shift register
	always @(posedge clk or negedge rst_n)
		if (~rst_n) 
		db_window <= 4'd0;
		else 
		db_window <= {db_window[2:0],~pb_in};
 endmodule