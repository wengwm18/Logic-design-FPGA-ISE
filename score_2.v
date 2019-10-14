`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:31:12 06/18/2016 
// Design Name: 
// Module Name:    score_2 
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
module score_2
(
	output reg [3:0]value1,
	output reg [3:0]value2,
	output reg [3:0]value3,
	output reg [3:0]value4,
	input [1:0]key,//1:T  0:F  2,3:no
	input state,
	input clk,
	input rst_n
	//input pb1,pb2,pb3
);
	reg[3:0]value1_tmp,value2_tmp,value3_tmp,value4_tmp;
	
always@*
	//begin
	   //if(pb1==1 && pb2==0 && pb3==0)
      begin		
		case(state)
		1'd1:
			begin
				if(key==2'd1)															//加分
					begin
						if(value4==4'd9)
							begin
								if(value3==4'd9)
									begin
										if(value2==4'd9)
											begin
												if(value1==4'd9)
													begin
														value1_tmp = 4'd9;   		//滿分9999
														value2_tmp = 4'd9;
														value3_tmp = 4'd9;
														value4_tmp = 4'd9;
													end
												else
													begin
														value1_tmp = value1+4'd1;  //ex1999->2000
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd0;
													end
											end
										else
											begin
												value1_tmp = value1;					//ex1899->1900
												value2_tmp = value2+4'd1;
												value3_tmp = 4'd0;
												value4_tmp = 4'd0;
											end
									end
								else														//ex1789->1790
									begin
										value1_tmp = value1;
										value2_tmp = value2;
										value3_tmp = value3+4'd1;
										value4_tmp = 4'd0;
									end
							end
						else																//ex1896->1897
							begin
								value1_tmp = value1;
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4+4'd1;
							end
					end
				else if(key==2'd0)													//扣分
					begin
						if(value4==4'd0)
							begin
								if(value3==4'd0)
									begin
										if(value2==4'd0)
											begin
												if(value1==4'd0)
													begin
														value1_tmp = 4'd0;			//0分
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd0;
													end
												else
													begin
														value1_tmp = value1-4'd1;	//ex1000->999
														value2_tmp = value2+4'd9;
														value3_tmp = value3+4'd9;
														value4_tmp = value4+4'd9;
													end
											end
										else	
											begin
												value1_tmp = value1;					//ex2800->2799
												value2_tmp = value2-4'd1;
												value3_tmp = value3+4'd9;
												value4_tmp = value4+4'd9;
											end
									end
								else
									begin											
										value1_tmp = value1;							//ex3560->3559
										value2_tmp = value2;
										value3_tmp = value3-4'd1;
										value4_tmp = value4+4'd9;
									end
							end
						else
							begin
								value1_tmp = value1;									//ex3333->3332
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4-4'd1;
							end
					end
				else																		//沒有對or錯
					begin
						value1_tmp = value1;
						value2_tmp = value2;
						value3_tmp = value3;
						value4_tmp = value4;
					end
			end
		default:																			//default
			begin
				value1_tmp = value1;
				value2_tmp = value2;
				value3_tmp = value3;
				value4_tmp = value4;
			end
		endcase	
		end
		
/////////////////////////////////////////////		
		
		/*else if(pb2==1 && pb1==0 && pb3==0)
      begin		
		case(state)
		1'd1:
			begin
				if(key==2'd1)															//加分
					begin
						if(value4==4'd9)
							begin
								if(value3==4'd9)
									begin
										if(value2==4'd9)
											begin
												if(value1==4'd9)
													begin
														value1_tmp = 4'd9;   		//滿分9999
														value2_tmp = 4'd9;
														value3_tmp = 4'd9;
														value4_tmp = 4'd9;
													end
												else
													begin
														value1_tmp = value1+4'd1;  //ex1999->2001
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd1;
													end
											end
										else
											begin
												value1_tmp = value1;					//ex1899->1901
												value2_tmp = value2+4'd1;
												value3_tmp = 4'd0;
												value4_tmp = 4'd1;
											end
									end
								else														//ex1789->1791
									begin
										value1_tmp = value1;
										value2_tmp = value2;
										value3_tmp = value3+4'd1;
										value4_tmp = 4'd1;
									end
							end
						else																//ex1896->1898
							begin
								value1_tmp = value1;
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4+4'd2;
							end
					end
				else if(key==2'd0)													//扣分
					begin
						if(value4==4'd0)
							begin
								if(value3==4'd0)
									begin
										if(value2==4'd0)
											begin
												if(value1==4'd0)
													begin
														value1_tmp = 4'd0;			//0分
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd0;
													end
												else
													begin
														value1_tmp = value1-4'd1;	//ex1000->998
														value2_tmp = value2+4'd9;
														value3_tmp = value3+4'd9;
														value4_tmp = value4+4'd8;
													end
											end
										else	
											begin
												value1_tmp = value1;					//ex2800->2798
												value2_tmp = value2-4'd1;
												value3_tmp = value3+4'd9;
												value4_tmp = value4+4'd8;
											end
									end
								else
									begin											
										value1_tmp = value1;							//ex3560->3558
										value2_tmp = value2;
										value3_tmp = value3-4'd1;
										value4_tmp = value4+4'd8;
									end
							end
						else
							begin
								value1_tmp = value1;									//ex3333->3331
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4-4'd2;
							end
					end
				else																		//沒有對or錯
					begin
						value1_tmp = value1;
						value2_tmp = value2;
						value3_tmp = value3;
						value4_tmp = value4;
					end
			end
		default:																			//default
			begin
				value1_tmp = value1;
				value2_tmp = value2;
				value3_tmp = value3;
				value4_tmp = value4;
			end
		endcase	
		end
	//////////////////////////////////////////////////////	
		
		else
      begin		
		case(state)
		1'd1:
			begin
				if(key==2'd1)															//加分
					begin
						if(value4==4'd9)
							begin
								if(value3==4'd9)
									begin
										if(value2==4'd9)
											begin
												if(value1==4'd9)
													begin
														value1_tmp = 4'd9;   		//滿分9999
														value2_tmp = 4'd9;
														value3_tmp = 4'd9;
														value4_tmp = 4'd9;
													end
												else
													begin
														value1_tmp = value1+4'd1;  //ex1999->2002
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd2;
													end
											end
										else
											begin
												value1_tmp = value1;					//ex1899->1902
												value2_tmp = value2+4'd1;
												value3_tmp = 4'd0;
												value4_tmp = 4'd2;
											end
									end
								else														//ex1789->1792
									begin
										value1_tmp = value1;
										value2_tmp = value2;
										value3_tmp = value3+4'd1;
										value4_tmp = 4'd2;
									end
							end
						else																//ex1896->1899
							begin
								value1_tmp = value1;
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4+4'd3;
							end
					end
				else if(key==2'd0)													//扣分
					begin
						if(value4==4'd0)
							begin
								if(value3==4'd0)
									begin
										if(value2==4'd0)
											begin
												if(value1==4'd0)
													begin
														value1_tmp = 4'd0;			//0分
														value2_tmp = 4'd0;
														value3_tmp = 4'd0;
														value4_tmp = 4'd0;
													end
												else
													begin
														value1_tmp = value1-4'd1;	//ex1000->997
														value2_tmp = value2+4'd9;
														value3_tmp = value3+4'd9;
														value4_tmp = value4+4'd7;
													end
											end
										else	
											begin
												value1_tmp = value1;					//ex2800->2797
												value2_tmp = value2-4'd1;
												value3_tmp = value3+4'd9;
												value4_tmp = value4+4'd7;
											end
									end
								else
									begin											
										value1_tmp = value1;							//ex3560->3557
										value2_tmp = value2;
										value3_tmp = value3-4'd1;
										value4_tmp = value4+4'd7;
									end
							end
						else
							begin
								value1_tmp = value1;									//ex3333->3330
								value2_tmp = value2;
								value3_tmp = value3;
								value4_tmp = value4-4'd3;
							end
					end
				else																		//沒有對or錯
					begin
						value1_tmp = value1;
						value2_tmp = value2;
						value3_tmp = value3;
						value4_tmp = value4;
					end
			end
		default:																			//default
			begin
				value1_tmp = value1;
				value2_tmp = value2;
				value3_tmp = value3;
				value4_tmp = value4;
			end
		endcase	
		end
		
		
	end*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
always@(posedge clk or negedge rst_n)											//D Filp Flop
	if(~rst_n)
		begin
			value1 = 4'd0;
			value2 = 4'd0;
			value3 = 4'd0;
			value4 = 4'd0;
		end
	else
		begin
			value1 = value1_tmp;
			value2 = value2_tmp;
			value3 = value3_tmp;
			value4 = value4_tmp;
		end
endmodule