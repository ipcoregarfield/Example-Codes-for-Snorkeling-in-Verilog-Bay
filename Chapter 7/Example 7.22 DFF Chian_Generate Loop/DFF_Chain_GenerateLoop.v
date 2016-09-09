/***********************************************
Module Name:   top_DFF_chain_generate
Feature:       DFF delay chain with parameter #delay_tap
               Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   in, 1 bits, input
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  delayed1, delayed2, 1 bits, delayed outputs
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by DFF_chain_generate_test  ISE/Modelsim
***********************************************/
module top_DFF_chain_generate
//Clock frequency in unit of MHz
  ( 
    input in,
    input CLK, input RST,
    output delayed1, delayed2
  );
localparam TAP1 = 5, TAP2 = 7;
//Delay #tap

//Load other module(s)
DFF_chain_generate #(.TAP(TAP1)) D1(.in(in),
             .CLK(CLK), .RST(RST),
             .delayed(delayed1) );
             
DFF_chain_generate #(.TAP(TAP2)) D2(.in(in),
             .CLK(CLK), .RST(RST),
             .delayed(delayed2) );             
//Definition for Variables in the module

endmodule

/***********************************************
Module Name:   DFF_chain_generate
Feature:       DFF delay chain with parameter #delay_tap
               Generate DFF elements in seperated always blocks
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   in, 1 bits, input
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  delayed, 1 bits, delayed output
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by DFF_chain_generate_test  ISE/Modelsim
***********************************************/
module DFF_chain_generate
//Clock frequency in unit of MHz
  ( 
    input in,
    input CLK, input RST,
    output delayed
  );
parameter TAP = 3;
//Delay #tap
//Load other module(s)

//Definition for Variables in the module

reg[TAP - 1 : 0] D;
//DFF for delay

//Logical
assign delayed = D[TAP - 1];
//Assigned the output

always @(posedge CLK or negedge RST)
begin
    if (!RST)
    //Reset
    begin
        D[0] <= 1'h0;
    end
    else
    //Working
    begin
        D[0] <= in;
    end
end

generate 
 //Genarate delay chain
genvar loop; 
for (loop = 1; loop < TAP; loop = loop + 1)
begin: delay
    always @(posedge CLK or negedge RST)
    begin
        if (!RST)
        //Reset
        begin
            D[loop] <= 1'h0;
        end
        else
        //Working
        begin
            D[loop] <= D[loop - 1];
        end
    end
end
endgenerate

endmodule