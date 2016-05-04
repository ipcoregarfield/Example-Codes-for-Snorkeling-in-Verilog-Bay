/***********************************************
Module Name:   decode_2_4
Feature:       2-4 decoder
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   s1,s2, s3, s4 1 bits, inputs
Output Ports:  decode, 2 bits, 
               when {s4, s3, s2, s1} = 1???: 11
					when {s4, s3, s2, s1} = 01??: 10
					when {s4, s3, s2, s1} = 001?: 01
					when {s4, s3, s2, s1} = 0001/0000: 00
					legal, 1bit, 
					when {s4, s3, s2, s1} = 0000: 0
					else 1
------------------------------------------------------
History:
12-15-2015: First Version by Garfield
12-15-2015: First verified by Decode_2_4_test
***********************************************/

module decode_2_4
  ( 
    input s1, s2, s3, s4,
	 output[1:0] decode,
    output legal 
  );
  
//Load other module(s)

//Definition for Variables in the module
wire[1:0] dec1;
wire[1:0] dec2;
wire[1:0] dec3;
//Middle result of selector

//Logical
assign dec1 = 2'b00;
assign dec2 = (s2) ? 2'b01 : dec1;
assign dec3 = (s3) ? 2'b10 : dec2;
assign decode = (s4) ? 2'b11 : dec3;

assign legal = |({s4, s3, s2, s1});
//1 when not all 0

endmodule