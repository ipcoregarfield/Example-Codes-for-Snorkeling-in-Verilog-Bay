/***********************************************
Module Name:   Case_No_Full_test
Feature:       Testbench for Case_No_Full_CombinationalLogic
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

module Case_No_Full_CombinationalLogic_test;
//defination for Variables
reg clk;
reg reset;

reg[7:0] cntr;

wire EN;
wire CLR;
wire[7:0] out_num;
wire OV, OV1;
wire[1:0] sel;

wire[7:0] result;

//Connection to the modules
counter C1(.clk(clk), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter({out_num[1:0], out_num[7:2]} ), .OV(OV));
counter_2bits C2(.clk(clk), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter(sel), .OV(OV1));				 
case_no_full_CombinationalLogic C3  ( .number(out_num), .select(sel),
	                .result(result) 
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

/***********************************************
Module Name:   counter
Feature:       2 bits counter
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
               EN: Enable signal to increase the counter
               CLR: Clear signal to make counter 0
Output Ports:  counter, 2 bits, result
               OV: Overflow flag 
------------------------------------------------------
History:
03-20-2014: First Version by Garfield
03-20-2014: Verified by Garfield with counter_test in Modelsim
***********************************************/

module counter_2bits
  ( 
    input clk,
    input Reset,
    input EN,
    input CLR,
    output reg[1:0] counter,
    output OV
  );

//Defination for Varables in the module
reg[1:0] old_counter;
//Stored counter for overflow judgement

//Logicals
//Combanitory logicals
assign OV = (counter == 2'h0) && (old_counter == 2'h3); 

always @ (posedge clk or Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 2'h0;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 2'h200;
    end
    else if(EN)
    //Enable signal to increase counter
    begin
        counter <= counter + 2'h1;
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
        old_counter <= 2'h0;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 2'h0;
    end
    else
    //Idle statement record the counter
    begin
        old_counter <= counter;
    end
end
endmodule