`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:17:40 06/06/2016 
// Design Name: 
// Module Name:    sound 
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
module sound(clk,rst_n,key,key_random,au_appsel,au_sysclk,au_bck, au_ws, au_data, pressed, cnt, finish
    );
input finish; 
input clk,rst_n,pressed;
input [3:0]key,key_random;
output au_appsel; // playing mode selection
output au_sysclk; // control clock for DAC (from crystal)
output au_bck; // bit clock of au data (5MHz)
output au_ws; // left/right parallel to serial control
output au_data; // serial output au data
wire [3:0]voice;
input [25:0]cnt;

change_voice U0(.voice(voice), .key(key), .key_random(key_random), .pressed(pressed && (~finish)),.cnt(cnt));
speaker_1 U2(.au_appsel(au_appsel), .au_sysclk(au_sysclk), .au_bck(au_bck), .au_ws(au_ws), .au_data(au_data), .clk(clk), .rst_n(rst_n), .voice(voice));



endmodule
