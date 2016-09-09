/***********************************************
Module Name:   function_factorial
Feature:       Area calculation with factorial
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               num, 8 bits, width length, unsiged
                     one void value in one clock
Output Ports:  result, 17 bits, factorial value with the num
------------------------------------------------------
History:
01-29-2016: First Version by Garfield
01-29-2016: First verified by Function_test
***********************************************/

module function_factorial
  ( 
    input CLK, input RST,
    input[7:0] num,
    output reg[16:0]result
  );
//Load other module(s)

//Definition for Variables in the module

//Functions for factorial calculation
function automatic[16:0] fact(input[7:0] num);
begin
    fact = (num != 0) ? ( num * fact(num - 1) ) : (1);
end
endfunction

//Logical
always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       result <= 17'h0000;
    end
    else 
    //Data comes
    begin
        result <= fact(num);
    end
end

endmodule