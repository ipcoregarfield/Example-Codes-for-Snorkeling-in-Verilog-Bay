/***********************************************
Module Name:   CORDIC_sin_0_90_test
Feature:       Testbench for CORDIC_sin_0_90
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         cntr: counter for the EN and CLRinput 
         
------------------------------------------------------
History:
12-20-2015: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module CORDIC_sin_0_90_test;
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
CORDIC_sin_0_90 CS (.CLK(clk), .RESET(reset), .address(cntr[6:0]),
                  .value(result));

assign test_vector = test_vector_monory[addr];
assign right = (test_vector == result);
assign addr = (cntr >= 9) ? ( cntr - 9): ( 64 - 8 +  cntr);

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
      $readmemh("CORDIC_sin_cos_test_vector_sin.txt",
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