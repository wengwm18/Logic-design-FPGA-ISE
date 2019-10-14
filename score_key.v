`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:57:43 06/18/2016 
// Design Name: 
// Module Name:    score_key 
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
module score_key( cnt, key ,key_random, key_new, finish
    );
input finish;
input [25:0]cnt;
input [3:0]key;
input [3:0]key_random;
output reg[1:0]key_new;

always@*
	begin
	if(cnt==26'd3900000 && key==key_random && finish==0)
		key_new=2'd1;
	else if (cnt==26'd2000000 && key!=key_random && finish==0)
		key_new=2'd0;
	else 
		key_new=2'd3;
	end

endmodule
