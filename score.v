`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:22 06/06/2016 
// Design Name: 
// Module Name:    score 
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
//FROM¶À¤h°a
module score
(
	output reg [3:0]value1,
	output reg [3:0]value2,
	output reg [3:0]value3,
	output reg [3:0]value4,
	input key,
	input [1:0]state

);
	
always@*
	begin
		case(state)
		1'd0:
			begin
				if(key==1'd1)
					begin
						value4 = value4 +4'd1;
						if(value4>4'd9)
							begin
								value4 = value4 - 4'd10;
								value3 = value3 +1'd1;
								if(value3>4'd9)
									begin
										value3 = value3 -4'd10;
										value2 = value2 +1'd1;
										if(value2>4'd9)
											begin
												value2 = value2 -4'd10;
												value1 = value1 +1'd1;
												if(value1>=4'd9)
													value1 = 4'd9;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
				else
					begin
						value4 = value4 -4'd1;
						if(value4<=4'd0)
							begin
								value4 = value4 + 4'd9;
								value3 = value3 - 1'd1;
								if(value3<=4'd0)
									begin
										value3 = value3 +4'd9;
										value2 = value2 -1'd1;
										if(value2<=4'd0)
											begin
												value2 = value2 +4'd9;
												value1 = value1 -1'd1;
												if(value1<=4'd0)
													value1 = 4'd0;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
			end
		1'd1:
			begin
				if(key==1'd1)
					begin
						value4 = value4 +4'd2;
						if(value4>4'd9)
							begin
								value4 = value4 - 4'd10;
								value3 = value3 +1'd1;
								if(value3>4'd9)
									begin
										value3 = value3 -4'd10;
										value2 = value2 +1'd1;
										if(value2>4'd9)
											begin
												value2 = value2 -4'd10;
												value1 = value1 +1'd1;
												if(value1>=4'd9)
													value1 = 4'd9;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
				else
					begin
						value4 = value4 -4'd3;
						if(value4<=4'd0)
							begin
								value4 = value4 + 4'd9;
								value3 = value3 - 1'd1;
								if(value3<=4'd0)
									begin
										value3 = value3 +4'd9;
										value2 = value2 -1'd1;
										if(value2<=4'd0)
											begin
												value2 = value2 +4'd9;
												value1 = value1 -1'd1;
												if(value1<=4'd0)
													value1 = 4'd0;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
			end
		1'd2:
			begin
				if(key==1'd1)
					begin
						value4 = value4 +4'd3;
						if(value4>4'd9)
							begin
								value4 = value4 - 4'd10;
								value3 = value3 +1'd1;
								if(value3>4'd9)
									begin
										value3 = value3 -4'd10;
										value2 = value2 +1'd1;
										if(value2>4'd9)
											begin
												value2 = value2 -4'd10;
												value1 = value1 +1'd1;
												if(value1>=4'd9)
													value1 = 4'd9;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
				else
					begin
						value4 = value4 -4'd5;
						if(value4<=4'd0)
							begin
								value4 = value4 + 4'd9;
								value3 = value3 - 1'd1;
								if(value3<=4'd0)
									begin
										value3 = value3 +4'd9;
										value2 = value2 -1'd1;
										if(value2<=4'd0)
											begin
												value2 = value2 +4'd9;
												value1 = value1 -1'd1;
												if(value1<=4'd0)
													value1 = 4'd0;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
			end
		1'd3:
			begin
				if(key==1'd1)
					begin
						value4 = value4 +4'd4;
						if(value4>4'd9)
							begin
								value4 = value4 - 4'd10;
								value3 = value3 +1'd1;
								if(value3>4'd9)
									begin
										value3 = value3 -4'd10;
										value2 = value2 +1'd1;
										if(value2>4'd9)
											begin
												value2 = value2 -4'd10;
												value1 = value1 +1'd1;
												if(value1>=4'd9)
													value1 = 4'd9;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
				else
					begin
						value4 = value4 -4'd8;
						if(value4<=4'd0)
							begin
								value4 = value4 + 4'd9;
								value3 = value3 - 1'd1;
								if(value3<=4'd0)
									begin
										value3 = value3 +4'd9;
										value2 = value2 -1'd1;
										if(value2<=4'd0)
											begin
												value2 = value2 +4'd9;
												value1 = value1 -1'd1;
												if(value1<=4'd0)
													value1 = 4'd0;
												else
													value1 = value1;
											end
										else
											value2 = value2;
									end
								else
									value3 = value3
							end
						else
							value4 = value4
					end
			end
		default:
			begin
				value1 = value1;
				value2 = value2;
				value3 = value3;
				value4 = value4;
			end
		endcase	
	end

endmodule
