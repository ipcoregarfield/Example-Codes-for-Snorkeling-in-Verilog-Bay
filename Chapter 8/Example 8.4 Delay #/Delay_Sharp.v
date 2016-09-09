/***********************************************
Module Name:   Delay_Sharp
Feature:       Show the dalay # aaplication
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         wire_a: siganl assined
------------------------------------------------------
History:
02-17-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/10 ps
//Simulation time assignment

//Insert the modules

module delay_sharp;
//definition for Variables
reg wire_a;

//Assignment with delay #
    initial
    begin
      wire_a = 1'b0;
      
      #3 wire_a = 1'b1;
      //After 30 ns, assigned again
      
      #15 wire_a = 1'b0;
      //After 150 ns, reset
    end

endmodule