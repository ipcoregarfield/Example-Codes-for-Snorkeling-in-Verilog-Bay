/***********************************************
Module Name:   Bypass
Feature:       Input bypass to output
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   Input_Data, 8 bits
Output Ports:  Output_Data, 8 bits, equales Input_Data
------------------------------------------------------
History:
11-27-2015: First Version by Garfield
11-27-2015: Verified by Garfield with Bypass_test in ISE/Modelsim
***********************************************/

module Bypass 
  ( 
    input[7:0] Input_Data,
    output wire[7:0] Output_Data
  );

//Defination for Varables in the module

//Logicals
assign Output_Data =  Input_Data;

endmodule