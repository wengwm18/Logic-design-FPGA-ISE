`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:02:37 06/06/2016 
// Design Name: 
// Module Name:    change_key 
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
module change_voice(voice, key, key_random, pressed, cnt
    );
input pressed;
input [3:0]key_random,key;
output reg[3:0]voice;
input [25:0]cnt;

always@*
	begin
		if(pressed==1 && cnt<4000000)
			begin
			if(key==key_random)
				voice=4'hA;
			else
				voice=4'd6;
			end
			
		else
			voice=4'hF;
	end

endmodule
