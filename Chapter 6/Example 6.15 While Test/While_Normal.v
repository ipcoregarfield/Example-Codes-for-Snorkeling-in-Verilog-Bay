/***********************************************
Module Name:   while_normal
Feature:       Testbench for while loop
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


module while_normal;
//definition for Variables
reg clk;
reg[3:0] loop_number = 0;

//Connection to the modules

//Module Example

begin

//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      while (loop_number < 10)  
      begin
           #10 clk = !clk;
           //Reverse the clock in each 10ns
           
           loop_number = loop_number + 1;
           //loop counter increase
      end
    end
end
endmodule