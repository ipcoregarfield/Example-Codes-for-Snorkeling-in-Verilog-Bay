/***********************************************
Module Name:   variable_shift_1bit
Feature:       Shift operation with various bit with time_multiply
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
reg[7:0] a1, a2, a3, a4, a5, a6, a7;
wire[7:0] a0;
//Shifty chain
reg[2:0] counter;
//Control counter
reg[7:0] shifted_a_NoDelay;
//Sample at the moment

//Load other module(s)
                
//Logical
assign a0 = a;

always @(posedge CLK or negedge RST)
//Shift chain
begin
   if (!RST)
   begin
       a1 <= 8'h0;
       a2 <= 8'h0;
       a3 <= 8'h0;
       a4 <= 8'h0;
       a5 <= 8'h0;
       a6 <= 8'h0;
       a7 <= 8'h0;
   end
   else
   begin
       a1 <= a0 << 1;
       a2 <= a1 << 1;
       a3 <= a2 << 1;
       a4 <= a3 << 1;
       a5 <= a4 << 1;
       a6 <= a5 << 1;
       a7 <= a6 << 1;
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

always @(posedge CLK or negedge RST)
//Sample
begin
   if (!RST)
   begin
       shifted_a_NoDelay <= 8'h0;
   end
   else if (counter == shift_width)
   begin
       case (shift_width)
       0:
       begin
           shifted_a_NoDelay <= a0;
       end
       
       1:
       begin
           shifted_a_NoDelay <= a1;
       end

       2:
       begin
           shifted_a_NoDelay <= a2;
       end
       
       3:
       begin
           shifted_a_NoDelay <= a3;
       end

       4:
       begin
           shifted_a_NoDelay <= a4;
       end
       
       5:
       begin
           shifted_a_NoDelay <= a5;
       end

       6:
       begin
           shifted_a_NoDelay <= a6;
       end
       
       7:
       begin
           shifted_a_NoDelay <= a7;
       end
      endcase
   end
end

always @(posedge CLK or negedge RST)
//Final result
begin
   if (!RST)
   begin
       shifted_a <= 8'h0;
   end
   else if (counter == 8'h0)
   begin
       shifted_a <= shifted_a_NoDelay;
   end
end
 
endmodule