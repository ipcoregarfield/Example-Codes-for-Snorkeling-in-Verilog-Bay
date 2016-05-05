/***********************************************
Module Name:   DFF_link_4_combination
Feature:       4 DFF Link with register array combined
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

module DFF_link_4_combination
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
       dff[0] <= 1'b0;
       dff[1] <= 1'b0;
       dff[2] <= 1'b0;
       dff[3] <= 1'b0;
    end
    else 
    begin
    	dff[0] <= input_data;
    	dff[1] <= dff[0];
    	dff[2] <= dff[1];
    	dff[3] <= dff[2];
    end
end

endmodule