/***********************************************
Module Name:   adder_4bits_pipeline
Feature:       4 bits adder in chain and pipeline structure
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
01-07-2016: First Version by Garfield
01-07-2016: First verified by Adder_4bits_Pipeline_test  ISE/Modelsim
***********************************************/

module adder_4bits_pipeline
  ( 
    input[3:0] a, b,
    input CLK, input RST,
    output[3:0] sum,
    output  c
  );

//Definition for Variables in the module
reg[2:0] i_a1, i_b1;
reg[1:0] i_a2, i_b2;
reg i_a3, i_b3;
//Operents D-chain

reg D_c0, D_c1, D_c2; //Delayed carry bits within the D-chain

reg o_s0;
reg[1:0] o_s1;
reg [2:0] o_s2;
//Summary D-Chain

wire s0, s1, s2, s3;
wire c0, c1, c2, c3;
//Output of adders 

//Load other module(s)
half_adder H0( .a0(a[0]), .a1(b[0]), .s(s0), .c1(c0) );
full_adder F1( .a0(i_a1[0]), .a1(i_b1[0]), .c0(D_c0), .s(s1), .c1(c1) );
full_adder F2( .a0(i_a2[0]), .a1(i_b2[0]), .c0(D_c1), .s(s2), .c1(c2) );
full_adder F3( .a0(i_a3), .a1(i_b3), .c0(D_c2), .s(s3), .c1(c) );
//Connections for adders

//Logical
assign sum = {s3, o_s2};
//Output value concatenation

always @(posedge CLK or negedge RST)
//First element in input signal D-chain
begin
    if (!RST)
    //Reset
    begin
    	i_a1 <= 3'b000;
    	i_b1 <= 3'b000;
    end
    else
    begin
    	i_a1 <= a[3:1];
    	i_b1 <= b[3:1];
    end
end

always @(posedge CLK or negedge RST)
//Second element in input signal D-chain
begin
    if (!RST)
    //Reset
    begin
    	i_a2 <= 2'b00;
    	i_b2 <= 2'b00;
    end
    else
    begin
    	i_a2 <= i_a1[2:1];
    	i_b2 <= i_b1[2:1];
    end
end

always @(posedge CLK or negedge RST)
//Third element in input signal D-chain
begin
    if (!RST)
    //Reset
    begin
    	i_a3 <= 1'b0;
    	i_b3 <= 1'b0;
    end
    else
    begin
    	i_a3 <= i_a2[1];
    	i_b3 <= i_b2[1];
    end
end

always @(posedge CLK or negedge RST)
//Delay for carry bits 
begin
    if (!RST)
    //Reset
    begin
    	D_c0 <= 1'b0;
    	D_c1 <= 1'b0;
    	D_c2 <= 1'b0;
    end
    else
    begin
    	D_c0 <= c0;
    	D_c1 <= c1;
    	D_c2 <= c2;
    end
end

always @(posedge CLK or negedge RST)
//Result value in D-chain 
begin
    if (!RST)
    //Reset
    begin
    	o_s0 <= 1'b0;
    	o_s1 <= 2'b00;
    	o_s2 <= 3'b000;
    end
    else
    begin
    	o_s0 <= s0;
    	o_s1 <= {s1, o_s0};
    	o_s2 <= {s2, o_s1};
    end
end

endmodule