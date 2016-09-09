/***********************************************
Module Name:   top_adder_4bits_generatecase
Feature:       4 bits adder in combined or pipeline structure 
               which is selsected by generate
               Three adders in with 200 MHz clock and 50 MHz clock
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
02-05-2016: First verified by Adder_4bits_generatecase_test  ISE/Modelsim
***********************************************/
`define FREQUENCY1 200
`define FREQUENCY2 50
//If CLOCK_FREQUENCY is greater than HIGH_SPEED,
//the adder should be designed in pipeline

module top_adder_4bits_generatecase
//Clock frequency in unit of MHz
  ( 
    input[3:0] a, b,
    input CLK1, CLK2, input RST,
    output[3:0] sum_HH, sum_HL, sum_LH, sum_LL,
    output c_HH, c_HL, c_LH, c_LL
  );
//Load other module(s)
adder_4bits_generatecase #(.CLOCK_FREQNENCY(`FREQUENCY1), .HIGH_CHIP(1) )      
A_HH ( .a(a), .b(b),.CLK(CLK1), .RST(RST), .sum(sum_HH), .c(c_HH));

adder_4bits_generatecase #(.CLOCK_FREQNENCY(`FREQUENCY1), .HIGH_CHIP(0) )      
A_HL ( .a(a), .b(b),.CLK(CLK1), .RST(RST), .sum(sum_HL), .c(c_HL));

adder_4bits_generatecase #(.CLOCK_FREQNENCY(`FREQUENCY2), .HIGH_CHIP(1) )     
A_LH ( .a(a), .b(b),.CLK(CLK2), .RST(RST), .sum(sum_LH), .c(c_LH));

adder_4bits_generatecase #(.CLOCK_FREQNENCY(`FREQUENCY2), .HIGH_CHIP(0) )     
A_LL ( .a(a), .b(b),.CLK(CLK2), .RST(RST), .sum(sum_LL), .c(c_LL));
//Definition for Variables in the module

//Logical
endmodule

/***********************************************
Module Name:   adder_4bits_generatecase
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

module adder_4bits_generatecase
//Clock frequency in unit of MHz
  ( 
    input[3:0] a, b,
    input CLK, input RST,
    output[3:0] sum,
    output c
  );
parameter[8:0] CLOCK_FREQNENCY = 100;
parameter[0:0] HIGH_CHIP = 0;
localparam[0:0] HIGH_CLOCK = (CLOCK_FREQNENCY > `HIGH_SPEED);
//Load other module(s)
generate
begin
    case ( {HIGH_CLOCK , HIGH_CHIP} )
    2'b11:
    //High clock frequency or low quality chip
    //Pipeline select
    begin
        adder_4bits_pipeline pipeline( .a(a), .b(b),
                       .CLK(CLK), .RST(RST),
                       .sum(sum), .c(c));
    end
    
    2'b10:
    //Low quality chips,pipeline selected
    begin
        adder_4bits_pipeline pipeline( .a(a), .b(b),
                       .CLK(CLK), .RST(RST),
                       .sum(sum), .c(c));        
    end    
    
    2'b00:
    //Low quality chips, pipeline selected
    begin
        adder_4bits_pipeline pipeline( .a(a), .b(b),
                       .CLK(CLK), .RST(RST),
                       .sum(sum), .c(c));        
    end
    
   
    2'b01:
    //others. combined logic
    begin
        adder_4bits combine(.a(a), .b(b),
                       .sum(sum), .c(c));        
    end
    
  endcase
end
endgenerate

//Definition for Variables in the module

//Logical
endmodule