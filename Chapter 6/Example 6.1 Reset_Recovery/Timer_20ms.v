/***********************************************
Module Name:   timer
Feature:       timer with constant counter 20 ms
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 2 ns period
               start, timer start flag, high level avaiable
Output Ports:  timer_on, high if time is on counter
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: Verified by Garfield with Reset_Recovery_test in Modelsim
***********************************************/

module timer_20ms
  ( 
    input clk,
    input start,
    output reg on
  );

//Defination for Varables in the module
`define NUMBER_20MS 100_000
//100,000 clock(period 200 ns) for 20 ms

reg[16:0] counter = 0;
//Logicals
//Combanitory logicals

always @ (posedge clk)
//Counter operations
begin
   begin
        on <= (counter != 0);
    end
end

always @ (posedge clk)
//Counter operations
begin
    if (start)
    begin
        counter <= `NUMBER_20MS;
    end
    else if (counter != 0)
    begin
        counter <= counter - 1'b1;
    end
    else
    begin
    end
end

endmodule