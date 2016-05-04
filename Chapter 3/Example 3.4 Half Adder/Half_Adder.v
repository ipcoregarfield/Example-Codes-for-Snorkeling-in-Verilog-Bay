/***********************************************
Module Name:   Half_Adder
Feature:       Half adder for 1 bit math add
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 1 bit, addends
Output Ports:  s, 1 bit, sum
               c1, 1 bit, carry bit
------------------------------------------------------
History:
11-30-2015: First Version by Garfield
11-30-2015: Verified by Garfield with Full_Adder_test in ISE/Modelsim
***********************************************/

module half_adder 
  ( 
    input a0, a1,
    output s,
    output c1
  );
  
//Load other module(s)
full_adder F1(.a0(a0), .a1(a1), .c0(1'b0),
               .s(s), .c1(c1));

//Defination for Varables in the module

//Logicals

endmodule