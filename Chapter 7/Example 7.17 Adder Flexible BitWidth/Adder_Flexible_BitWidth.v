/***********************************************
Module Name:   adder_flexible_biterwidth
Feature:       Counter with parameter bit_width and max_value
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   clk, 1 bit,clk
               RST, 1 bit, reset
               a, b, operents, , bit width defined by parameter WIDTH_A and WIDTH_B
Output Ports:  result, bit width depends on parameters
Parameters:    WIDTH_A, WIDTH_B, bit width
------------------------------------------------------
History:
02-04-2016: First Version by Garfield
02-04-2016: First verified by Adder_Flexible_BitWidth_test
***********************************************/
module adder_flexible_biterwidth 
  ( 
    clk, RST,
    a,b,result
  );
parameter WIDTH_A = 8, WIDTH_B = 8;
//Bit width for input

localparam WIDTH_OUT = 1 + ( (WIDTH_A > WIDTH_B) ? (WIDTH_A) : (WIDTH_B));
//Bit width for output: maximum between the width + 1 bit for carried bit

input clk, RST;
input[WIDTH_A - 1: 0] a;
input[WIDTH_B - 1: 0] b;
output[WIDTH_OUT - 1:0] result;
  
//Load other module(s)

//Definition for Variables in the module

//Logic
assign result = {{(WIDTH_OUT - WIDTH_A){1'b0}}, a} + { {(WIDTH_OUT - WIDTH_A){1'b0}}, b};

endmodule