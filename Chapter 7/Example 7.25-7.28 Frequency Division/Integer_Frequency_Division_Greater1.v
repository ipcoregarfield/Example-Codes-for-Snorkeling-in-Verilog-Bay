/***********************************************
Module Name:   int_FreqDiv_G1
Feature:       Integer frequency division which the factor must be greater than 1
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
02-05-2016: First verified by int_FreqDiv_G1_test  ISE/Modelsim
***********************************************/


module  int_FreqDiv_G1 #(parameter DIV = 2)
//DIV: factor for frequency division
 ( 
    input CLK_in, RST, SYNC,
    output reg CLK_out
  );
  
function integer int_log2(input integer num);
//Return the up-integer for log2(num)
begin
    int_log2 = 1;
    //Initial
    while ( (2 ** int_log2) < num)
    //Not reaching the number
    begin
        int_log2 = int_log2 + 1;
    end
end
endfunction

localparam REVERSE = (DIV-2) / 2;
//Definition for Variables in the module
localparam WIDTH = int_log2(DIV);
reg[WIDTH - 1:0]  counter;
//Counter in the module

//Load other module(s)

//Logic          
always @(posedge CLK_in or negedge RST)
//Counter operation
begin
    if (!RST)
    //Reset
    begin
        counter <= DIV - 1;
    //Posedge generate as soon as leave reset-statement
    end
    else if (!SYNC)
    //Diable
    begin
        counter <= DIV - 1;
    //Posedge generate as soon as leave reset-statement
    end
    else if (counter == DIV -1)
    //Reached the division value
    begin
        counter <= 1'h0;
    end
    else
    //Not yet
    begin
        counter <= counter + 1'h1;
    end
end

always @(posedge CLK_in or negedge RST)
//Clock divided operation
begin
    if (!RST)
    //Reset
    begin
        CLK_out <= 1'h0;
    end
    else if (!SYNC)
    //Diable
    begin
        CLK_out <= 1'h0;
    //Posedge generate as soon as leave reset-statement
    end
    else if ( (counter == DIV -1 ) || (counter == REVERSE) )
    //Reached the division value or reversing value
    begin
        CLK_out <= ~CLK_out;
    end
end
endmodule