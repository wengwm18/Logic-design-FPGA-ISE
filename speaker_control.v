`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:47 06/06/2016 
// Design Name: 
// Module Name:    speaker_control 
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
module speaker_control(clk, rst_n, audio_left, audio_right, au_appsel, au_sysclk, au_bck, au_ws, au_data);

input clk;
input rst_n;
input [15:0]audio_left;
input [15:0]audio_right;
output au_appsel;
output au_sysclk, au_bck, au_ws;
output au_data;
wire clk_32,clk_8,au_data_1,au_data_2;//clk_32 is clk freq/32//clk_8 is clk freq/8

assign au_sysclk=clk;
assign au_appsel=1;
freq_div_2 F0( .clk_32(clk_32),.clk_8(au_bck),.clk(clk), .rst_n(rst_n));
freq_div_2 F1( .clk_32(au_ws),.clk_8(clk_8),.clk(au_bck), .rst_n(rst_n));
serializer_16 F2(.out(au_data_1), .data(audio_left), .clk(au_bck), .rst_n(au_ws));//ws 1/2週期內有16bit的au_left
serializer_16 F3(.out(au_data_2), .data(audio_right), .clk(au_bck), .rst_n(~au_ws));//ws 1/2週期內有16bit的au_right

assign au_data=au_data_1+au_data_2;

endmodule
