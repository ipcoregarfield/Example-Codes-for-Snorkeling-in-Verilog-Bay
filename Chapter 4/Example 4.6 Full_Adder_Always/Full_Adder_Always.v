/***********************************************
Module Name:   Full_Adder_Always
Feature:       Full adder for 1 bit math add with always block
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0, a1, 1 bit, addends
               c0, 1 bit, carry bit from low bit
Output Ports:  s, 1 bit, sum
               c1, 1 bit, carry bit
------------------------------------------------------
History:
12-17-2015: First Version by Garfield
12-17-2015: Verified by Garfield with Full_Adder_test in ISE/Modelsim
***********************************************/

module full_adder_always 
  ( 
    input a0, a1,
    input c0,
    output reg s,
    output reg c1
  );

//Defination for Varables in the module
wire t1, t2, t3;
//Logicals
//Sum: 
always @(*)
begin
    s <= (a0 ^ a1) ^ c0;
end

//Carry bit: separate the equation into 3 independent parts in order to read
assign t1 = a0 & c0;
assign t2 = a1 & c0;
assign t3 = a0 & a1;

always @(*)
begin
    c1 <= (t1 | t2) | t3;
end

endmodule