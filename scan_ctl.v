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
	output reg [3:0]ftsd_ctl,          //����led�O��output
	output reg [3:0]ftsd_in,             //����14�q��ܾ���output
	input [3:0] in0,  
	input [3:0] in1,  
	input [3:0] in2,                   //10��ƪ���
	input [3:0] in3,                   //�Ӧ�ƪ���
	input [1:0] ftsd_ctl_en,
	input clk,
	input rst_n
);

always @* 
	begin 
		case(ftsd_ctl_en)                   //�]��clk_ctl�����bit�ҥH��4�إi��
			2'b00: 						    //00��case�O���Ĥ@��led��ܬ�0
				begin
					ftsd_in=in0;
					ftsd_ctl=4'b0111;
				end	
			2'b01:                          //01��case�O���ĤG��led��ܬ�0
				begin
					ftsd_in=in1;
					ftsd_ctl=4'b1011;
				end
			2'b10:            	            //10��case�O���ĤT��led��ܬ��Q��Ƥ���
				begin
					ftsd_in=in2;
					ftsd_ctl=4'b1101;
				end
			2'b11:                          //11��case�O���ĥ|��led��ܬ��Ӧ�Ƥ���
				begin
					ftsd_in=in3;
					ftsd_ctl=4'b1110;
				end	
			default:	                    //default�z�פW��L���ΡA�o����n�S��
				begin
					ftsd_in=in1;
					ftsd_ctl=4'b1111;
				end	
		endcase
	end                         

endmodule


