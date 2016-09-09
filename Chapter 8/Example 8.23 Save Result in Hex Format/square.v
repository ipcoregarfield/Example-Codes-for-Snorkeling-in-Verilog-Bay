/***********************************************
Module Name:   Square
Feature:       Output the square values of input
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   value, 6 bits, reset
Output Ports:  square, 12 bits, square of value
------------------------------------------------------
History:
03-01-2016: First Version by Garfield
03-01-2016: First verified by Square_test
***********************************************/

module square_cal
  ( 
    input[5:0] value,
    output[11:0] square
  );
  
  begin
      assign square = value * value;
  end
  endmodule