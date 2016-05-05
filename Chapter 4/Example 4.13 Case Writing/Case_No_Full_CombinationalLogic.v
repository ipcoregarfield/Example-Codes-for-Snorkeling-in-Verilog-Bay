/***********************************************
Module Name:   case_no_full_CombinationalLogic
Feature:       Show the RTL with not_full_case
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   Number, 8 bits, operent
               Select, 2 bits, select_flag
Output Ports:  Result, 8 bits, 
               when select = 2'b00: set as the input add 1
					when select = 2'b01: set as the input
					when select = 2'b10: set as the input suntract 1
					else kept
------------------------------------------------------
History:
12-11-2015: First Version by Garfield
12-11-2015: First verified by Reversed_Bits_test
***********************************************/

module case_no_full_CombinationalLogic
  ( 
    input[7:0] number,
	 input[1:0] select,
    output reg[7:0] result 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
always @(*)
begin
    case (select)
        2'b00: 
		  begin
		      result <= number + 8'b0000_0001;
		  end
		  2'b01:
		  begin
		      result <= number;
		  end
		  2'b10:
		  begin
		      result <= number - 8'b0000_0001;
		  end
    endcase
end	 
endmodule