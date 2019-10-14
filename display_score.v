`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:53 06/06/2016 
// Design Name: 
// Module Name:    display_score 
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
module display_score( clk,rst_n,ftsd,ftsd_ctl
    );

freq_div1 I0(
	.clk_out(clk_out),					// 2s
	.clk_out2(clk_out2),				// 1s
	.clk_out3(clk_out3),				// 0.5s
	.clk_out4(clk_out4),				// 0.25s
	.ftsd_clk(ftsd_clk),
	.clk(clk),						// global clock input
	.rst_n(rst_n)						// active low reset
   );
	

	


endmodule
