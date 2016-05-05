/***********************************************
Module Name:   DFF_Link_4_8bits_test
Feature:       Testbench for DFF_Link_4_8bits
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         
         in: input_data for DFF_Link_4_8bits, random
----------------------------------------------------
History:
12-28-2015: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module DFF_link_4_test;
//defination for Variables
reg clk;
reg reset;

reg[7:0] in;
wire[7:0] out;

//Connection to the modules
DFF_link_4_8bits D1( .CLK(clk), .RST(reset), .input_data(in),
 	  .output_data(out) );

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
    
    always @(posedge clk)
    begin
        in <= $random();
    end
    
end
endmodule