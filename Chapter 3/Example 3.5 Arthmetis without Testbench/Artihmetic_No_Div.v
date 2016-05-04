/***********************************************
Module Name:   Arithmetic_No_Div
Feature:       Arithmetic Operators without divide for 8 bits input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 8 bits, operent
Output Ports:  sum, 8 bits, sum
               min, 8 bits, minus
               mul, 8 bits, multiply
               div, 8 bits, divide
               mod, 8 bit, modulo
               pow, 8 bits, power
------------------------------------------------------
History:
12-01-2015: First Version by Garfield
***********************************************/

module arithmetic_no_div
  ( 
    input[7:0] a0, a1,
    output[7:0] sum, 
    output[7:0] min, 
    output[7:0] mul 
    //,output[7:0] div 
    //output[7:0] mod
    //output[7:0]  pow
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign sum = a0 + a1;
assign min = a0 - a1;
assign mul = a0 * a1;
//assign div = a0 / a1;
//assign mod = a0 % a1;
//assign pow = a0 ** a1;

endmodule