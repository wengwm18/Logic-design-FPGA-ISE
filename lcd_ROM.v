`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:39 06/07/2016 
// Design Name: 
// Module Name:    lcd_ROM 
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
module lcd_ROM(
  clk, // system clock
  rst_n, // active low reset
  data_request,
  data_ack,
  lcd_rst, // LCD reset
  lcd_cs, // LCD frame selection
  lcd_rw, // LCD read/write control
  lcd_di, // LCD data/instruction
  lcd_d, // LCD data
  lcd_e, // LCD enable
  start_rom,
  finish_rom
);
input start_rom;
output finish_rom;
input clk; // system clock
input rst_n; // active low reset
output lcd_rst; // LCD reset
output [1:0] lcd_cs; // LCD frame selection
output lcd_rw; // LCD read/write control
output lcd_di; // LCD data/instruction
output [7:0] lcd_d; // LCD data
output lcd_e; // LCD enable

wire clk_50k; // Divided 50k clock
//wire data_ack; //data re-arrangement buffer ready indicator
output data_ack; //data re-arrangement buffer ready indicator
wire [7:0] data; // byte data transfer from buffer
wire [6:0] addr; // Address for each picture
//wire data_request; // request for the memory data
output data_request; // request for the memory data

lcd_ctrl_2 U_LCDctrl(
  .clk(clk_50k), // LCD controller clock
  .rst_n(rst_n), // active low reset
  .data_ack(data_ack), // data re-arrangement buffer ready indicator
  .data(data), // byte data transfer from buffer
  .lcd_di(lcd_di), // LCD data/instruction 
  .lcd_rw(lcd_rw), // LCD Read/Write
  .lcd_en(lcd_e), // LCD enable
  .lcd_rst(lcd_rst), // LCD reset
  .lcd_cs(lcd_cs), // LCD frame select
  .lcd_data(lcd_d), // LCD data
  .addr(addr), // Address for each picture
  .data_request(data_request), // request for the memory data
  .start_rom(start_rom),
  .finish_rom(finish_rom)
  
);

rom_ctrl U_romctrl(
  .clk(clk_50k), // rom controller clock
  .rst_n(rst_n), // active low reset
  .en(lcd_e), // LCD enable
  .data_request(data_request), // request signal from LCD
  .address(addr), // requested address
  .data_ack(data_ack), // data ready acknowledge
  .data(data) // data to be transferred (byte)
);

clock_divider #(
    .half_cycle(400),
    .counter_width(9)
  ) clk50k (
    .rst_n(rst_n),
    .clk(clk),
    .clk_div(clk_50k)
  );

endmodule
