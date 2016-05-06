/***********************************************
Module Name:   timer
Feature:       timer with constant counter 20 ms
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 2 ns period
               RST, 1 bit reset
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
    input RST,
    input start,
    output reg on
  );

//Defination for Varables in the module
`define NUMBER_20MS 100_000
//100,000 clock(period 200 ns) for 20 ms

reg[16:0] counter = 0;
//Logicals
//Combanitory logicals

always @ (posedge clk or negedge RST)
//Counter operations
begin
	 if (!RST)
	 begin
        on <= 1'b0;	 	
	 end
	 else
   begin
        on <= (counter != 0);
    end
end

always @ (posedge clk or negedge RST)
//Counter operations
begin
    if (!RST)
	  begin
        counter <= 1'b0;	 	
	  end
	  else if (start)
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