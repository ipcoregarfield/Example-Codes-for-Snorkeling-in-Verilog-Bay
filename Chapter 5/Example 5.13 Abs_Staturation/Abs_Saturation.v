/***********************************************
Module Name:   Abs_Saturation
Feature:       Absolute Value with saturation for -128
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   signed_value, 8 bits, operent
Output Ports:  result, 7 bits, absolute value of input
------------------------------------------------------
History:
01-06-2016: First Version by Garfield
01-06-2016: First Verified by Abs_Saturation_test by Garfield
***********************************************/

module abs_saturation
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
	 	   if ( signed_value[6:0] == 7'b000_0000)
	 	   //-128
	 	   begin
	 	       result <= 7'h7f;
	 	   end
	 	   else
	 	   begin
	         result <= (~signed_value[6:0]) + 7'h01;
	     end
	 end
	 else
	 //Positive number or zero input
	 begin
	     result <= signed_value[6:0];
	 end
end

endmodule