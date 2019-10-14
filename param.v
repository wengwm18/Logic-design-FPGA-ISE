`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:45 06/06/2016 
// Design Name: 
// Module Name:    param 
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
// common parameters
//
// freq. divider
`define FREQ_DIV_BIT 25 // #bits for freq divider
`define FTSD_SCAN_CTL_BIT_WIDTH 2 // #bits for 14-seg display scan control

// Counter
`define CNT_BIT_WIDTH 4 //number of bits for the counter

// 14-segment display
`define FTSD_BIT_WIDTH 15 // 14-segment display control
`define FTSD_NUM 4 // number of 14-segment displays
`define BCD_BIT_WIDTH 4 // #bits of a BCD digit
`define FTSD_ZERO `FTSD_BIT_WIDTH'b0000_0011_1111_111 //0
`define FTSD_ONE `FTSD_BIT_WIDTH'b1001_1111_1111_111 //1
`define FTSD_TWO `FTSD_BIT_WIDTH'b0010_0100_1111_111 //2
`define FTSD_THREE `FTSD_BIT_WIDTH'b0000_1100_1111_111 //3
`define FTSD_FOUR `FTSD_BIT_WIDTH'b1001_1000_1111_111 //4
`define FTSD_FIVE `FTSD_BIT_WIDTH'b0100_1000_1111_111 //5
`define FTSD_SIX `FTSD_BIT_WIDTH'b0100_0000_1111_111 //6
`define FTSD_SEVEN `FTSD_BIT_WIDTH'b0001_1111_1111_111 //7
`define FTSD_EIGHT `FTSD_BIT_WIDTH'b0000_0000_1111_111 //8
`define FTSD_NINE `FTSD_BIT_WIDTH'b0000_1000_1111_111 //9
`define FTSD_A `FTSD_BIT_WIDTH'b0001_0000_1111_111 //A
`define FTSD_B `FTSD_BIT_WIDTH'b0000_1110_1011_011 //B
`define FTSD_C `FTSD_BIT_WIDTH'b0110_0011_1111_111 //C
`define FTSD_D `FTSD_BIT_WIDTH'b0000_1111_1011_011 //D
`define FTSD_E `FTSD_BIT_WIDTH'b0110_0000_1111_111 //E
`define FTSD_F `FTSD_BIT_WIDTH'b0111_0000_1111_111 //F
`define FTSD_N `FTSD_BIT_WIDTH'b1001_0011_0111_101 //N
`define FTSD_T `FTSD_BIT_WIDTH'b0111_1111_1011_011 //T
`define FTSD_H `FTSD_BIT_WIDTH'b1001_0000_1111_111 //H
`define FTSD_U `FTSD_BIT_WIDTH'b1000_0011_1111_111 //U
`define FTSD_M `FTSD_BIT_WIDTH'b1001_0011_0101_111 //M
`define FTSD_P `FTSD_BIT_WIDTH'b0011_0000_1111_111 //P
`define FTSD_R `FTSD_BIT_WIDTH'b0011_0000_1111_101 //R
`define FTSD_I `FTSD_BIT_WIDTH'b0110_1111_1011_011 //I
`define FTSD_L `FTSD_BIT_WIDTH'b1110_0011_1111_111 //L
`define FTSD_DEF `FTSD_BIT_WIDTH'b1111_1111_1111_111 //default
`define FTSD_MINUS `FTSD_BIT_WIDTH'b1111_1100_1111_1111 // minus sign
// Keypad scan
`define KEYPAD_ROW_WIDTH 4 // keypad Row width
`define KEYPAD_COL_WIDTH 4 // keypad column width
`define KEYPAD_DEC_WIDTH 8 // #bits of keypad decoding (row+col)
`define KEY_0 4'd0 // key '0'
`define KEY_1 4'd1 // key '1'
`define KEY_2 4'd2 // key '2'
`define KEY_3 4'd3 // key '3'
`define KEY_4 4'd4 // key '4'
`define KEY_5 4'd5 // key '5'
`define KEY_6 4'd6 // key '6'
`define KEY_7 4'd7 // key '7'
`define KEY_8 4'd8 // key '8'
`define KEY_9 4'd9 // key '9'
`define KEY_A 4'd10 // key 'A'
`define KEY_B 4'd11 // key 'B'
`define KEY_C 4'd12 // key 'C'
`define KEY_D 4'd13 // key 'D'
`define KEY_E 4'd14 // key 'E'
`define KEY_F 4'd15 // key 'F'
`define KEYPAD_PRESSED 1'b1 // key pressed indicator
`define KEYPAD_NOT_PRESSED 1'b0 // key not pressed indicator
`define SCAN 1'b1 // keypad readout FSM: scan
`define PAUSE 1'b0 // keypad readout FSM: pause
`define KEYPAD_PAUSE_PERIOD_BIT_WIDTH 4 // #bits for keypad pause period
