`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:10 06/07/2016 
// Design Name: 
// Module Name:    lcd_ctrl 
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
`define LCD_SET_DSL      10'b0_0_11000000
`define LCD_ERASE        10'b1_0_00000000
`define LCD_DISPLAY_IDLE 10'b0_0_00111111
`define INIT_LCD     3'b000
`define ERASE_LCD    3'b001
`define LCD_IDLE         3'b010
`define REQUEST_DATA 3'b011
`define READ_DATA    3'b100
`define PAUSE_2 3'b101   /////修改過
`define ENABLED  1'b1
`define DISABLED 1'b0

module lcd_ctrl_2(
  clk, // LCD controller clock
  rst_n, // active low reset
  data_ack, // data re-arrangement buffer ready indicator
  data, // byte data transfer from buffer
  lcd_di, // LCD data/instruction 
  lcd_rw, // LCD Read/Write
  lcd_en, // LCD enable
  lcd_rst, // LCD reset
  lcd_cs, // LCD frame select
  lcd_data, // LCD data
  addr, // Address for each picture
  data_request, // request for the memory data
  start_rom,
  finish_rom
);
input start_rom;
output reg finish_rom;
input clk; // LCD controller clock
input rst_n; // active low reset
input data_ack; // data re-arrangement buffer ready indicator
input [7:0] data; // byte data transfer from buffer
output lcd_di; // LCD data/instruction 
output lcd_rw; // LCD Read/Write
output lcd_en; // LCD enable
output lcd_rst; // LCD reset
output [1:0] lcd_cs; // LCD frame select
output [7:0] lcd_data; // LCD data
output [6:0] addr; // Address for each picture
output data_request; // request for the memory data

reg finish_rom_tmp;
reg lcd_di; // LCD data/instruction 
reg lcd_rw; // LCD Read/Write
reg [7:0] lcd_data; // LCD data
reg lcd_di_next; // LCD data/instruction 
reg lcd_rw_next; // LCD Read/Write
reg [7:0] lcd_data_next; // LCD data
reg data_request; // request for the memory data
reg data_request_next; // request for the memory data
reg lcd_en; // LCD enable
wire lcd_en_next; // LCD enable

reg [2:0] state; // FSM state definition
reg [2:0] state_next; // FSM state definition

reg [7:0] counter_y; // y counter
reg [7:0] counter_y_next; // y counter
reg [3:0] counter_page; // page counter
reg [3:0] counter_page_next; // page counter

reg [3:0] image; // image counter
reg [3:0] image_next; // image counter

reg [15:0] idle_counter; // idle time counter
reg [15:0] idle_counter_next; // idle time counter

assign addr = {image, counter_page[2:0]};
assign lcd_rst = rst_n;
assign lcd_cs = 2'b01;

// Counter for the LCD
// counter_y: counter for the y axis
// counter_page: counter for the pages

