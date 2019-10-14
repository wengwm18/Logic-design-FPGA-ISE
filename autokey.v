`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:56 06/07/2016 
// Design Name: 
// Module Name:    autokey 
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
`define STAT_0 4'd0
`define STAT_1 4'd1
`define STAT_2 4'd2
`define STAT_3 4'd3
`define STAT_4 4'd4
`define STAT_5 4'd5
`define STAT_6 4'd6
`define STAT_7 4'd7
`define STAT_8 4'd8
`define STAT_9 4'd9
`define STAT_10 4'd10
`define STAT_11 4'd11
`define STAT_12 4'd12
`define STAT_13 4'd13
`define STAT_14 4'd14
`define STAT_15 4'd15

module autokey( clk,rst_n,autokey
    );
	 
input clk;
input rst_n;
output reg[3:0]autokey;
reg [3:0]autokey_tmp;
reg [3:0]state,state_tmp;


always@*
	case(state)
	
		`STAT_0:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hF;
			end

		
		`STAT_1:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hE;
			end	
			
		`STAT_2:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hD;
			end	
			
		`STAT_3:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hC;
			end	
			
		`STAT_4:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hB;
			end	
			
		`STAT_5:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd3;
			end	
			
		`STAT_6:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd6;
			end
			
		`STAT_7:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd9;
			end
			
		`STAT_8:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'hA;
			end
		
		`STAT_9:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd2;
			end

		`STAT_10:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd5;
			end

		`STAT_11:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd8;
			end

		`STAT_12:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd0;
			end
			
		`STAT_13:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd1;
			end
			
		`STAT_14:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd4;
			end
			
		`STAT_15:
			begin
			state_tmp = state + 4'd1;
			autokey_tmp=4'd7;
			end

		default:
			begin
			state_tmp = 4'd0;
			autokey_tmp=4'hF;
			end
			
	endcase


	always @(  posedge clk or negedge rst_n)
		begin
			if (~rst_n)
			begin
			state<=4'd0;
			autokey<=4'hF;
			end

			else
			begin
			state<=state_tmp;
			autokey<=autokey_tmp;
			end
		
		end




endmodule
