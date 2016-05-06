/***********************************************
Module Name:   clock_test
Feature:       Testbench for clock generation
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


module clock_test;
//definition for Variables
reg clk;

//Connection to the modules

//Module Example

begin

//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      forever  
      begin
           #10 clk = !clk;
           //Reverse the clock in each 10ns
      end
    end
end
endmodule