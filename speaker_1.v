`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:40 06/06/2016 
// Design Name: 
// Module Name:    speaker_1 
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
module speaker_1(au_appsel, au_sysclk, au_bck, au_ws, au_data, clk, rst_n, voice);
	input [3:0]voice;
	input clk; // clock from the crystal
	input rst_n; // active low reset
	output au_appsel; // playing mode selection
	output au_sysclk; // control clock for DAC (from crystal)
	output au_bck; // bit clock of au data (5MHz)
	output au_ws; // left/right parallel to serial control
	output au_data; // serial output au data
	// Declare internal nodes
	wire [15:0] au_in_left, au_in_right;
	wire [19:0]note_div;


 note_sel_1 U0(
 .note_div(note_div),
 .voice(voice)
    );
// Note generation
 buzzer_control U1(
 .clk(clk), // clock from crystal
 .rst_n(rst_n), // active low reset
 .note_div(note_div), // div for music note
 .au_left(au_in_left), // left audio
 .au_right(au_in_right)  // right audio
 );
 // Speaker controllor
 speaker_control U2(
 .clk(clk), // clock from the crystal
 .rst_n(rst_n), // active low reset
 .audio_left(au_in_left), // left channel au data
 .audio_right(au_in_right), // right channel au data
 .au_appsel(au_appsel), // mode selection
 .au_sysclk(au_sysclk), // control clock for DAC (from crystal)
 .au_bck(au_bck), // bit clock of au data (5MHz)
 .au_ws(au_ws), // left/right parallel to serial control
 .au_data(au_data)
 ); // serial
 
 endmodule