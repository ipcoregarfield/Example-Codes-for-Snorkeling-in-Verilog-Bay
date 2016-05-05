/***********************************************
Module Name:   counter
Feature:       Counter
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               enable, 8 bits, input data to be added, unsiged
                     one void value in one clock
Output Ports:  counter, 8 bits, counter value, unsigned
                        increase 1 when enable = 1
               over_flow_flag, is 1 when counter value over flowing
------------------------------------------------------
History:
12-24-2015: First Version by Garfield
12-24-2015: First verified by Counter_test
***********************************************/

module counter
  ( 
    input CLK, input RST,
    input enable,
    output reg[7:0] counter,
	  output reg overflow_flag 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       {overflow_flag, counter} <= 9'h000;
    end
    else if (overflow_flag)
    //Over flew and reset
    begin
        {overflow_flag, counter} <= 9'h000;
    end
    else if(enable)
    //Counter enabled
    begin
    	{overflow_flag, counter} <= {overflow_flag, counter} + 9'h001;
    end
end

endmodule