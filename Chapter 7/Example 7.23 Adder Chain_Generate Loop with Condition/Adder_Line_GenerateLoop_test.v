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
         
         in1: input_data adder1
         in2: input_data adder2
----------------------------------------------------
History:
02-05-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module  adder_line_generate_test;
//defination for Variables
reg clk;
reg reset;

wire[7:0] d1;
wire[11:0] d2;
wire[4:0] sum1, s1;
wire[6:0] sum2, s2;

//Connection to the modules
counter_parameter #(.WIDTH(8),.MAX_VALUE(2**8 - 1))
C1  ( .clk(clk), .RST(reset), .counter(d1)  );

counter_parameter #(.WIDTH(12),.MAX_VALUE(2**12 - 1))
C2  ( .clk(clk), .RST(reset), .counter(d2)  );
//Input generate

top_adder_line_generate T1(.a10(d1[3:0]), .a11(d1[7:4]), .sum1(sum1),
                  .a20(d2[5:0]), .a21(d2[11:6]), .sum2(sum2) );

begin
assign s1 = d1[3:0] + d1[7:4];
assign s2 = d2[5:0] + d2[11:6];
 
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