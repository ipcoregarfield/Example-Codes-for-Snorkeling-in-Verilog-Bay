/***********************************************
Module Name:   Full_Adder_Concatenation
Feature:       Full adder for 1 bit math add with concatenation operator
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 1 bit, addends
               c0, 1 bit, carry bit from low bit
Output Ports:  s, 1 bit, sum
               c1, 1 bit, carry bit
------------------------------------------------------
History:
12-09-2015: First Version by Garfield
12-09-2015: Verified by Garfield with Full_Adder_Concatenation_test in ISE/Modelsim
***********************************************/

module full_adder_concatenation
  ( 
    input a0, a1,
    input c0,
    output s,
    output c1
  );

//Definition for Variables in the module

//Logical
assign {c1,s} = a0 + a1 + c0;
//Full adder with concatenation
//{c1, s} will be looked as 2 bits variable

endmodule