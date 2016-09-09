/***********************************************
Module Name:   frac_FreqDiv_test
Feature:       Testbench for frac_FreqDiv
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
-----------------------------------------------------
History:
02-05-2016: First Version by Garfield
***********************************************/
`timescale 100 ps/100 ps
//Simulation time assignment

//Insert the modules

module frac_FreqDiv_test;
//defination for Variables
reg clk;
reg reset;

wire c1, c2, c3;
//Out clock with different dividing factors

//Connection to the modules
frac_FreqDiv F1(.CLK_in(clk), .RST(reset), .CLK_out(c1));
//Factor = 3/2

frac_FreqDiv #(.DIV_IN(5), .DIV_OUT(4)) F2(.CLK_in(clk), .RST(reset), .CLK_out(c2));
//Factor = 5/4

frac_FreqDiv #(.DIV_IN(35), .DIV_OUT(12)) F3(.CLK_in(clk), .RST(reset), .CLK_out(c3));
//Factor = 35/12
begin
//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      forever  
      begin
           #25 clk = !clk;
           //Reverse the clock in each 10ns
      end
    end
//200 MHz clock
    
//Reset operation
    initial  
    begin
      reset = 0;
      //Reset enable
      #140  reset = 1;
     //Counter starts
    end
    
end

endmodule