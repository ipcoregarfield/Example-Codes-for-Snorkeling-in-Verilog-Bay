/***********************************************
Module Name:   multiply_constant_17_concatenation
Feature:       Multiply by 17 for 8 bits input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, 8 bits, operent
Output Ports:  mul, 16 bits, multiply
------------------------------------------------------
History:
12-10-2015: First Version by Garfield
12-10-2015: First verified by Multiply_Constant_17_Concatenation_test
***********************************************/

module multiply_constant_17_concatenation
  ( 
    input[7:0] a,
    output[15:0] mul 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign mul = {4'b0000, a, 4'b0000} +{8'h00, a};

endmodule