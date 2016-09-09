/***********************************************
Module Name:   FreqDiv
Feature:       Frequency division
               Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK_in, 1bit clock
               RST, 1 bit, reset
Output Ports:  CLK_out, Divided Clock
------------------------------------------------------
History:
02-06-2016: First Version by Garfield
02-06-2016: First verified by FreqDiv_test  ISE/Modelsim
***********************************************/
module  FreqDiv #(parameter DIV_IN = 3, DIV_OUT = 2)
//DIV: factor for frequency division
 ( 
    input CLK_in, RST,
    output CLK_out
  );
//Definition for Variables in the module
localparam[0:0] ILLEGAL = ( ( DIV_IN < DIV_OUT) || (DIV_OUT <= 0));
//ERROR!Parameter DIV_IN must be greater than DIV_OUT! And the CLK_in is output!
localparam[0:0] INT_FREQDIV = (DIV_OUT == 1);
//When Parameter DIV_OUT(0, 1), there is integer frequency division with factor DIV_IN.

//Load other module(s)
generate
begin
    case ({ILLEGAL, INT_FREQDIV})
        2'b00:
        //Fractional frequency division
        begin
            frac_FreqDiv #(.DIV_IN(DIV_IN), .DIV_OUT(DIV_OUT)) F(.CLK_in(CLK_in), .RST(RST), .CLK_out(CLK_out));
        end
        
        2'b01:
        //When Parameter DIV_OUT(0, 1), there is integer frequency division with factor DIV_IN.
        begin
            int_FreqDiv_G1 #(.DIV(DIV_IN)) I(.CLK_in(CLK_in), .RST(RST), .SYNC(1'b1), .CLK_out(CLK_out));
        end
        
        default:
        //ERROR!Parameter DIV_IN (%d)must be greater than DIV_OUT(%d)!
        //And the CLK_in is output!
        begin
            assign CLK_out = RST && CLK_in;
        end

    endcase
end
endgenerate

//Logic   
endmodule