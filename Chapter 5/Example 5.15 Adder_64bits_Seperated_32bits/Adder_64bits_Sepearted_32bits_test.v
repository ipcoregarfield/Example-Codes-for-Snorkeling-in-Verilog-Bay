/***********************************************
Module Name:   Adder_64bits_Separated_32bits_test
Feature:       Testbench for adder_4bits_separated_32bits
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
01-07-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module adder_64bits_seperated_32bits_test;
//defination for Variables
reg clk;
reg reset;

reg[7:0] cntr;

wire EN;
wire CLR;
wire[127:0] out_num;
wire OV;

wire[63:0] sum;
wire c;

wire[63:0] sum_test;
wire c_test;

//Connection to the modules
counter128 C1(.clk(clk), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter(out_num), .OV(OV));
adder_64bits_seperated_32bits A1
              (.a(~out_num[63:0]), .b(~out_num[127:64]),
               .CLK(clk), .RST(reset),
               .sum(sum), .c(c));

begin

   	assign {c_test, sum_test} = {1'b0, ~out_num[63:0]} + {1'b0, ~out_num[127:64]};
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
    
//Couner as input
    always @(posedge clk or reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            cntr <= 8'h00;
        end
        else
        //Wroking, counter increasing
        begin
            cntr <= cntr + 8'h01;
        end
    end

end

endmodule

/***********************************************
Module Name:   counter128
Feature:       128 bits counter
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
               EN: Enable signal to increase the counter
               CLR: Clear signal to make counter 0
Output Ports:  counter, 128 bits, result
               OV: Overflow flag 
------------------------------------------------------
History:
03-20-2014: First Version by Garfield
03-20-2014: Verified by Garfield with counter_test in Modelsim
***********************************************/

module counter128
  ( 
    input clk,
    input Reset,
    input EN,
    input CLR,
    output reg[127:0] counter,
    output OV
  );

//Defination for Varables in the module
reg[127:0] old_counter;
//Stored counter for overflow judgement

//Logicals
//Combanitory logicals
assign OV = 1'b0; 

always @ (posedge clk or Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 128'h00;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 128'h00;
    end
    else if(EN)
    //Enable signal to increase counter
    begin
        counter <= counter + 128'h01;
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
        old_counter <= 128'h00;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 128'h00;
    end
    else
    //Idle statement record the counter
    begin
        old_counter <= counter;
    end
end
endmodule