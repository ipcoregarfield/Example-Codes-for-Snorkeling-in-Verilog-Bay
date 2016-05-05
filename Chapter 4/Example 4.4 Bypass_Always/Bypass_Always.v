/***********************************************
Module Name:   Bypass_Alwyas
Feature:       Input bypass to output with alwyas block
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   Input_Data, 8 bits
Output Ports:  Output_Data, 8 bits, equales Input_Data
------------------------------------------------------
History:
11-17-2015: First Version by Garfield
12-17-2015: Verified by Garfield with Bypass_Always_test in ISE/Modelsim
***********************************************/

module Bypass_Always
  ( 
    input[7:0] Input_Data,
    output reg[7:0] Output_Data
  );

//Definition for Variables in the module

//Logical
always @(*)
begin
    Output_Data <= Input_Data;
end

endmodule