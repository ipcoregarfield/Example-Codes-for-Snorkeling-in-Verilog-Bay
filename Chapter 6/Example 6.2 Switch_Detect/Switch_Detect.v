/***********************************************
Module Name:   switch_detect
Feature:       Detect swith on on PCB
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit clock, 200 ns period
               RST, 1 bit, reset
               switch_in, 1 bit, PCB connected the switch
Output Ports:  detected, 1 bit, switch_on detect
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: First verified by Switch_Detect_test  ISE/Modelsim
***********************************************/

module switch_detect
  ( 
    input CLK, input RST,
    input switch_in,
    output detected
  );

//Definition for Variables in the module
wire timer_on;
wire timer_start;
//Load other module(s)
edge_detect E1(.CLK(CLK), .RST(RST), .input_signal(switch_in),
                 .enable(~timer_on),
                 .detected(detected) );
timer_20ms  T1( .clk(CLK),.RST(RST), .start(timer_start),
                .on(timer_on) );
                
//Logical
assign timer_start = detected;

endmodule