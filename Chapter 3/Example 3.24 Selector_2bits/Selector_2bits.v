/***********************************************
Module Name:   selector_2bits
Feature:       Slector with 2 bits select (4 conditions)
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   Number1,Number2, Number3, Number4 8 bits, operents
               Select, 2 bits, select_flag
Output Ports:  Result, 8 bits, 
               when select = 2'b00: Number1
					     when select = 2'b01: Number2
					     when select = 2'b10: Number3
					     when select = 2'b11: Number4
------------------------------------------------------
History:
12-14-2015: First Version by Garfield
12-14-2015: First verified by Selector_2bits_test
***********************************************/

module selector_2bits
  ( 
    input[7:0] number1, number2, number3, number4,
	 input[1:0] select,
    output[7:0] result 
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logical
assign result = (select[1]) ? ( (select[0]) ? number4 : number3 )
                     : ( (select[0]) ? number2 : number1 );

endmodule