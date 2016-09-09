/***********************************************
Module Name:   int_FreqDiv_G1_test
Feature:       Testbench for int_FreqDiv_G1
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

module int_FreqDiv_G1_test;
//defination for Variables
reg clk;
reg reset;
wire SYNC;

wire c1, c2, c3, c4, c5;
//Out clock with different dividing factors

//Connection to the modules
int_FreqDiv_G1 I1(.CLK_in(clk), .RST(reset),.SYNC(SYNC), .CLK_out(c1));
//Factor = 2

int_FreqDiv_G1 #(.DIV(3)) I2(.CLK_in(clk), .RST(reset), .SYNC(SYNC),.CLK_out(c2));
//Factor = 3

int_FreqDiv_G1 #(.DIV(5)) I3(.CLK_in(clk), .RST(reset),.SYNC(SYNC), .CLK_out(c3));
//Factor = 5

int_FreqDiv_G1 #(.DIV(6)) I4(.CLK_in(clk), .RST(reset), .SYNC(SYNC), .CLK_out(c4));
//Factor = 6

int_FreqDiv_G1 #(.DIV(23)) I5(.CLK_in(clk), .RST(reset), .SYNC(SYNC), .CLK_out(c5));
//Factor = 23

begin
assign SYNC = 1'b1;
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