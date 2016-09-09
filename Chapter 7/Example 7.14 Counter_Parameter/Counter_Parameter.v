/***********************************************
Module Name:   top_counter_parameter
Feature:       Three counters with different parameter assignment methods
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   clk, 1 bit,clk
               RST, 1 bit, reset
Output Ports:  counter1, bit width defined by parameter WIDTH,
                        counter value for counter1 without parameter assigned
               counter2, bit width defined by parameter WIDTH,
                        counter value for counter2 with parameter assigned 
               counter3, bit width defined by parameter WIDTH,
                        counter value for counter3 with parameter assigned                                                
------------------------------------------------------
History:
02-04-2016: First Version by Garfield
02-04-2016: First verified by Counter_Parameter_test
***********************************************/
`define WIDTH_1 8
`define WIDTH_2 4
`define WIDTH_3 3
//Bit width for different sub modules

`define MAX_1 200
`define MAX_2 13
`define MAX_3 5
//Bit width for different sub modules

module top_counter_parameter
  ( 
    input clk, RST,
    output[`WIDTH_1 - 1:0] counter1,
    output[`WIDTH_2 - 1:0] counter2,
    output[`WIDTH_3 - 1:0] counter3       
  );
//Load other module(s)
counter_parameter C1(.clk(clk), .RST(RST), .counter(counter1));
counter_parameter C2(.clk(clk), .RST(RST), .counter(counter2));
    defparam  C2.WIDTH = `WIDTH_2, C2.MAX_VALUE = `MAX_2;
counter_parameter #(.WIDTH(`WIDTH_3), .MAX_VALUE(`MAX_3))
                  C3(.clk(clk), .RST(RST), .counter(counter3));
//Definition for Variables in the module

//Logic
endmodule

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