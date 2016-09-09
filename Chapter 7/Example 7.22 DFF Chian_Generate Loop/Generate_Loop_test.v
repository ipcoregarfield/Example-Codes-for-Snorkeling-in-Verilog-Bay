/***********************************************
Module Name:   DFF_chain_generate_test
Feature:       Testbench for DFF_chain_generate
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         
         in: input_data for DFF_Link_4, random
----------------------------------------------------
History:
02-05-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module  DFF_chain_generate_test;
//defination for Variables
reg clk;
reg reset;

reg in;
wire d1, d2;

//Connection to the modules
top_DFF_chain_generate T1( .CLK(clk), .RST(reset), .in(in),
 	                  .delayed1(d1), .delayed2(d2) );

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