/***********************************************
Module Name:   Abs_test
Feature:       Testbench for Abs
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
         out_num: output port for the counter module 
         OV: overflow flag
------------------------------------------------------
History:
12-18-2015: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module line_sin_0_90_test;
//defination for Variables
reg clk;
reg reset;

reg[7:0] cntr;

wire[6:0] result;

reg[6:0] test_vector_monory[64:0];
wire[6:0] test_vector;
//Test Vector Value

wire[7:0] addr;
//Address of test vectors

wire right;
//Results right?

//Connection to the modules
line_sin_0_90 LS (.CLK(clk), .RESET(reset), .address(cntr[6:0]),
                  .value(result));

assign test_vector = test_vector_monory[addr];
assign right = (test_vector == result);
assign addr = (cntr >= 3) ? ( cntr - 3): ( 64 - 3 +  cntr);

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

//Load the test vectors
    initial  
    begin
      $readmemh("sin2line_test_vector_2016_3_13_17_3_10.txt",
                  test_vector_monory);
    end
        
//Couner as input
    always @(posedge clk or reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            cntr <= 8'h00;
        end
        else if(cntr == 8'h40)
        begin
            cntr <= 8'h00;
        end
        else
        //Wroking, counter increasing
        begin
            cntr <= cntr + 8'h01;
        end
    end

endmodule