`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:07 06/06/2016 
// Design Name: 
// Module Name:    note_sel_1 
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
module note_sel_1(note_div,voice
    );
input [3:0]voice;

output reg[19:0]note_div;	 
	 
always@*
	begin
		if(voice==4'hA)
		begin
		note_div=20'd38168;//4000w / (524*2)
		end

	
		else if(voice==4'd6)
		begin
		note_div=20'd76628;//4000w / (261*2)
		end
	
		else 
		begin
		note_div=20'd0;//§£µo¡n
		end
end
	
	
	
endmodule
