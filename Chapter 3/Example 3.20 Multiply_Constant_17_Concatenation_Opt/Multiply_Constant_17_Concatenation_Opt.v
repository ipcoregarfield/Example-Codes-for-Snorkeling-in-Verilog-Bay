/***********************************************
Module Name:   multiply_constant_17_concatenation_opt
Feature:       Multiply by 17 for 8 bits input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, 8 bits, operent
Output Ports:  mul, 16 bits, multiply
------------------------------------------------------
History:
12-10-2015: First Version by Garfield
12-10-2015: First verified by Multiply_Constant_17_Concatenation_Opt_test
***********************************************/

module multiply_constant_17_concatenation_opt
  ( 
    input[7:0] a,
    output[15:0] mul 
  );
  
//Load other module(s)

//Definition for Variables in the module
wire[8:0] sum_middle;
//The 9 bits with adder in the middle bits

//Logical
assign sum_middle = {1'b0, a} + {5'b0_0000, a[7:4]};
assign mul = {3'b000, sum_middle, a[3:0]};

endmodule