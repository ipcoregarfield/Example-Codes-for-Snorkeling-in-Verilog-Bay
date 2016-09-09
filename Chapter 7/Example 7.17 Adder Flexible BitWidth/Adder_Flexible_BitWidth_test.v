/***********************************************
Module Name:   Adder_Flexible_Bitwidth_test
Feature:       Testbench for Adder_Flexible_Bitwidth
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
`define WIDTH_1 8
`define WIDTH_2 8
`define WIDTH_12 9
`define WIDTH_3 16
//Bit width definition

module adder_flexible_bitWidth_test;
//defination for Variables
reg clk;
reg reset;

wire[`WIDTH_1 -1:0] a1;
wire[`WIDTH_2 -1:0] a2;
wire[`WIDTH_12 -1:0] b1;
wire[`WIDTH_3 -1:0] b2;
wire[`WIDTH_3 + 1 -1:0] c, c1;
//Connection to the modules
counter_parameter #(.WIDTH(`WIDTH_1),.MAX_VALUE(200))
                  C1( .clk(clk), .RST(reset),
                      .counter(a1));
counter_parameter #(.WIDTH(`WIDTH_2),.MAX_VALUE(234))
                  C2( .clk(clk), .RST(reset),
                      .counter(a2));  
counter_parameter #(.WIDTH(`WIDTH_3),.MAX_VALUE(425))
                  C3( .clk(clk), .RST(reset),
                      .counter(b2));   
//Generate Operents

adder_flexible_biterwidth
         #(.WIDTH_A(`WIDTH_1), .WIDTH_B(`WIDTH_2))
        A1(  .a(a1),.b(a2),.result(b1) );
adder_flexible_biterwidth
         #(.WIDTH_A(`WIDTH_12), .WIDTH_B(`WIDTH_3))
        A2(  .a(b1),.b(b2),.result(c) );
//Operations  
                                                             
begin
    assign c1 = a1 + a2 + b2;
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