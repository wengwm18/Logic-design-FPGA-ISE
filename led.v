`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:15 06/06/2016 
// Design Name: 
// Module Name:    led 
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
module led
(  finish,
	clk,
	rst_n,
	led
);

reg [26:0]cnt ,cnt_tmp;
reg [3:0]state,next_state;
output reg [15:0]led;
input rst_n;
input clk;
output reg finish;
reg finish_tmp;

always@*
	if(cnt==27'd80000000)
		begin
			if(state!=15)
			begin
			cnt_tmp = 27'd0;
			next_state = state + 4'd1;
			finish_tmp = 0;
			end
			
			else
			begin
			cnt_tmp = 27'd0;
			next_state = state;
			finish_tmp = 1;
			end
		end
	else
		begin
			cnt_tmp = cnt + 27'd1;
			next_state = state;
			finish_tmp = finish;
		end
		
always@*		
	begin
		case(state)
			4'd0:begin led = 16'b0000000000000001;   end
			4'd1:begin led = 16'b0000000000000011;   end
			4'd2:begin led = 16'b0000000000000111;   end
			4'd3:begin led = 16'b0000000000001111;   end
			4'd4:begin led = 16'b0000000000011111;   end
			4'd5:begin led = 16'b0000000000111111;   end
			4'd6:begin led = 16'b0000000001111111;   end
			4'd7:begin led = 16'b0000000011111111;   end
			4'd8:begin led = 16'b0000000111111111;   end
			4'd9:begin led = 16'b0000001111111111;   end
			4'd10:begin led = 16'b0000011111111111;  end
			4'd11:begin led = 16'b0000111111111111;  end
			4'd12:begin led = 16'b0001111111111111;  end
			4'd13:begin led = 16'b0011111111111111;  end
			4'd14:begin led = 16'b0111111111111111;  end
			4'd15:begin led = 16'b1111111111111111;  end
			default: begin led = 16'b0000000000000000;  end
		endcase
	end
	
	
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		begin
			state = 4'd0;
			cnt = 27'd0;
			finish = 0;
		end
	else	
		begin
			state = next_state;
			cnt = cnt_tmp;
			finish = finish_tmp;
		end
	
	
endmodule
