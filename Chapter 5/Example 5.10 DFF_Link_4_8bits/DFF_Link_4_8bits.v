/***********************************************
Module Name:   DFF_link_4_8bits
Feature:       4 DFF Link with 'for' loop, 8 bits input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               input_data, 8 bits, input data 
Output Ports:  output_data, 8 bits, delayed input data
------------------------------------------------------
History:
12-28-2015: First Version by Garfield
12-28-2015: First verified by DFF_Link_4_8bits_test
***********************************************/

module DFF_link_4_8bits
  ( 
    input CLK, input RST,
    input[7:0] input_data,
 	  output[7:0] output_data 
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[7:0] dff[3:0];
integer loop;

//Logical
assign output_data = dff[3];

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       for (loop = 0; loop <= 3; loop = loop + 1)
       begin
       	dff[loop] <= 8'b0;
       end
    end
    else 
    begin
    	dff[0]<= input_data;
    	for (loop = 1; loop <= 3; loop = loop + 1)
       begin
       	dff[loop] <= dff[loop - 1];
       end
    end
end

endmodule