/***********************************************
Module Name:   switch_detect_press
Feature:       Detect swith on on PCB and increase the counter if the switch press on
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit clock, 200 ns period
               RST, 1 bit, reset
               switch_in, 1 bit, PCB connected the switch
Output Ports:  detected, 1 bit, switch_on detect
               counter, 8 bits, counter for detect and press
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: First verified by Switch_Detect_test  ISE/Modelsim
***********************************************/

module switch_detect_press
  ( 
    input CLK, input RST,
    input switch_in,
    output detected,
    output reg[7:0] counter
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

always @(posedge CLK or negedge RST)
//First element in input signal D-chain
begin
   if (!RST)
   begin
    	counter <= 8'h00;   	
   end
   else
   begin
   	  if (detected)
   	  //First switch on
   	  begin
    	    counter <= counter + 8'h01 - 8'h2;
    	    //constant 2 is to adjust the time different between detect and timer
    	end
    	else if ((!timer_on)&&(~switch_in))
    	//Long time press
    	begin
    	    counter <= counter + 8'h01;
    	end
    	else
    	begin
    	end
    end
end
endmodule