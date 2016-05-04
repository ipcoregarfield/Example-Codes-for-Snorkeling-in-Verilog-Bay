/***********************************************
Module Name:   reverse_bits_concatenation
Feature:       Reverse the bits of input with concatenation operation
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

module reverse_bits_concatenation
  ( 
    input[7:0] forward,
    output[7:0] reversed 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign reversed = {forward[0], forward[1],forward[2], forward[3],
                   forward[4], forward[5],forward[6], forward[7] 
						 };

endmodule