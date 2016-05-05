/***********************************************
Module Name:   DFF_link_4_circle
Feature:       4 DFF Link circled
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               input_data, 8 bits, input data 
               WR, 1 bit input avoidable flag
                      =1 avoid input
                      =0 output
Output Ports:  output_data, 8 bits, output data
------------------------------------------------------
History:
12-28-2015: First Version by Garfield
12-28-2015: First verified by DFF_Link_Circle_test
***********************************************/

module DFF_link_circle
  ( 
    input CLK, input RST,
    input[7:0] input_data, input WR,
 	  output[7:0] output_data 
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[7:0] dff[3:0];
integer loop;
reg old_wr;
//WR last clock period

//Logical
assign output_data = (WR|old_wr)? (8'h00): (dff[3]);
//WR = 1, then output constant 0
//old_wr = 1 and WR = 0, Hand-over between writing and reading 

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       for (loop = 0; loop <= 3; loop = loop + 1)
       begin
       	dff[loop] <= 8'h00;
       end
    end
    else
    begin
    	dff[0]<= (WR)? (input_data) : (dff[3]);
    	//WR = 1, input, else circling
    	for (loop = 1; loop <= 3; loop = loop + 1)
       begin
       	dff[loop] <= dff[loop - 1];
       end
    end
end

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
      old_wr <= 1'b0;
    end
    else 
    begin
    	old_wr <= WR;
    end
end

endmodule