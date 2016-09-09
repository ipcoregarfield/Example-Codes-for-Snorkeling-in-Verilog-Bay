/***********************************************
Module Name:   hello_read_create_test
Feature:       Testbench for hello_read_create
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
----------------------------------------------------
History:
03-01-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module hello_read_create_test;
//defination for Variables
reg clk;
reg reset;

wire[7:0] letter;

//Connection to the modules
hello_read_create C1( .CLK(clk), .RST(reset),
 	  .letter(letter) );

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

//Reset operation
    initial  
    begin
      reset = 0;
      //Reset enable
      #14  reset = 1;
     //Counter starts
    end
end

endmodule
