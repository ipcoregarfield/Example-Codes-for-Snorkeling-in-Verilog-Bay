/***********************************************
Module Name:   Wait
Feature:       Show the wait aaplication
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         enable: enable flag
         a, b, c, d, testee
------------------------------------------------------
History:
02-17-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/10 ps
//Simulation time assignment

//Insert the modules

module wait_;
//definition for Variables
reg enable, enable_1;

reg[7:0] a, c, a_1, c_1;
wire[7:0] b, d;

assign b = 8'h07;
assign d = 8'h55;

//Generate enable flag with delay #
    initial
    begin
      enable = 1'b0;
      
      #3 enable = 1'b1;
      //After 30 ns, assigned again
      
      #15 enable = 1'b0;
      //After 150 ns, reset
    end
    
//wait 
    initial
    begin
      wait(enable)
      begin
          #10 a = b;
      end
      #10 c = d;
    end    

//Generate enable flag with delay #
    initial
    begin
      enable_1 = 1'b1;
      
      #3 enable_1 = 1'b0;
      //After 30 ns, assigned again
      
      #15 enable_1 = 1'b1;
      //After 150 ns, reset
    end
    
//wait 
    initial
    begin
      wait(enable_1)
      begin
          #10 a_1 = b;
      end
      #10 c_1 = d;
    end   
endmodule
