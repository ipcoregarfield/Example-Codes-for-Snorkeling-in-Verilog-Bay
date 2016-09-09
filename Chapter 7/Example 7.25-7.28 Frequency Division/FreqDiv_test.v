/***********************************************
Module Name:   FreqDiv_test
Feature:       Testbench for FreqDiv
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

module FreqDiv_test;
//defination for Variables
reg clk;
reg reset;

wire c1, c2, c3, c4, c5;
//Out clock with different dividing factors

//Connection to the modules
FreqDiv #(.DIV_IN(5), .DIV_OUT(4)) F1(.CLK_in(clk), .RST(reset), .CLK_out(c1));
//Fractional frequency divison

FreqDiv #(.DIV_IN(5), .DIV_OUT(1)) F2(.CLK_in(clk), .RST(reset), .CLK_out(c2));
//Integer frequency divison

FreqDiv #(.DIV_IN(5), .DIV_OUT(0)) F3(.CLK_in(clk), .RST(reset), .CLK_out(c3));
//Integer frequency divison

FreqDiv #(.DIV_IN(0), .DIV_OUT(0)) F4(.CLK_in(clk), .RST(reset), .CLK_out(c4));
//Integer frequency divison

FreqDiv #(.DIV_IN(5), .DIV_OUT(9)) F5(.CLK_in(clk), .RST(reset), .CLK_out(c5));
//Illegal

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