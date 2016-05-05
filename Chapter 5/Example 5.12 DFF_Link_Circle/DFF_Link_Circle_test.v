/***********************************************
Module Name:  DFF_Link_Circle_test
Feature:       Testbench for DFF_Link_Circle
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag

         out_num, inputs, higher 4 bits for a and lower 4 bits for b
---------------------------------------------------
History:
12-28-2015: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module DFF_Link_Circle_test;
//defination for Variables
reg clk;
reg reset;


wire EN;
wire CLR;
wire[7:0] out_num;
wire OV;

wire[7:0] out;
wire wr;

//Connection to the modules
counter C1(.clk(clk), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter(out_num), .OV(OV));
DFF_link_4_circle D1 (.CLK(clk), .RST(reset),
                      .input_data(out_num), .WR(wr),
 	                    .output_data (out) );
  
 
    assign EN = 1'b1;
    assign CLR = 1'b0;
    assign wr = (out_num[7:2]==0)? (~out_num[2]): 1'b0;
  
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
    
endmodule

/***********************************************
Module Name:   counter
Feature:       8 bits counter
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
               EN: Enable signal to increase the counter
               CLR: Clear signal to make counter 0
Output Ports:  counter, 8 bits, result
               OV: Overflow flag 
------------------------------------------------------
History:
03-20-2014: First Version by Garfield
03-20-2014: Verified by Garfield with counter_test in Modelsim
***********************************************/

module counter
  ( 
    input clk,
    input Reset,
    input EN,
    input CLR,
    output reg[7:0] counter,
    output OV
  );

//Defination for Varables in the module
reg[7:0] old_counter;
//Stored counter for overflow judgement

//Logicals
//Combanitory logicals
assign OV = (counter == 8'h00) && (old_counter == 8'hff); 

always @ (posedge clk or Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 8'h00;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 8'h00;
    end
    else if(EN)
    //Enable signal to increase counter
    begin
        counter <= counter + 8'h01;
    end
    else
    //Idle statement
    begin
    end
end

always @ (posedge clk or Reset)
//Old counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        old_counter <= 8'h00;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 8'h00;
    end
    else
    //Idle statement record the counter
    begin
        old_counter <= counter;
    end
end
endmodule