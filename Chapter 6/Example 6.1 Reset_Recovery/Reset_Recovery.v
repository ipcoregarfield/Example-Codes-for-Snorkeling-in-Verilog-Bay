/***********************************************
Module Name:   reset_recovery
Feature:       PCB reset recovery
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1bit clock
               PCB_RST, 1 bit, reset on PCB connected the switch
Output Ports:  reset, 1 bit, recoved reset to chip
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: First verified by Reset_Recovery_test  ISE/Modelsim
***********************************************/

module reset_recovery
  ( 
    input CLK, input PCB_RST,
    output reg reset
  );

//Definition for Variables in the module
wire timer_on;
wire timer_start;
//Load other module(s)
edge_detect E1(.CLK(CLK), .input_signal(PCB_RST),
                 .enable(~timer_on),
                 .detected(timer_start) );
timer_20ms  T1( .clk(CLK),.start(timer_start),
                .on(timer_on) );
                
//Logical

always @(posedge CLK)
//First element in input signal D-chain
begin
    begin
    	reset <= ~timer_on;
    end
end

endmodule