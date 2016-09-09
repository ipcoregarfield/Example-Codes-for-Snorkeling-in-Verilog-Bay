/***********************************************
Module Name:   Counter_Parameter_test
Feature:       Testbench for Counter_Parameter
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
-----------------------------------------------------
History:
02-04-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module counter_parameter_test;
//defination for Variables
reg clk;
reg reset;

wire[7:0] counter1;
wire[3:0] counter2;
wire[2:0] counter3;
//Connection to the modules
top_counter_parameter T1(.clk(clk), .RST(reset),
                        .counter1(counter1), .counter2(counter2), 
                        .counter3(counter3));

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