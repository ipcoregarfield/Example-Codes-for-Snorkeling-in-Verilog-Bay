/***********************************************
Module Name:   DDS_CORDIC
Feature:       DDS with CORDIC as the value table
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               SET: step value set flag with a new value input
                    counter value will be reset to 0
               step_in: Set step value
Output Ports:  vlaue: DDS output value, signed
               zero_address, long_address == 0, for testbench only
------------------------------------------------------
History:
03-20-2016: First Version by Garfield
03-20-2016: Verified by DDS_CORDIC_test
***********************************************/

module DDS_CORDIC
#(parameter ADDRESS_WIDTH = 8,
//Bit width for phase counter and step 
parameter INITIAL_STEP = 1,
//Initial step value
parameter VALUE_WIDTH = 8,
//Output value's bit width
parameter VALUETABEL_DELAY = 10)
//The input-output delay for value table
//Parameters fixed by the ROM
  ( 
    input CLK,
    input RESET,
    input SET,
    input[ADDRESS_WIDTH - 1 : 0] step_in,
    output[VALUE_WIDTH - 1 : 0] value,
    output zero_address
  );

//Defination for Varables in the module
wire[VALUE_WIDTH - 1 - 1 : 0] table_value;
wire[ADDRESS_WIDTH - 1 - 1: 0] table_address;
//Value Table ports

//Logicals
DDS_without_valuetable #(.ADDRESS_WIDTH(ADDRESS_WIDTH),.INITIAL_STEP(INITIAL_STEP),
                         .VALUE_WIDTH(VALUE_WIDTH), .VALUETABEL_DELAY(VALUETABEL_DELAY))
                 frame      (  .CLK(CLK), .RESET(RESET), .SET(SET),
                               .step_in(step_in), .table_value(table_value),
                               .table_address(table_address), .value(value),
                               .zero_address(zero_address)  );
//Basic structure with value table

CORDIC_sin_0_90 CORDIC_0_90(.CLK(CLK), .RESET(RESET), .address(table_address),
                         .value(table_value) );
//Value table in ROM

endmodule