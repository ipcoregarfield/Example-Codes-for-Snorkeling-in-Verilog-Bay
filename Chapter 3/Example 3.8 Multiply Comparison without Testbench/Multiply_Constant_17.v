/***********************************************
Module Name:   multiply_constant_17
Feature:       Multiply by 17 for 8 bits input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, 8 bits, operent
Output Ports:  mul, 16 bits, multiply
------------------------------------------------------
History:
12-02-2015: First Version by Garfield
***********************************************/

module multiply_constant_17
  ( 
    input[7:0] a,
    output[15:0] mul 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign mul = (a<<4) + a;

endmodule