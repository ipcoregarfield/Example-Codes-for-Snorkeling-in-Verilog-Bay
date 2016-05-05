/***********************************************
Module Name:   Greater_Pipeline_test
Feature:       Testbench for Greater_Pipeline
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         cntr: counter for the EN and CLRinput 
         
         EN: module counter input
         CLR: module counter input
         out_num: output port for the counter module, 8 bits 
			sel: for selection, 2 bits
         OV: overflow flag
------------------------------------------------------
History:
12-11-2015: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module greater_pipeline_test;
//defination for Variables
reg clk;
reg reset;

wire EN;
wire CLR;
wire[15:0] out_num;

wire r;

//Connection to the modules
counter16 C1(.clk(clk), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter(out_num));
greater_pipeling G1 (.a(out_num[15:8]), .b(out_num[7:0]),
   .CLK(clk), .RST(reset),.r(r));

begin
   
    assign EN = 1'b1;
    assign CLR = 1'b0;
  
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

/***********************************************
Module Name:   counter16
Feature:       16 bits counter
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
               EN: Enable signal to increase the counter
               CLR: Clear signal to make counter 0
Output Ports:  counter, 16 bits, result
------------------------------------------------------
History:
01-08-2016: First Version by Garfield
01-08-2016: Verified by Garfield with counter_test in Modelsim
***********************************************/

module counter16
  ( 
    input clk,
    input Reset,
    input EN,
    input CLR,
    output reg[15:0] counter
  );

//Defination for Varables in the module

//Logicals
//Combanitory logicals
always @ (posedge clk or Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 16'h0000;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 15'h0000;
    end
    else if(EN)
    //Enable signal to increase counter
    begin
        counter <= counter + 16'h01;
    end
    else
    //Idle statement
    begin
    end
end

endmodule