/***********************************************
Module Name:   reverse_bits
Feature:       Reverse the bits of input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   Forward, 8 bits, operent
Output Ports:  Reversed, 8 bits, set as the reversed bits of input
------------------------------------------------------
History:
12-11-2015: First Version by Garfield
12-11-2015: First verified by Reversed_Bits_test
***********************************************/

module reverse_bits
  ( 
    input[7:0] forward,
    output[0:7] reversed 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign reversed = forward;

endmodule