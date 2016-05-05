/***********************************************
Module Name:   And_Gate_2001_Star
Feature:       And gate in Verilog 2001 with "*"
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

module and_gate_2001_star
  (  
    input a,b,
    output reg result
  );

//Definition for Variables in the module

//Logical
always @(*)
begin
    result <= a & b;
end

endmodule
