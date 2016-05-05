/***********************************************
Module Name:   Greater_Always
Feature:       4 bits numbers greater comparison
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 4 bits, operent
Output Ports:  greater, 1 bit, ">"
------------------------------------------------------
History:
12-17-2015: First Version by Garfield
12-17-2015: First verified by Greater_Always_test  ISE/Modelsim
***********************************************/

module greater_always
  ( 
    input[3:0] a, b,
    output reg greater
  );

//Definition for Variables in the module


//Load other module(s)

//Logical
always @(*)
begin
    greater <= (a > b);
end

endmodule