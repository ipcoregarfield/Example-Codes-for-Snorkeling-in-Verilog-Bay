/***********************************************
Module Name:   Muliply_Common
Feature:       Common muliply with "*"
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 8 bits, operent
Output Ports:  mul, 16 bits, multiply
------------------------------------------------------
History:
12-02-2015: First Version by Garfield
12-02-2015: Verified by Garfield with Full_Adder_test in ISE/Modelsim
***********************************************/

module multiply_common 
  ( 
    input[7:0] a0, a1,
    output[15:0] mul
  );
  
//Load other module(s)

//Defination for Varables in the module

//Logicals
assign mul = a0 * a1;

endmodule