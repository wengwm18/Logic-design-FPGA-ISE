`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:22 06/18/2016 
// Design Name: 
// Module Name:    fsm 
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
`define STA_IDLE 1'b0
`define STA_COUNT 1'b1
module fsm(cnt_enable, in, clk, rst_n, en);
	output cnt_enable; // enable counter
	input clk; // clock
	input rst_n; // low active reset
	input in;   // push button
   input en;	
	reg cnt_enable; // for always
	reg state; // FSM state
	reg nx_state; // FSM next state

 // FSM state decision
	always @(state or in or en)
	case (state)
	`STA_IDLE:
		if (in && en)
		begin 
			nx_state = `STA_COUNT;
			cnt_enable = 1'b1; 
		end
		else
		begin
			nx_state = `STA_IDLE;
			cnt_enable = 1'b0; 
		end
		
	`STA_COUNT:
		if (in && en)
		begin 
			nx_state = `STA_IDLE;
			cnt_enable = 1'b0; 
		end
		else
		begin 
		nx_state = `STA_COUNT;
		cnt_enable = 1'b1;
		end
	default:
		begin 
		nx_state = `STA_IDLE;
		cnt_enable = 1'b0;
		end
		
		endcase
// FSM state transition
	always @(posedge clk or negedge rst_n)
		if (~rst_n) 
			state <= `STA_IDLE;
		else
			state <= nx_state;
endmodule
		