/***********************************************
Module Name:   DFF_link_4_concatenation
Feature:       4 DFF Link with register array concatenation
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               input_data, 1 bit, input data 
Output Ports:  output_data, 1 bit, delayed input data
------------------------------------------------------
History:
12-28-2015: First Version by Garfield
12-28-2015: First verified by DFF_Link_4_Combination_test
***********************************************/

module DFF_link_4_concatenation
  ( 
    input CLK, input RST,
    input input_data,
 	  output output_data 
  );
  
//Load other module(s)

//Definition for Variables in the module
reg dff[3:0];

//Logical
assign output_data = dff[3];

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       {dff[0], dff[1], dff[2],dff[3]} <= 4'b0000;
    end
    else 
    begin
    	{dff[0], dff[1], dff[2],dff[3]} <= {input_data, dff[0], dff[1], dff[2]};
    end
end

endmodule