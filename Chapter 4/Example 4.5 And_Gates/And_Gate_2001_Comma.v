/***********************************************
Module Name:   And_Gate_2001_Comma
Feature:       And gate in Verilog 2001 with "," between sensitive signals
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 1 bit
Output Ports:  result, 1 bits
------------------------------------------------------
History:
12-17-2015: First Version by Garfield
12-17-2015: Verified by Garfield with And_Gates_test in ISE/Modelsim
***********************************************/

module and_gate_2001_comma
  (  
    input a,b,
    output reg result
  );

//Definition for Variables in the module

//Logical
always @(a , b)
begin
    result <= a & b;
end

endmodule
