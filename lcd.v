`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:31 06/04/2016 
// Design Name: 
// Module Name:    lcd 
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
module lcd_RAM_1 (
  input              clk,
  input              rst_n,
  output             LCD_rst,
  output wire [1:0]  LCD_cs,
  output             LCD_rw,
  output             LCD_di,
  output wire [7:0]  LCD_data,
  output             LCD_en,
  input             [3:0]col_n,
  output            [3:0]row_n,
  output            [3:0]key_random,
  output            [3:0]key,
  output             pressed,
  output            [25:0]cnt,
  input             finish,  
  output            finish_ram,
  input             start_ram,
  input              dip1,
  input              dip2,
  output            clk_debounce
);

  wire change,en,out_valid;
  wire [7:0] data_out;
  wire clk_div;
  wire [3:0]clk_4bit;
  wire clk1hz;
  wire [1:0]clk_ftsd_scan;
  wire clk_slow,clk_out,clk_out2,clk_out3,clk_out4;
  wire [1:0]ftsd_clk;
  wire en_random;
	

  freq_div1_random R0_0
  (
   .cnt(cnt),  
	.clk_slow(clk_slow),
	.clk_out(clk_out),					
	.clk_out2(clk_out2),				
	.clk_out3(clk_out3),				
	.clk_out4(clk_out4),				
	.ftsd_clk(ftsd_clk),
	.clk(clk),						
	.rst_n( pressed )						
   );	
	
  freq_div2 R0(.clk_4bit(clk_4bit),.clk1hz(clk1hz),.clk_debounce(clk_debounce), .clk_ftsd_scan(clk_ftsd_scan), .clk(clk), .rst_n(1'b1));
  
  keypad_scan R00(.key(key), .pressed(pressed), .row_n(row_n), .col_n(col_n), .clk(clk), .rst_n(rst_n));	
  
  random R1( .key_random(key_random),.clk_4bit(clk_4bit),.rst_n(rst_n),.clk(clk),.en(key==key_random),.cnt(cnt),.en_random(en_random),.clk2hz(clk_out4));//這行條件太重要了

  random_counter R01(.dip1(dip1),.dip2(dip2),.en(en_random),.clk(clk),.rst_n(~pressed));

  RAM_ctrl R2 (
    .clk(clk_div),
    .rst_n(rst_n),
    .change(1'b1),
    .en(en),
    .data_out(data_out),
    .data_valid(out_valid),
	 .key(key_random),
	 .finish(finish)
	 );

  lcd_ctrl d1 (
    .clk(clk_div),
    .rst_n(rst_n),
    .data(data_out),           // memory value  
    .data_valid(out_valid),    // if data_valid = 1 the data is valid
    .LCD_di(LCD_di),
    .LCD_rw(LCD_rw),
    .LCD_en(LCD_en),
    .LCD_rst(LCD_rst),
    .LCD_cs(LCD_cs),
    .LCD_data(LCD_data),
    .en_tran(en),
	 .finish_ram(finish_ram),
	 .start_ram(start_ram)
	 
  );

  clock_divider #(
    .half_cycle(200),         // half cycle = 200 (divided by 400)
    .counter_width(8)         // counter width = 8 bits
  ) clk100K (
    .rst_n(rst_n),
    .clk(clk),
    .clk_div(clk_div)
  );

endmodule
