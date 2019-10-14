`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:32:22 06/18/2016 
// Design Name: 
// Module Name:    scan_ctl 
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
module scan_ctl
(
	output reg [3:0]ftsd_ctl,          //控制led燈的output
	output reg [3:0]ftsd_in,             //控制14段顯示器的output
	input [3:0] in0,  
	input [3:0] in1,  
	input [3:0] in2,                   //10位數的值
	input [3:0] in3,                   //個位數的值
	input [1:0] ftsd_ctl_en,
	input clk,
	input rst_n
);

always @* 
	begin 
		case(ftsd_ctl_en)                   //因為clk_ctl有兩個bit所以有4種可能
			2'b00: 						    //00的case是讓第一個led顯示為0
				begin
					ftsd_in=in0;
					ftsd_ctl=4'b0111;
				end	
			2'b01:                          //01的case是讓第二個led顯示為0
				begin
					ftsd_in=in1;
					ftsd_ctl=4'b1011;
				end
			2'b10:            	            //10的case是讓第三個led顯示為十位數之值
				begin
					ftsd_in=in2;
					ftsd_ctl=4'b1101;
				end
			2'b11:                          //11的case是讓第四個led顯示為個位數之值
				begin
					ftsd_in=in3;
					ftsd_ctl=4'b1110;
				end	
			default:	                    //default理論上其他情形，這次剛好沒有
				begin
					ftsd_in=in1;
					ftsd_ctl=4'b1111;
				end	
		endcase
	end                         

endmodule


