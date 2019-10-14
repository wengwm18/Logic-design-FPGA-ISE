`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:32:55 06/18/2016 
// Design Name: 
// Module Name:    ftsd 
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
module ftsd
(
	output reg[14:0]segment,
	input  [3:0]ftsd_in
);

always @* 
	begin  
		case(ftsd_in)
			4'd0:    segment = 15'b00000011_111111_1;//前八個代表數字，其他的代表斜線和點
			4'd1:    segment = 15'b10011111_111111_1;
			4'd2:    segment = 15'b00100100_111111_1;
			4'd3:    segment = 15'b00001100_111111_1;
			4'd4:    segment = 15'b10011000_111111_1;
			4'd5:    segment = 15'b01001000_111111_1;
			4'd6:    segment = 15'b01000000_111111_1;
			4'd7:    segment = 15'b00011111_111111_1;
			4'd8:    segment = 15'b00000000_111111_1;
			4'd9:	   segment = 15'b00001000_111111_1;
			4'd10:   segment = 15'b00010000_111111_1;//A
			4'd11:   segment = 15'b00001110_101101_1;//B
			4'd12:   segment = 15'b01100011_111111_1;//C
			4'd13:   segment=  15'b00001111_101101_1;//D
			4'd14:   segment=  15'b01100000_111111_1;//E
			4'd15:   segment = 15'b01110000_111111_1;//F
			default: segment = 15'b11111111_111111_1;
		endcase
	end       

endmodule
