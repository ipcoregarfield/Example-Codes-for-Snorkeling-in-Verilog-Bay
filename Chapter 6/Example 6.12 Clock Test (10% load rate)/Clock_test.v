/***********************************************
Module Name:   clock_test
Feature:       Testbench for clock generation 10% load rate
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


module clock_10load_test;
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
           #18 clk = !clk;
           #2  clk = !clk;
           //Reverse the clock in each 18 ns for low and 2 ns for high
      end
    end
end
endmodule