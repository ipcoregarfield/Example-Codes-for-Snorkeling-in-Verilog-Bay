/***********************************************
Module Name:   adder_2001
Feature:       adder for signed integer in Verilog 2001
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0,a1 8 bits, operent
Output Ports:  sum, 9 bits, sum
------------------------------------------------------
History:
12-02-2015: First Version by Garfield
***********************************************/
module adder_2001
  ( 
    input signed[7:0] a0, a1,
    output signed[8:0] sum
  );

//Load other module(s)

//Definition for Variables in the module

//Logical
assign sum = a0 + a1;

endmodule