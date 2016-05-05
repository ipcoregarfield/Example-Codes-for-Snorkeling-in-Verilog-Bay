/***********************************************
Module Name:   Greater_Pipeline
Feature:       8 bits greater 
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, b, 8 bits, operent
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  r, 1 bit, 1, a > b
                         0, a <= b
------------------------------------------------------
History:
01-08-2016: First Version by Garfield
01-08-2016: First verified by Greater_Pipeline_test  ISE/Modelsim
***********************************************/

module greater_pipeling
  ( 
    input[7:0] a, b,
    input CLK, input RST,
    output reg r
  );

//Definition for Variables in the module
reg[6:0] a1, b1;
reg[5:0] a2, b2;
reg[4:0] a3, b3;
reg[3:0] a4, b4;
reg[2:0] a5, b5;
reg[1:0] a6, b6;
reg a7, b7;
//Input value delays
reg r1, r2, r3, r4, r5, r6, r7;
//Comparison D-chain

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Input delay
begin
    if (!RST)
    //Reset
    begin
        a1 <= 7'h00;
        b1 <= 7'h00;
        
        a2 <= 6'h00;
        b2 <= 6'h00;
        
        a3 <= 5'h00;
        b3 <= 5'h00; 
        
        a4 <= 4'h0;
        b4 <= 4'h0;  
        
        a5 <= 3'h0;
        b5 <= 3'h0;
        
        a6 <= 2'h0;
        b6 <= 2'h0;  
        
        a7 <= 1'h0;
        b7 <= 1'h0;                                       
    end
    else
    begin
        a1 <= a[7:1];
        b1 <= b[7:1];
        
        a2 <= a1[6:1];
        b2 <= b1[6:1];
        
        a3 <= a2[5:1];
        b3 <= b2[5:1]; 
        
        a4 <= a3[4:1];
        b4 <= b3[4:1];  
        
        a5 <= a4[3:1];
        b5 <= b4[3:1];
        
        a6 <= a5[2:1];
        b6 <= b5[2:1];  
        
        a7 <= a6[1];
        b7 <= b6[1];
    end
end

always @(posedge CLK or negedge RST)
//Result chain
begin
    if (!RST)
    //Reset
    begin
        r1 <= 1'b0;
        r2 <= 1'b0; 
        r3 <= 1'b0;
        r4 <= 1'b0; 
        r5 <= 1'b0;
        r6 <= 1'b0; 
        r7 <= 1'b0;
        r <= 1'b0;
    end
    else
    begin
        r1 <= (a[0] == 1'b1) && (b[0] == 1'b1);
        r2 <= (a1[0] == b1[0])?(r1):(a1[0]); 
        r3 <= (a2[0] == b2[0])?(r2):(a2[0]);
        r4 <= (a3[0] == b3[0])?(r3):(a3[0]); 
        r5 <= (a4[0] == b4[0])?(r4):(a4[0]);
        r6 <= (a5[0] == b5[0])?(r5):(a5[0]); 
        r7 <= (a6[0] == b6[0])?(r6):(a6[0]);
        r <=(a7 == b7)?(r7):(a7);
    end
end

endmodule