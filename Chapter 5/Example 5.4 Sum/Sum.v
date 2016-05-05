/***********************************************
Module Name:   sum
Feature:       Accumulator of unsigned numbers
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               data, 8 bits, input data to be added, unsiged
                     one void value in one clock
Output Ports:  sum, 16 bits, summary, unsigned
               over_flow_flag, is 1 when summary over flowing
------------------------------------------------------
History:
12-24-2015: First Version by Garfield
12-24-2015: First verified by Sum_test
***********************************************/

module sum
  ( 
    input CLK, input RST,
    input[7:0] data,
    output reg[15:0]sum,
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
       {overflow_flag, sum} <= 17'h0_0000;
    end
    else if (overflow_flag)
    //Over flew and reset
    begin
        {overflow_flag, sum} <= 17'h0_0000;
    end
    else 
    //Data comes
    begin
    	{overflow_flag, sum} <= {overflow_flag, sum} + {9'h000, data};
    end
end

endmodule