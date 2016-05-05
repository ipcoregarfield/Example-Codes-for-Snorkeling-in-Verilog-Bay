/***********************************************
Module Name:   adder_64bits_seperated_32bits
Feature:       64 bits adder by two 32 bits adders in pipeline structure
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 64 bits, operent
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  sum, 64 bits, sum
               c, 1 bit, carry bit
------------------------------------------------------
History:
01-07-2016: First Version by Garfield
01-07-2016: First verified by Adder_4bits_Sepearted_32bits_test  ISE/Modelsim
***********************************************/

module adder_64bits_seperated_32bits
  ( 
    input[63:0] a, b,
    input CLK, input RST,
    output reg[63:0] sum,
    output reg c
  );

//Definition for Variables in the module
reg[31:0] a0, b0;
//Input value delays
reg c0;
//First adder result delay: carry bit
reg[31:0] s0;
//First adder result delay: result

wire [32:0] s1;

//Load other module(s)

//Logical
assign s1 = {1'b0, a0} + {1'b0, b0} + {32'h0000_0000,c0};

always @(posedge CLK or negedge RST)
//Input delay
begin
    if (!RST)
    //Reset
    begin
        a0 <= 32'h0000_0000;
        b0 <= 32'h0000_0000;
    end
    else
    begin
        a0 <= a[63:32];
        b0 <= b[63:32];
    end
end

always @(posedge CLK or negedge RST)
//First adder
begin
    if (!RST)
    //Reset
    begin
        c0 <= 1'b0;
        s0 <= 32'h0000_0000;
    end
    else
    begin
        {c0, s0} <= a[31:0] + b[31:0];
    end
end

always @(posedge CLK or negedge RST)
//Second adder
begin
    if (!RST)
    //Reset
    begin
        c <= 1'b0;
        sum <= 32'h0000_0000;
    end
    else
    begin
        c <= s1[32];
        sum <= {s1[31:0], s0};
    end
end

endmodule