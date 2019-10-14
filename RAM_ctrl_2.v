`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:24 06/07/2016 
// Design Name: 
// Module Name:    RAM_ctrl_2 
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
module RAM_ctrl_2 (
  input clk,
  input rst_n,
  input change,
  input en,
  output reg [7:0] data_out,
  output reg data_valid,
  input  [3:0]key
);

  parameter mark0  = 256'b0000000000000000000011110001000000001000100100000000100010010000000011110001000000001000000100000000100000001111000000000000000000000000000000000000000000111100000000000100001000000000010000000000000000110000000000000000110000000000000000100000000001000010;
  parameter mark1 =  256'b0000000000000000100011100010000110010000001000011001100000100001100001100011111110010001001000010000111000100001000000000000000000000000000000000011111110011111000001000010000000000100001000000000010000100000000001000011111100000100001000000000010000100000; 
  parameter mark2 =  256'b0000000000000000000000011111111000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000000000000000000000000001000011111100111010001000010000001000100001000000100010000100000110001111100000001000100100000000100010001100000;
  parameter mark3 =  256'b0000000000000000011111000000000010000010000000001000001000000000100000100000000010000010000000000111110000000000000000000000000000000000000000001111100000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000;
  parameter mark4 =  256'b0000000000111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000010000000000000010000000000000010000000000000010000;
  parameter mark5 =  256'b0000010000100000000000000000000000000000000000000000000000000000000000000011111100000000110000000000001100000000000011000000000000110000000000000100000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000;
  parameter mark6 =  256'b0100010000100000000000000000000000000000000000000000000000000000111111100000000000000001100000000000000001100000000000000001100000000000000001100000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000;	
  parameter mark7 =  256'b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000011000000000000000010000000000000000100000000000000001000000000000000010000000000000000100000000;
  parameter mark8 =  256'b0000000000010000000000000010000000000000001000000000000001000000000000000100000000000000100000000000000010000000000000001011111100000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000;	
  parameter mark9 =  256'b0001100000000000001010000000000000111000000000000011100000000000001110000000000000011000000000000000000000000000000000000000000000000000000000000000100000000111000001000000100000000010000100000000000111100000000000000000000000000000000000000000000000000000;
  parameter mark10 = 256'b0000000000011000000000000010100000000000001110000000000000111000000000000011100000000000000100000000000000000000000000000000000100000000000000001000000011000000010000010000000000100010000000000001110000000000000000000000000000000000000000000000000000000000;
  parameter mark11 = 256'b0000000100000000000000001000000000000000010000000000000000100000000000000010000000000000001000000000000000100000111110000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000;
  parameter mark12 = 256'b0000000010000000000000001000000000000000100001000000000010000010000000001000000100000000100000010000000010000000000000001000000000000000100000000000000010000000000000010101001000000011001011010000010000000000001111000100110100000011101100100000001000000000;
  parameter mark13 = 256'b0000000000000000000010000000000000000100000000000000001000000000000000010000000000000001000000001000000100000000011000100000000000011100000000000000000100100000011011101101001110010000000011100000010000000000111010110100011000011000101111010000000000000000;
  parameter mark14 = 256'b0000000000000000000000000000010000000000000010000000000000010000000000000010000000000000010000000000000001000001000000000100001000000000001111000000000000000000000001000010001011001010110111010011000100000000010010101000100010110110011101110000000000000000;
  parameter mark15 = 256'b0000000000100000000000000010000000000000001000000010000000100000010000000010000010000000001000000000000000100000000000000010000000000000001000000000000000100000100110000110000010100101101000001000001000010000010000100010111110110100110111000000100000000000;
  parameter WRITE = 2'd1;
  parameter GETDATA = 2'd2;
  parameter TRANSDATA = 2'd3;
  parameter IDLE  = 2'd0;
  reg [5:0] addr, addr_next;
  reg [5:0] counter_word, counter_word_next;
  wire [63:0] data_out_64;
  reg [63:0] data_in;
  reg [15:0] in_temp0, in_temp1, in_temp2, in_temp3;
  reg [1:0] cnt, cnt_next;  //count mark row
  reg [511:0] mem, mem_next;
  reg [1:0] state, state_next;
  reg flag, flag_next;
  reg [7:0] data_out_next;
  reg data_valid_next;
  reg wen, wen_next;
  reg temp_change, temp_change_next;
 
  /*assign in_temp0 = key[15-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp1 = key[14-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp2 = key[13-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];
  assign in_temp3 = key[12-(cnt*4)] == 1'b0 ? 16'd0 : mark[(240-((addr%16)*16))+:16];*/
  
  always@*
		begin	
			if(cnt==0)
			begin
			if(key==4'hF)
				begin
				in_temp0 = mark0[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'hE)
				begin
				in_temp1 = mark1[(240-((addr%16)*16))+:16];
				in_temp0 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'hD)
				begin
				in_temp2 = mark2[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp0 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'hC)
				begin
				in_temp3 = mark3[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end
				
			else
				begin
				in_temp3 = 16'd0;
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end	
				
				
			end	
				
		else if(cnt==1)
			begin
			if(key==4'hB)
				begin
				in_temp0 = mark4[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd3)
				begin
				in_temp1 = mark5[(240-((addr%16)*16))+:16];
				in_temp0 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd6)
				begin
				in_temp2 = mark6[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp0 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd9)
				begin
				in_temp3 = mark7[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end
				
			else 
				begin
				in_temp3 = 16'd0;
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end	
				
				
			end
  
		else if(cnt==2)
			begin
			if(key==4'hA)
				begin
				in_temp0 = mark8[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd2)
				begin
				in_temp1 = mark9[(240-((addr%16)*16))+:16];
				in_temp0 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd5)
				begin
				in_temp2 = mark10[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp0 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd8)
				begin
				in_temp3 = mark11[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end
				
			else 
				begin
				in_temp3 = 16'd0;
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end	
				
				
			end
		else 
			begin
			if(key==4'd0)
				begin
				in_temp0 = mark12[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd1)
				begin
				in_temp1 = mark13[(240-((addr%16)*16))+:16];
				in_temp0 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd4)
				begin
				in_temp2 = mark14[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp0 = 16'd0; 
				in_temp3 = 16'd0; 
				end
				
			else if(key==4'd7)
				begin
				in_temp3 = mark15[(240-((addr%16)*16))+:16];
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end
				
			else 
				begin
				in_temp3 = 16'd0;
				in_temp1 = 16'd0; 
				in_temp2 = 16'd0; 
				in_temp0 = 16'd0; 
				end	
				
			end
		end

	

 ///////////////////////in_temp0
	/*always@*
		begin
			if(cnt==0)
			begin
			case(h10)
			0:in_temp0 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp0 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp0 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp0 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp0 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp0 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp0 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp0 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp0 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp0 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp0 = 16'd0;
			endcase	
			end
			
			else if(cnt==1)
			begin
			case(s10)
			0:in_temp0 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp0 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp0 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp0 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp0 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp0 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp0 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp0 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp0 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp0 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp0 = 16'd0;
			endcase
			end
			
			else
			begin
			in_temp0 = 16'd0;
			end
			
		end
		
/////////////////////in_temp1
		always@*
		begin
			if(cnt==0)
			begin
			case(h1)
			0:in_temp1 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp1 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp1 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp1 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp1 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp1 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp1 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp1 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp1 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp1 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp1 = 16'd0;
			endcase	
			end
			
			else if(cnt==1)
			begin
			case(s1)
			0:in_temp1 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp1 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp1 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp1 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp1 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp1 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp1 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp1 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp1 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp1 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp1 = 16'd0;
			endcase
			end
			
			else
			begin
			in_temp1 = 16'd0;
			end
			
		end

//////////////////////in_temp2
      always@*
		begin
			if(cnt==0)
			begin
			case(m10)
			0:in_temp2 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp2 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp2 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp2 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp2 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp2 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp2 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp2 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp2 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp2 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp2 = 16'd0;
			endcase	
			end
			
			else if(cnt==1)
			begin
			case(u10)
			0:in_temp2 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp2 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp2 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp2 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp2 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp2 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp2 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp2 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp2 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp2 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp2 = 16'd0;
			endcase
			end
			
			else
			begin
			in_temp2 = 16'd0;
			end
			
		end
  
  ////////////////////////in_temp3
      always@*
		begin
			if(cnt==0)
			begin
			case(m1)
			0:in_temp3 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp3 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp3 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp3 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp3 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp3 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp3 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp3 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp3 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp3 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp3 = 16'd0;
			endcase	
			end
			
			else if(cnt==1)
			begin
			case(u1)
			0:in_temp3 = mark0[(240-((addr%16)*16))+:16];
			1:in_temp3 = mark1[(240-((addr%16)*16))+:16];
			2:in_temp3 = mark2[(240-((addr%16)*16))+:16];
			3:in_temp3 = mark3[(240-((addr%16)*16))+:16];
			4:in_temp3 = mark4[(240-((addr%16)*16))+:16];
			5:in_temp3 = mark5[(240-((addr%16)*16))+:16];
			6:in_temp3 = mark6[(240-((addr%16)*16))+:16];
			7:in_temp3 = mark7[(240-((addr%16)*16))+:16];
			8:in_temp3 = mark8[(240-((addr%16)*16))+:16];
			9:in_temp3 = mark9[(240-((addr%16)*16))+:16];
			default: in_temp3 = 16'd0;
			endcase
			end
			
			else
			begin
			in_temp3 = 16'd0;
			end
			
		end
  
  */

  RAM R1(
    .clka(clk),
    .wea(wen),
    .addra(addr),
    .dina(data_in),
    .douta(data_out_64)
  );

  always @(posedge clk or negedge rst_n) 
	begin
    if (!rst_n) 
	 begin
      addr = 6'd0;
      cnt = 2'd0;
      mem = 512'd0;
      state = IDLE;
      flag = 1'b0;
      counter_word = 6'd0;
      data_out = 8'd0;
      data_valid = 1'd0;
      wen = 1'b1;
      temp_change = 1'b0;
    end else begin
      addr = addr_next;
      cnt = cnt_next;
      mem = mem_next;
      state = state_next;
      flag = flag_next;
      counter_word = counter_word_next;
      data_out = data_out_next;
      data_valid = data_valid_next;
      wen = wen_next;
      temp_change = temp_change_next;
    end
  end

  always @(*) begin
    state_next = state;
    case(state)
      IDLE: begin
        if (wen) begin
          state_next = WRITE;
        end else begin
          state_next = GETDATA;
        end
      end
      WRITE: begin
        if (addr == 6'd63) begin
          state_next = GETDATA;
        end
      end
      GETDATA: begin
        if (flag == 1'b1) begin
          state_next = TRANSDATA;
        end
      end
      TRANSDATA: begin
        if (addr == 6'd0 && counter_word == 6'd63 && en) begin
          state_next = IDLE;
        end else if (counter_word == 6'd63 && en) begin
          state_next = GETDATA;
        end
      end
    endcase
  end
  always @(*) begin
    addr_next = addr;
    data_in = 64'd0;
    cnt_next = cnt;
    mem_next = mem;
    flag_next = 1'b0;
    counter_word_next = counter_word;
    data_valid_next = 1'd0;
    data_out_next = 8'd0;
    case(state)
      
		
		
		
		
		WRITE: begin
        addr_next = addr + 1'b1;
        data_in = {in_temp0, in_temp1, in_temp2, in_temp3};
        if (addr == 6'd15 || addr == 6'd31 || addr == 6'd47 || addr == 6'd63) begin
          cnt_next = cnt + 1'd1;
        end
      end
      
		
		
		
		
		
		GETDATA: begin
        if (!flag) begin
          addr_next = addr + 1'b1;
        end
        if ((addr%8) == 6'd7) begin
          flag_next = 1'b1;
        end
        if ((addr%8) >= 6'd1 || flag) begin
          mem_next[(((addr-1)%8)*64)+:64] = data_out_64;
        end
      end
      TRANSDATA: begin
        if (en) begin
          counter_word_next = counter_word + 1'b1;
          data_valid_next = 1'b1;
          data_out_next = {mem[511 - counter_word],
            mem[447 - counter_word],
            mem[383 - counter_word],
            mem[319 - counter_word],
            mem[255 - counter_word],
            mem[191 - counter_word],
            mem[127 - counter_word],
            mem[63 - counter_word]};
        end
      end
    endcase
  end
 
  //wen control
  always @(*) begin
    wen_next = wen;
    temp_change_next = temp_change;
    if (change) begin
      temp_change_next = 1'b1;
    end
    if (state == WRITE && addr == 6'd63) begin
      wen_next = 1'b0;
    end
    if (state == TRANSDATA && addr == 6'd0 && counter_word == 6'd63 && temp_change == 1'b1) begin
      temp_change_next = 1'b0;
      wen_next = 1'b1;
    end
  end
endmodule

