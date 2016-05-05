/***********************************************
Module Name:   Timer_test
Feature:       Testbench for Timer
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

module timer_test;
//defination for Variables
reg clk;
reg reset;
reg reset_1;

reg[7:0] circle;
reg start;
wire over;


//Connection to the modules
timer T1 ( 
    .CLK(clk), .RST(reset),
    .timer_circle(circle),
	  .start_flag(start),
    .timer_over(over)
                  );

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
    
    initial  
    begin
      reset_1 = 0;
      //Reset enable
      #35  reset_1 = 1;
     //Counter starts
    end
    
//Couner as input
    always @(posedge clk or reset_1)
    begin
        if ( !reset_1)
        //reset statement: counter keeps at 0
        begin
            start <= 1'b1;
        end
        else
        //Wroking, counter increasing
        begin
            start <= over;
        end
    end

    always @(clk)
    begin
        circle <= $random();
    end
    
end
endmodule