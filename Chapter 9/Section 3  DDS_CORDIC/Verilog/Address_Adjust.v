/***********************************************
Module Name:   address_adjust
Feature:       shorten the long address to short address
               Get the symbol of sin value
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               long_address: long address in [0, 360)
Output Ports:  short_adress,  short adress in [0, 90]
               symbol, symbol of sin value
------------------------------------------------------
History:
03-08-2016: First Version by Garfield
03-08-2016: Verified by Address_Adjust_test
***********************************************/

module address_adjust
#(parameter WIDTH = 8)
//Bit width for long address
  ( 
    input CLK,
    input RESET,
    input[WIDTH - 1 : 0] long_address,
    output reg[WIDTH - 1 - 1 : 0] short_address,
    output reg symbol
  );

//Defination for Varables in the module
wire[WIDTH-3:0] tail_bit_long_add;
//De-phase long address
//Logicals
assign tail_bit_long_add = long_address[WIDTH-3:0];
always @ (posedge CLK or negedge RESET)
//Address operations
begin
    if ( !RESET)
    //Reset enable
    begin
        short_address <= {(WIDTH-2){1'b0}};
    end
    else if (!long_address[WIDTH-2])
    //Phase 1 or 3
    // sin(a) = sin (a) 
    //or sin(180 + a) = -sin(a)
    begin
        short_address <= {1'b0, tail_bit_long_add};
    end
    else
    //Phase 2 or 4
    //sin(90 + a) = sin(90 - a)
    //or sin(270 + a) = -sin(90 - a)
    begin
        if (tail_bit_long_add != {(WIDTH-2){1'b0}})
        //Not 90 or 270 degree
        begin
            short_address <= {1'b1, {(WIDTH-2){1'b0}}} - {1'b0, tail_bit_long_add};
            //{1'b1, {(WIDTH-2){1'b0}}}: 90 degrees
        end
        else
        begin
           short_address <= {1'b1, {(WIDTH-2){1'b0}}}; 
        end
    end
end

always @ (posedge CLK or negedge RESET)
//Symbol operations
begin
    if ( !RESET)
    //Reset enable
    begin
        symbol <= 1'b0;
    end
    else
    //In phase 1 and 2, sin(a) >= 0
    //In phase 3 and 4, sin(a) <= 0
    begin
        symbol <= long_address[WIDTH - 1];
    end
end

endmodule