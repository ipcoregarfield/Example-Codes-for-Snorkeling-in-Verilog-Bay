/***********************************************
Module Name:   adder_4bits
Feature:       4 bits adder in chain structure
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 4 bits, operent
Output Ports:  sum, 4 bits, sum
               c, 1 bit, carry bit
------------------------------------------------------
History:
12-03-2015: First Version by Garfield
12-03-2015: First verified by Adder_4bits_test  ISE/Modelsim
***********************************************/

module adder_4bits
  ( 
    input[3:0] a, b,
    output[3:0] sum,
    output c
  );

//Definition for Variables in the module
wire c0, c1, c2; //Carry bits within the chain

//Load other module(s)
half_adder H0( .a0(a[0]), .a1(b[0]), .s(sum[0]), .c1(c0) );
full_adder F1( .a0(a[1]), .a1(b[1]), .c0(c0), .s(sum[1]), .c1(c1) );
full_adder F2( .a0(a[2]), .a1(b[2]), .c0(c1), .s(sum[2]), .c1(c2) );
full_adder F3( .a0(a[3]), .a1(b[3]), .c0(c2), .s(sum[3]), .c1(c) );

//Logical

endmodule