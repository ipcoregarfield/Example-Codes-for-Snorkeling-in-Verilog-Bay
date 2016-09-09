/***********************************************
Module Name:   counter_parameter
Feature:       Counter with parameter bit_width and max_value
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   clk, 1 bit,clk
               RST, 1 bit, reset
Output Ports:  counter, bit width defined by parameter WIDTH,
                        counter value
Parameters:    WIDTH, bit width
               MAX_VALUE, maximum couter value
------------------------------------------------------
History:
02-03-2016: First Version by Garfield
02-04-2016: First verified by Counter_Parameter_test
***********************************************/
module counter_parameter
#(parameter WIDTH = 8,
//Bit width for output
MAX_VALUE = 200)
//Maximun value for counter)
  ( 
    input clk, RST,
    output reg[WIDTH - 1:0] counter
  );

  
//Load other module(s)

//Definition for Variables in the module

//Logic
always @(posedge clk or negedge RST)
begin
    if (!RST)
    begin
        counter <= 1'h0;
    end
    else if (counter < MAX_VALUE)
    begin
       counter <= counter + 1'h1;    	
    end
    else
    begin
       counter <= 1'h0;    	
    end
end
endmodule