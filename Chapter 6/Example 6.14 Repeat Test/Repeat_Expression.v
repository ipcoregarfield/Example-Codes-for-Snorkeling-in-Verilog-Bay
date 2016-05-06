/***********************************************
Module Name:   repeat_expression
Feature:       Testbench for repeat loop with expression as loop number
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
------------------------------------------------------
History:
01-28-2015: First Version by Garfield
***********************************************/
`timescale 1 ns/100 ps
//Simulation time assignment


module repeat_expression;
//definition for Variables
reg clk;
reg[7:0] loop_number;
//Loop munber with changed

//Connection to the modules

//Module Example

begin

    initial
    begin
      loop_number = 10;
      //Reset
      #1 loop_number = 20;
      //Change number
    end
    
//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      repeat(loop_number)  
      begin
           #10 clk = !clk;
           //Reverse the clock in each 10ns
      end
    end
    
end
endmodule