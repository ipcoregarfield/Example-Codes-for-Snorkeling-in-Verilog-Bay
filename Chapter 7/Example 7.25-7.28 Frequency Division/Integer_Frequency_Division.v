/***********************************************
Module Name:   int_FreqDiv
Feature:       Integer frequency division
               Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK_in, 1bit clock
               RST, 1 bit, reset
               SYNC, 1 bit, synchronization flag,
                     CLK_out forced a positive edge after it's posedge
Output Ports:  CLK_out, Divided Clock
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by int_FreqDiv_test  ISE/Modelsim
***********************************************/
module  int_FreqDiv #(parameter DIV = 2)
//DIV: factor for frequency division
 ( 
    input CLK_in, RST, SYNC,
    output CLK_out
  );
//Definition for Variables in the module

//Load other module(s)
generate
begin
    if ( DIV <= 1)
    //No division at all
    begin
        assign CLK_out = RST && CLK_in;
    end
    else
    begin
        int_FreqDiv_G1 #(.DIV(DIV)) I_G1(.CLK_in(CLK_in), .RST(RST), .SYNC(SYNC), .CLK_out(CLK_out));
    end
end
endgenerate

//Logic   
endmodule