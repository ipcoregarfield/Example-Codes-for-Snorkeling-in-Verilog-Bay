/***********************************************
Module Name:   variable_shift_mux
Feature:       Shift operation with various bit with mux selection
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, 8 bit, operent
               shift_width, 3 bits, shift bit nymber
Output Ports:  shifted_a, 8 bits, result as a << shift_width
------------------------------------------------------
History:
01-25-2016: First Version by Garfield
01-25-2016: First verified by variable_shift_mux_test  ISE/Modelsim
***********************************************/

module variable_shift_mux
  ( 
    input[7:0] a,
    input[2:0] shift_width,
    output reg[7:0] shifted_a
  );

//Definition for Variables in the module

//Load other module(s)
                
//Logical

always @(*)
//First element in input signal D-chain
begin
   case(shift_width)
   3'h0: 
   begin
       shifted_a <= a << 0;
   end
   
   3'h1: 
   begin
       shifted_a <= a << 1;
   end
      
   3'h2: 
   begin
       shifted_a <= a << 2;
   end
      
   3'h3: 
   begin
       shifted_a <= a << 3;
   end
      
   3'h4: 
   begin
       shifted_a <= a << 4;
   end
      
   3'h5: 
   begin
       shifted_a <= a << 5;
   end
      
   3'h6: 
   begin
       shifted_a <= a << 6;
   end
      
   3'h7: 
   begin
       shifted_a <= a << 7;
   end
   endcase
end
endmodule