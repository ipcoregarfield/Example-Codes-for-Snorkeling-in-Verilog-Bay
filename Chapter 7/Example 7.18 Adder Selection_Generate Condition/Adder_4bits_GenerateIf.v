/***********************************************
Module Name:   top_adder_4bits_generateif
Feature:       4 bits adder in combined or pipeline structure 
               which is selsected by generate
               Two adders in with 200 MHz clock and 50 MHz clock
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 4 bits, operent
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  sum1, sum2, 4 bits, sum
               c1,c2, 1 bit, carry bit
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by Adder_4bits_generateif_test  ISE/Modelsim
***********************************************/
`define FREQUENCY1 200
`define FREQUENCY2 50
//If CLOCK_FREQUENCY is greater than HIGH_SPEED,
//the adder should be designed in pipeline

module top_adder_4bits_generateif
//Clock frequency in unit of MHz
  ( 
    input[3:0] a, b,
    input CLK1, CLK2, input RST,
    output[3:0] sum1, sum2,
    output c1, c2
  );
//Load other module(s)
adder_4bits_generateif #(.CLOCK_FREQNENCY(`FREQUENCY1) )      
A1 ( .a(a), .b(b),.CLK(CLK1), .RST(RST), .sum(sum1), .c(c1));

adder_4bits_generateif #(.CLOCK_FREQNENCY(`FREQUENCY2) )     
A2 ( .a(a), .b(b),.CLK(CLK2), .RST(RST), .sum(sum2), .c(c2));
//Definition for Variables in the module

//Logical
endmodule

/***********************************************
Module Name:   adder_4bits_generateif
Feature:       4 bits adder in combined or pipeline structure 
               which is selsected by generate
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 4 bits, operent
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  sum, 4 bits, sum
               c, 1 bit, carry bit
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by Adder_4bits_generateif_test  ISE/Modelsim
***********************************************/
`define HIGH_SPEED  150
//If CLOCK_FREQUENCY is greater than HIGH_SPEED,
//the adder should be designed in pipeline

module adder_4bits_generateif
#(parameter CLOCK_FREQNENCY = 100)
//Clock frequency in unit of MHz
  ( 
    input[3:0] a, b,
    input CLK, input RST,
    output[3:0] sum,
    output c
  );
//Load other module(s)
generate
begin
    if ( CLOCK_FREQNENCY > `HIGH_SPEED)
    begin
        adder_4bits_pipeline pipeline( .a(a), .b(b),
                       .CLK(CLK), .RST(RST),
                       .sum(sum), .c(c));
    end
    else
    begin
        adder_4bits combine(.a(a), .b(b),
                       .sum(sum), .c(c));        
    end
end
endgenerate

//Definition for Variables in the module

//Logical
endmodule