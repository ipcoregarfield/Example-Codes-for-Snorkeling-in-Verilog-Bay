`timescale 1ns / 1ps
/***********************************************
Module Name:   coder_4_2_parallel
Feature:       Show parallel structure 4-2 coder
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   index, 2 bits, operent
Output Ports:  result, 4 bits, 
               when index = 00, result = 0001
					when index = 01, result = 0010
					when index = 10, result = 0100
					when index = 11, result = 1000
------------------------------------------------------
History:
12-22-2015: First Version by Garfield
12-22-2015: First verified by Coder_4_2_Parallel_test
***********************************************/

module coder_4_2_parallel
  ( input[1:0] index,
    output reg[3:0] result     
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
always @(*)
begin
    if (index[1])
	 begin
	     if (index[0])
		  begin
		      result <= 4'b1000;
		  end
        else
        begin
		      result <= 4'b0100;
        end		  
	 end
	 else 
	 begin
	 	  if (index[0])
		  begin
		      result <= 4'b0010;
		  end
        else
        begin
		      result <= 4'b0001;
        end	
	 end
end

endmodule
