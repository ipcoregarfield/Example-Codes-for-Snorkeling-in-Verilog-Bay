/***********************************************
Module Name:   variable_shift_1bit
Feature:       Shift operation with various bit with time_multiple
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit clock, 200 ns period
               RST, 1 bit, reset
               a, 8 bit, operent
               shift_width, 3 bits, shift bit nymber
               data_start, 1 bit,data start flag, a clock before data avaiable
Output Ports:  shifted_a, 8 bits, result as a << shift_width
------------------------------------------------------
History:
01-25-2016: First Version by Garfield
01-25-2016: First verified by variable_shift_1bit_test  ISE/Modelsim
***********************************************/

module variable_shift_1bit
  ( 
    input CLK, input RST,
    input[7:0] a,
    input[2:0] shift_width,
    input data_start,
    output reg[7:0] shifted_a
  );

//Definition for Variables in the module
reg[2:0] counter;
//Control counter

//Load other module(s)
                
//Logical
always @(posedge CLK or negedge RST)
//Shift chain
begin
   if (!RST)
   //Reset
   begin
       shifted_a <= 8'h1;
   end
   else if ( counter == 0)
   //Sampling
   begin 
       shifted_a <= a;
   end
   else if ( counter <= shift_width)
   //Shifting
   begin 
       shifted_a <= shifted_a << 1;
   end
   else 
   //Others
   begin 
   end
end

always @(posedge CLK or negedge RST)
//Counter
begin
   if (!RST)
   begin
       counter <= 8'h0;
   end
   else if (data_start)
   begin
       counter <= 3'h0;
   end
   else
   begin
       counter <= counter + 3'h1;
   end
end


endmodule