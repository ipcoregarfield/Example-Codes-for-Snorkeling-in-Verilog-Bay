/***********************************************
Module Name:   Abs
Feature:       Absolute Value
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   signed_value, 8 bits, operent
Output Ports:  result, 7 bits, absolute value of input
------------------------------------------------------
History:
12-18-2015: First Version by Garfield
12-18-2015: First Verified by Abs_test by Garfield
***********************************************/

module abs
  ( 
    input[7:0] signed_value, 
    output reg[6:0] result
  );

//Definition for Variables in the module


//Load other module(s)

//Logical
always @(signed_value)
begin
    if ( signed_value[7])
	 //Negative number input
	 begin
	     result <= (~signed_value[6:0]) + 7'h01;
	 end
	 else
	 //Positive number or zero input
	 begin
	     result <= signed_value[6:0];
	 end
end

endmodule