// FSM for LCD
always @*
begin
//  set_lcd_value(`LCD_DISPLAY_IDLE,lcd_di_next,lcd_rw_next,lcd_data_next); 
  {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_DISPLAY_IDLE;
  state_next = state;
  counter_page_next = counter_page;
  counter_y_next = counter_y;
  image_next = image;
  idle_counter_next = idle_counter;
  data_request_next = data_request;
  if (~lcd_en)
  begin
    case (state)
      
		
		`INIT_LCD:
      begin
        {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_SET_DSL;
        state_next = `ERASE_LCD;
        counter_y_next = 7'd0;
        counter_page_next = 4'd0;
      end
     

	  `ERASE_LCD:
      begin
        if (counter_page<=4'd7 && counter_y<7'd63)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_ERASE;			 
          counter_y_next = counter_y + 1'b1;
        end // Erase first 63 bytes in same page
        else if (counter_page<=4'd7 && counter_y == 7'd63)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_ERASE;
          counter_y_next = counter_y + 1'b1;
          counter_page_next = counter_page + 1'b1;
        end // Erase last byte in page and prepare change to next page
        else if (counter_page<=4'd7 && counter_y == 7'd64)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {7'b0_0_10111, counter_page[2:0]};
          counter_y_next = 7'b0;
        end // change to next page for erasing
        else if (counter_page==4'd8 && counter_y==7'd64)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {4'b0_0_01, 6'b0};
          counter_y_next = counter_y + 1'b1;
        end // Set Y
        else if (counter_page==4'd8 && counter_y==7'd65)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {7'b0_0_10111, 3'd0};
          counter_y_next = 7'd0;
          counter_page_next = 4'b0;
          state_next = `LCD_IDLE;
          image_next = 4'd0;
        end // Set X
      end
      
		
		
		`LCD_IDLE:
      begin
        {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_DISPLAY_IDLE;
        if (idle_counter >= 16'd10000 && start_rom==1)
        begin
		    finish_rom_tmp = 1'd0;
          state_next = `REQUEST_DATA;
          idle_counter_next = 16'd0;
          counter_y_next = 7'd0;
          counter_page_next = 4'd0;
        end
        else
        begin
          state_next = `LCD_IDLE;
          idle_counter_next = idle_counter + 16'b1;
			 finish_rom_tmp = finish_rom;
        end
      end
    


	 `REQUEST_DATA:
      begin
        data_request_next = `ENABLED;
        if (data_ack == `ENABLED)
        begin
          state_next = `READ_DATA;
          data_request_next = `DISABLED;
          counter_y_next = 7'd0;
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {7'b0_0_10111, counter_page[2:0]};
        end
      end
   


   `READ_DATA:
      begin
        if (counter_y<7'd63)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {2'b1_0,data};
          counter_y_next = counter_y + 1'b1;
        end
        else if (counter_y==7'd63)
        begin
          {lcd_di_next,lcd_rw_next,lcd_data_next} = {2'b1_0,data};
          counter_y_next = counter_y + 1'b1;
          counter_page_next = counter_page + 1'b1;
        end
        else if (counter_y==7'd64)
        begin
          counter_y_next = 7'd0;
          if (counter_page==4'd8)
          begin
				if(image==4'd8)
					begin
					image_next = 4'd8; // change to next image
					state_next = `PAUSE_2;/////修改過
					finish_rom_tmp = 1'd1;
					end
				else
					begin
					image_next = image + 1'b1; // change to next image
					state_next = `LCD_IDLE;
					finish_rom_tmp = 1'd1;
					end
			 end			///修改過
          else
            state_next = `REQUEST_DATA;
        end
      end
  



		`PAUSE_2:  //////修改過
      begin
        {lcd_di_next,lcd_rw_next,lcd_data_next} = `LCD_DISPLAY_IDLE;
        if (idle_counter>= 16'd50000 && start_rom==1)///修改10000成40000
        begin
		  finish_rom_tmp = 1'd0;
		  state_next = `REQUEST_DATA;
          idle_counter_next = 16'd0;
          counter_y_next = 7'd0;
          counter_page_next = 4'd0;
			 image_next = 4'd0;
        end
        else
        begin
          state_next = `PAUSE_2;
          idle_counter_next = idle_counter + 16'b1;
			 finish_rom_tmp = finish_rom;
        end
      end




    endcase
  end
end




always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    state <= 3'd0;
    counter_y <= 7'd0;
    counter_page <= 4'd0;
    image <= 4'd0;
    idle_counter <= 17'd0;
    data_request <= 1'b0;
    lcd_di <= 1'b0;
    lcd_rw <= 1'b0;
    lcd_data <= 8'd0;
    lcd_en <= 1'b0;
	 finish_rom<=1'd1;
  end
  else
  begin
    state <= state_next;
    counter_y <= counter_y_next;
    counter_page <= counter_page_next;
    image <= image_next;
    idle_counter <= idle_counter_next;
    data_request <= data_request_next;
    lcd_di <= lcd_di_next;
    lcd_rw <= lcd_rw_next;
    lcd_data <= lcd_data_next;
    lcd_en <= lcd_en_next;
	 finish_rom<=finish_rom_tmp;
  end

assign lcd_en_next = ~lcd_en;

endmodule
