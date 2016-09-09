/***********************************************
Module Name:   counter_unconnected
Feature:       8 bits counter, show line applicatiom
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
02-20-2016: First Version by Garfield
***********************************************/

module counter_line
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
wire error;
//Error signal to display

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

`line 100  "counter_line_error_here.v" 1
always @ (clk)
//Error here
begin
    error = 1'b1;
end

`include "error.v"

endmodule