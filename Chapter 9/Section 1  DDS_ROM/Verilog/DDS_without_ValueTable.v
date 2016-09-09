/***********************************************
Module Name:   DDS_without_valuetable
Feature:       DDS without the function value table
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               SET: step value set flag with a new value input
                    counter value will be reset to 0
               step_in: Set step value
               table_value: sin value in [0,90]
               abs_value: value of the function, positive number
Output Ports:  vlaue: DDS output value, signed
               table_address, short_adress,  short adress in [0, 90] 
               zero_address, long_address == 0, for testbench only
------------------------------------------------------
History:
03-08-2016: First Version by Garfield
03-08-2016: Verified by DDS_without_valuetable
***********************************************/

module DDS_without_valuetable
#(parameter ADDRESS_WIDTH = 8,
//Bit width for phase counter and step 
parameter INITIAL_STEP = 1,
//Initial step value
parameter VALUE_WIDTH = 8,
//Output value's bit width
parameter VALUETABEL_DELAY = 1)
//The input-output delay for value table
  ( 
    input CLK,
    input RESET,
    input SET,
    input[ADDRESS_WIDTH - 1 : 0] step_in,
    input[VALUE_WIDTH - 1 - 1 : 0] table_value,
    output[ADDRESS_WIDTH - 1 - 1: 0] table_address,
    output[VALUE_WIDTH - 1 : 0] value,
    output zero_address
  );

//Defination for Varables in the module
wire zero;
reg[VALUETABEL_DELAY - 1 :0] symbol_delay_chain;
//Delay chain for the symbol waiting for value table module
reg[VALUETABEL_DELAY + 1 :0] zero_delay_chain;
//Delay chain for the zero_flag waiting for 
//value table module ,and address_adjust module
//and value_2_signed module
integer loop;
//Loop variable

wire[ADDRESS_WIDTH - 1 : 0] long_address;
//long address in [0, 360)
wire value_symbol;
//Symbol for sin value

//Logicals
counter  #( .WIDTH(ADDRESS_WIDTH), .INITIAL_STEP(INITIAL_STEP))
         phase_counter( .CLK(CLK), .RESET(RESET), .SET(SET),
           .step_in(step_in), .counter(long_address) );
//Phase counter

address_adjust #( .WIDTH(ADDRESS_WIDTH))
        address_adj( .CLK(CLK), .RESET(RESET), .long_address(long_address),
    .short_address(table_address), .symbol(value_symbol));
//Get the address for value table

value_2_signed #( .WIDTH(VALUE_WIDTH))
       get_value  ( .CLK(CLK), .RESET(RESET), .abs_value(table_value),
                    .symbol(symbol_delay_chain[VALUETABEL_DELAY - 1]),
                    .result(value) );
//Get the signed function value

assign zero = (long_address == {(ADDRESS_WIDTH){1'b0}});
assign zero_address = zero_delay_chain[VALUETABEL_DELAY+1];

always @ (posedge CLK or negedge RESET)
//Delay chain
begin
    if ( !RESET)
    //Reset enable
    begin
        symbol_delay_chain <= {(VALUETABEL_DELAY - 1){1'b0}};
    end
    else
    //Clear the counter
    begin
        symbol_delay_chain[0] <= value_symbol;
        for (loop = 0; loop < VALUETABEL_DELAY - 1; loop = loop + 1)
        begin
            symbol_delay_chain[loop + 1] <= symbol_delay_chain[loop];
        end
    end
end

always @ (posedge CLK or negedge RESET)
//Delay chain
begin
    if ( !RESET)
    //Reset enable
    begin
        zero_delay_chain <= {(VALUETABEL_DELAY){1'b0}};
    end
    else
    //Clear the counter
    begin
        zero_delay_chain[0] <= zero;
        for (loop = 0; loop < VALUETABEL_DELAY + 1; loop = loop + 1)
        begin
            zero_delay_chain[loop + 1] <= zero_delay_chain[loop];
        end
    end
end

endmodule