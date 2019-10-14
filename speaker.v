`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:50 06/06/2016 
// Design Name: 
// Module Name:    speaker 
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
module speaker(au_appsel, au_sysclk, au_bck, au_ws, au_data, clk,clk_out, state,rst_n,voice); 
	input voice;
	input [3:0]state;
	input clk_out;
	input clk; // clock from the crystal 
	input rst_n; // active low reset 
	output au_appsel; // playing mode selection 
	output au_sysclk; // control clock for DAC (from crystal) 
	output au_bck; // bit clock of au data (5MHz) 
	output au_ws; // left/right parallel to serial control 
	output au_data; // serial output au data 
	// Declare internal nodes 
	wire [15:0] au_in_left, au_in_right;
	reg  [19:0]frequency;
	reg  [2:0]checkclk,next_checkclk;
	
	always@*
		begin
			if(voice==1'd1)
				frequency = 20'd90909;
			else
				frequency = 20'd20243;		
		end
		
	// Note generation 
	buzzer_control Ung
	( 
		.clk(clk), 					// clock from crystal 
		.rst_n(rst_n), 			// active low reset 
		.note_div(frequency), 	// div for music note 
		.au_left(au_in_left), 	// left audio 
		.au_right(au_in_right) 	// right audio 
	); 
	
	// Speaker controllor 
	speaker_control Usc
	( 
		.clk(clk), 						// clock from the crystal 
		.rst_n(rst_n), 				// active low reset 
		.audio_left(au_in_left), 	// left channel au data 
		.audio_right(au_in_right), // right channel au data 
		.audio_appsel(au_appsel), 		// mode selection 
		.audio_sysclk(au_sysclk), 		// control clock for DAC (from crystal) 
		.audio_bck(au_bck), 				// bit clock of au data (5MHz) 
		.audio_ws(au_ws), 				// left/right parallel to serial control 
		.audio_data(au_data) 			// serial output au data 
	); 
endmodule 
	

	
	
