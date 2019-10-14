`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:00 06/06/2016 
// Design Name: 
// Module Name:    serializer_16 
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
module serializer_16(out, data, clk, rst_n   
	);
output reg out;
input [15:0]data;
input clk;
input rst_n;
reg [3:0]clk_cnt, clk_cnt_next;
reg out_next;


//和prelab一樣的功能，只是換成16bit的input
always@*
	begin
	case(clk_cnt)
	
	4'd0:
	begin
	out_next=data[15];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd1:
	begin
	out_next=data[14];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd2:
	begin
	out_next=data[13];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd3:
	begin
	out_next=data[12];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd4:
	begin
	out_next=data[11];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd5:
	begin
	out_next=data[10];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd6:
	begin
	out_next=data[9];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd7:
	begin
	out_next=data[8];
	clk_cnt_next=clk_cnt+1'd1;
	end

	4'd8:
	begin
	out_next=data[7];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd9:
	begin
	out_next=data[6];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd10:
	begin
	out_next=data[5];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd11:
	begin
	out_next=data[4];
	clk_cnt_next=clk_cnt+1'd1;
	end

	4'd12:
	begin
	out_next=data[3];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd13:
	begin
	out_next=data[2];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd14:
	begin
	out_next=data[1];
	clk_cnt_next=clk_cnt+1'd1;
	end
	
	4'd15:
	begin
	out_next=data[0];
	clk_cnt_next=clk_cnt+1'd1;
	end
	endcase
end




always @(posedge clk or negedge rst_n)
	if (~rst_n)
	begin
	clk_cnt <= 2'd0;
	out <= 1'b0;
	end
 
	else
	begin
	clk_cnt <= clk_cnt_next;
	out <= out_next;
	end

endmodule