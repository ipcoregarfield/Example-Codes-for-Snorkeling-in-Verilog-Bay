/***********************************************
Module Name:   Adder_4bits_GenerateIf_test
Feature:       Testbench for Adder_4bits_GenerateIf
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk1, clk2: clock for processing
         reset: reset flag
-----------------------------------------------------
History:
02-05-2016: First Version by Garfield
***********************************************/
`timescale 100 ps/100 ps
//Simulation time assignment

//Insert the modules

module adder_4bits_generateif_test;
//defination for Variables
reg clk1, clk2;
reg reset;

wire[7:0] num;

wire[3:0] sum1, sum2;
wire c1, c2;

//Connection to the modules
counter_parameter #(.WIDTH(8),.MAX_VALUE(2**8 - 1))
C1  ( .clk(clk2), .RST(reset), .counter(num)  );

top_adder_4bits_generateif A1(.a(num[3:0]), .b(num[7:4]),
          .CLK1(clk1), .CLK2(clk2), .RST(reset),
          .sum1(sum1), .sum2(sum2), .c1(c1), .c2(c2)
            );

begin
//Clock generation
    initial
    begin
      clk1 = 0;
      //Reset
      forever  
      begin
           #25 clk1 = !clk1;
           //Reverse the clock in each 10ns
      end
    end
//200 MHz clock
    
    initial
    begin
      clk2 = 0;
      //Reset
      forever  
      begin
           #100 clk2 = !clk2;
           //Reverse the clock in each 10ns
      end
    end
//50 MHz clock
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