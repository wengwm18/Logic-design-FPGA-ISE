`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:41 06/07/2016 
// Design Name: 
// Module Name:    lcd_RAM_2 
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
module lcd_RAM_2 (
  input              clk,
  input              rst_n,
  output             LCD_rst,
  output wire [1:0]  LCD_cs,
  output             LCD_rw,
  output             LCD_di,
  output wire [7:0]  LCD_data,
  output             LCD_en
);

  wire change,en,out_valid;
  wire [7:0] data_out;
  wire clk_div;
  wire [3:0]clk_4bit;
  wire clk1hz,clk_debounce;
  wire [1:0]clk_ftsd_scan;
  wire clk_decide;
  wire [3:0]autokey;

  


  freq_div2_2 R0(.clk_decide(clk_decide),.clk_4bit(clk_4bit),.clk1hz(clk1hz),.clk_debounce(clk_debounce), .clk_ftsd_scan(clk_ftsd_scan), .clk(clk), .rst_n(rst_n));
  
  autokey R1( .clk(clk_debounce),.rst_n(rst_n),.autokey(autokey) );
	
  RAM_ctrl_2 R2 (
    .clk(clk_div),
    .rst_n(rst_n),
    .change(1'b1),
    .en(en),
    .data_out(data_out),
    .data_valid(out_valid),
	 .key(autokey)
	 );

  lcd_ctrl_3 d1 (
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
    .en_tran(en)
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

