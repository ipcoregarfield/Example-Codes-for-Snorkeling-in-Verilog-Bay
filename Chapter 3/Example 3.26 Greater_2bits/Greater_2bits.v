/***********************************************
Module Name:   greater_2bits
Feature:       2bits inputs comparison: greater
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a,b  2 bits unsigned , inputs
Output Ports:  result 1 bit, if a > b , 1
------------------------------------------------------
History:
12-15-2015: First Version by Garfield
12-15-2015: First verified by Decode_2_4_test
***********************************************/

module greater_2bits
  ( 
    input[1:0] a, b,
    output result 
  );
  
//Load other module(s)

//Definition for Variables in the module
wire bit1;

//Middle result of selector

//Logical
assign bit1 = ( (a[0] == 1'b1) && (b[0] == 1'b0) ) 
                  ? 1'b1 : 1'b0;
assign result = ( a[1] == b[1]) ? bit1 : a[1];

//1 when not all 0

endmodule