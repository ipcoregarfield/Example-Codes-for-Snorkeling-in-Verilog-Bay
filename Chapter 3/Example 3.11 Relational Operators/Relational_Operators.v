/***********************************************
Module Name:   Relational_Operators
Feature:       4 bits numbers comparison
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 4 bits, operent
Output Ports:  greater, 1 bit, ">"
               lease, 1 bit, "<"
               no_lease, 1bit, ">="
               no_great, 1 bit, "<="
               equal, 1 bit, "=="
               no_equal, 1 bit, "!="                
------------------------------------------------------
History:
12-03-2015: First Version by Garfield
12-03-2015: First verified by Relational_Operators_test  ISE/Modelsim
***********************************************/

module Relational_Operators
  ( 
    input[3:0] a, b,
    output greater, lease
           ,no_lease, no_great
           ,equal, no_equal
  );

//Definition for Variables in the module


//Load other module(s)

//Logical
assign greater = (a > b);
assign lease = (a < b);
assign no_lease = (a >= b);
assign no_great = (a <= b);
assign equale = (a == b);
assign no_equale = (a != b); 
endmodule