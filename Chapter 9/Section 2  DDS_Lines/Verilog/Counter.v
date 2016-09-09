/***********************************************
Module Name:   counter
Feature:       counter, with step set
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               SET: step value set flag with a new value input
                    counter value will be reset to 0
               step_in: Set step value
Output Ports:  counter,  result
------------------------------------------------------
History:
03-08-2016: First Version by Garfield
03-08-2016: Verified by Counter_test
***********************************************/

module counter
#(parameter WIDTH = 8,
//Bit width for counter and step 
parameter INITIAL_STEP = 1)
//Initial step value
  ( 
    input CLK,
    input RESET,
    input SET,
    input[WIDTH - 1 : 0] step_in,
    output reg[WIDTH - 1 : 0] counter
  );

//Defination for Varables in the module
reg[WIDTH - 1 : 0] step;
//Stored step value


//Logicals
always @ (posedge CLK or negedge RESET)
//Counter operations
begin
    if ( !RESET)
    //Reset enable
    begin
        counter <= {(WIDTH-1){1'b0}};
    end
    else if (SET)
    //Set the step value
    begin
        counter <= {(WIDTH){1'b0}};
    end
    else
    //Increacing
    begin
        counter <= counter + step;
    end
end

always @ (posedge CLK or negedge RESET)
//Step operations
begin
    if ( !RESET)
    //Reset enable
    begin
        step <= INITIAL_STEP;
    end
    else if (SET)
    //Clear the counter
    begin
        step <= step_in;
    end
    else
    //Idle statement record the counter
    begin
    end
end

endmodule