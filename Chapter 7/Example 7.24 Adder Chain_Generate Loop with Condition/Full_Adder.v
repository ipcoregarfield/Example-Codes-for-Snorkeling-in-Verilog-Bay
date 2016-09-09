/***********************************************
Module Name:   Full_Adder
Feature:       Full adder for 1 bit math add
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 1 bit, addends
               c0, 1 bit, carry bit from low bit
Output Ports:  s, 1 bit, sum
               c1, 1 bit, carry bit
------------------------------------------------------
History:
11-30-2015: First Version by Garfield
11-30-2015: Verified by Garfield with Full_Adder_test in ISE/Modelsim
***********************************************/

module full_adder 
  ( 
    input a0, a1,
    input c0,
    output s,
    output c1
  );

//Defination for Varables in the module
wire t1, t2, t3;
//Logicals
//Sum: 
assign s = (a0 ^ a1) ^ c0;

//Carry bit: sperate the equation into 3 indepent parts in order to read
assign t1 = a0 & c0;
assign t2 = a1 & c0;
assign t3 = a0 & a1;
assign c1 = (t1 | t2) | t3;

endmodule