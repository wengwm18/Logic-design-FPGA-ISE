`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:48 06/06/2016 
// Design Name: 
// Module Name:    random 
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
module random( key_random,clk_4bit,rst_n,clk,en,cnt,en_random,clk2hz
    );
input en_random; 
input clk,clk2hz;	 
input rst_n,en;
input [3:0]clk_4bit;
output reg[3:0]key_random;
reg [3:0]key_random_tmp; 
input [25:0]cnt;
reg [3:0]clk_4bit_new;

always@*
		begin
		if(clk2hz==1'd1)
      clk_4bit_new={clk_4bit[0],clk_4bit[2],clk_4bit[1],clk_4bit[3]};
		
		else 
		clk_4bit_new={clk_4bit[2],clk_4bit[1],clk_4bit[3],clk_4bit[0]};
		
		end

always@*
		begin
			if(cnt>4000000 && en==1)
			key_random_tmp = clk_4bit_new;
			
			else if(en_random==1)
			key_random_tmp = clk_4bit_new;
					
			else
			key_random_tmp=key_random;
			
		
		end
		

		
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		begin
		key_random<=4'd0;
		
		end
		
	else
		begin
		key_random<=key_random_tmp;
	
		end
		
		
		


endmodule
