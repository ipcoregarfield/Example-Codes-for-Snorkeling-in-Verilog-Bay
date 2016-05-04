/***********************************************
Module Name:   adder_1995
Feature:       adder for signed integer in Verilog 1995
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 8 bits, operent
Output Ports:  sum, 9 bits, sum
------------------------------------------------------
History:
12-02-2015: First Version by Garfield
***********************************************/

module adder_1995
  ( 
    input[7:0] a0, a1,
    output[8:0] sum
  );

//Load other module(s)

//Definition for Variables in the module

//Logical
assign sum = {a0[7],a0} + {a1[7],a1};

endmodule