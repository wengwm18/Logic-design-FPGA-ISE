`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:35:13 06/06/2016 
// Design Name: 
// Module Name:    hit_diglett 
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
module hit_diglett(clk,rst_n,LCD_rst,LCD_cs,LCD_rw,LCD_di,LCD_data,LCD_en,col_n,row_n,Q ,au_appsel,au_sysclk,au_bck, au_ws, au_data,data_request,data_ack,dip1,dip2,ftsd_ctl,display//pb1,pb2,pb3,//
    );
//input  pb1,pb2,pb3;
output [3:0]ftsd_ctl;
output [14:0]display;
input clk,dip1,dip2;
input rst_n;
output data_request; // request for the memory data
output data_ack;
output LCD_rst;
output reg[1:0]  LCD_cs;
output reg LCD_rw;
output reg LCD_di;
output reg [7:0]  LCD_data;
output reg LCD_en;
input [3:0]col_n;
output [3:0]row_n;
output [15:0]Q;
output au_appsel; // playing mode selection
output au_sysclk; // control clock for DAC (from crystal)
output au_bck; // bit clock of au data (5MHz)
output au_ws; // left/right parallel to serial control
output au_data; // serial output au data
wire clk_out,clk_out2,clk_out3,clk_out4,clk_slow;
wire [1:0]ftsd_clk;
wire [3:0]key_random;
wire [3:0]key;
wire pressed;
wire[1:0]  LCD_cs_1,LCD_cs_2;
wire LCD_rw_1,LCD_rw_2;
wire LCD_di_1,LCD_di_2;
wire [7:0]  LCD_data_1, LCD_data_2;
wire LCD_en_1, LCD_en_2;
wire [25:0]cnt;
wire finish;
wire finish_ram;
wire finish_rom;
wire [3:0]value1,value2,value3,value4;
wire [3:0]ftsd_in;
wire [1:0]key_new;
wire clk_debounce;
//wire pb1_debounce,pb2_debounce,pb3_debounce;
//wire pb1_in,pb2_in,pb3_in;
//wire fsm_pb1,fsm_pb2,fsm_pb3;

freq_div1 D0
(  .clk_slow(clk_slow),
	.clk_out(clk_out),					// 2s
	.clk_out2(clk_out2),				// 1s
	.clk_out3(clk_out3),				// 0.5s
	.clk_out4(clk_out4),				// 0.25s
	.ftsd_clk(ftsd_clk),
	.clk(clk),						// global clock input
	.rst_n(rst_n)						// active low reset

);


score_key D00( .cnt(cnt), .key(key) ,.key_random(key_random), .key_new(key_new),.finish(finish));



/*debounce_circuit U0(.pb_debounced(pb1_debounce),.clk(clk_debounce),.rst_n(rst_n),.pb_in(pb1));
debounce_circuit U1(.pb_debounced(pb2_debounce),.clk(clk_debounce),.rst_n(rst_n),.pb_in(pb2));
debounce_circuit U2(.pb_debounced(pb3_debounce),.clk(clk_debounce),.rst_n(rst_n),.pb_in(pb3));

one_pulse U3(.out_pulse(pb1_in),.clk(clk),.rst_n(rst_n),.in_trig(pb1_debounce));
one_pulse U4(.out_pulse(pb2_in),.clk(clk),.rst_n(rst_n),.in_trig(pb2_debounce));
one_pulse U5(.out_pulse(pb3_in),.clk(clk),.rst_n(rst_n),.in_trig(pb3_debounce));

fsm U6(.cnt_enable(fsm_pb1), .in(pb1_in), .clk(clk), .rst_n((~pb2_debounce) || ~(pb3_debounce) || rst_n), .en(1'd1));
fsm U7(.cnt_enable(fsm_pb2), .in(pb2_in), .clk(clk), .rst_n((~pb1_debounce) || ~(pb3_debounce) || rst_n), .en(1'd1));
fsm U8(.cnt_enable(fsm_pb3), .in(pb3_in), .clk(clk), .rst_n((~pb2_debounce) || ~(pb1_debounce) || rst_n), .en(1'd1));*/

score_2  D1
(
	.value1(value1),
	.value2(value2),
	.value3(value3),
	.value4(value4),
	.key(key_new),
	.state(pressed),
	.clk(clk),
	.rst_n(rst_n)
	//.pb1(fsm_pb1),
	//.pb2(fsm_pb2),
	//.pb3(fsm_pb3)
);

scan_ctl  D2
(
	.ftsd_ctl(ftsd_ctl),          //北led縊output
	.ftsd_in(ftsd_in),             //北14琿陪ボ竟output
	.in0(value1),  
	.in1(value2),  
	.in2(value3),                   //10计
	.in3(value4),                   //计
	.ftsd_ctl_en(ftsd_clk),
	.clk(clk),
	.rst_n(rst_n)
);

ftsd  D3
(
	.segment(display),
	.ftsd_in(ftsd_in)
);





lcd_RAM_1 D4(.clk(clk),.rst_n(rst_n),.LCD_rst(LCD_rst),.LCD_cs(LCD_cs_1),.LCD_rw(LCD_rw_1),.LCD_di(LCD_di_1),.LCD_data(LCD_data_1),.LCD_en(LCD_en_1),.col_n(col_n),.row_n(row_n),.key_random(key_random),.key(key),.pressed(pressed),.cnt(cnt),.finish(finish),.finish_ram(finish_ram),.start_ram(finish_rom),.dip1(dip1),.dip2(dip2),.clk_debounce(clk_debounce));

lcd_ROM D5(.clk(clk),.rst_n(rst_n),.data_request(data_request),.data_ack(data_ack),.lcd_rst(LCD_rst),.lcd_cs(LCD_cs_2),.lcd_rw(LCD_rw_2),.lcd_di(LCD_di_2),.lcd_d(LCD_data_2),.lcd_e(LCD_en_2),.start_rom(finish_ram),.finish_rom(finish_rom) );
always@*
		begin
      if(finish_rom==1)
			begin
			LCD_cs=LCD_cs_1;
			LCD_rw=LCD_rw_1;
			LCD_di=LCD_di_1;
			LCD_data=LCD_data_1;
			LCD_en=LCD_en_1;			

			end
			
		else //if(finish_rom ==0 && finish_ram ==1)
			begin
			LCD_cs=LCD_cs_2;
			LCD_rw=LCD_rw_2;
			LCD_di=LCD_di_2;
			LCD_data=LCD_data_2;
			LCD_en=LCD_en_2;
			end
			
			
		/*else 
			begin
			LCD_cs=LCD_cs_1;
			LCD_rw=LCD_rw_1;
			LCD_di=LCD_di_1;
			LCD_data=LCD_data_1;
			LCD_en=LCD_en_1;			
			end*/
		
		
	end


led D6(.finish(finish),.clk(clk),.rst_n(rst_n),.led(Q));

sound D7( .clk(clk),.rst_n(rst_n),.key(key),.key_random(key_random),.au_appsel(au_appsel),.au_sysclk(au_sysclk),.au_bck(au_bck), .au_ws(au_ws), .au_data(au_data), .pressed(pressed),.cnt(cnt),.finish(finish));






endmodule
