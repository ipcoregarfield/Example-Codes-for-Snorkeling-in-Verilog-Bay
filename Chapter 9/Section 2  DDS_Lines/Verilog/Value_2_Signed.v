/***********************************************
Module Name:   value_2_signed
Feature:       To signed value with seperate synbol
               and absolute value
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               abs_value: absolute value
               symbol, symbol of value
Output Ports:  result,  signed value
------------------------------------------------------
History:
03-08-2016: First Version by Garfield
03-08-2016: Verified by Value_2_Signed_test
***********************************************/

module value_2_signed
#(parameter WIDTH = 8)
//Bit width for signed value
  ( 
    input CLK,
    input RESET,
    input[WIDTH - 2 : 0] abs_value,
    input symbol,
    output reg[WIDTH - 1: 0] result
  );

//Defination for Varables in the module

//Logicals
always @ (posedge CLK or negedge RESET)
//Symbol operations
begin
    if ( !RESET)
    //Reset enable
    begin
        result <= {(WIDTH){1'b0}};
    end
    else if(!symbol)
    //No less than 0
    begin
        result <= {symbol, abs_value};
    end
    else
    //Less than 0
    //to complement
    begin
        if (abs_value == {(WIDTH-2){1'b0}})
        begin
            result <= {(WIDTH-1){1'b0}};
        end
        else
        begin
            result <= {symbol, ~abs_value + {{(WIDTH-2){1'b0}}, 1'b1}};
        end
    end
end

endmodule