/***********************************************
Module Name:   edge_detect
Feature:       Negative edge detect with enable
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1bit clock
               input_signal, 1 bit, signal to be detected
               enable, 1 bit, detect enable
Output Ports:  detected, 1 bit, high if negative edge is detected
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: First verified by Reset_Recovery_test  ISE/Modelsim
***********************************************/

module edge_detect
  ( 
    input CLK, input input_signal,
    input enable,
    output reg detected
  );

//Definition for Variables in the module
reg input_delay;
//Delay 1 clock for input signal

//Load other module(s)

//Logical

always @(posedge CLK)
//First element in input signal D-chain
begin
   begin
    	input_delay <= input_signal;
    end
end

always @(posedge CLK)
//First element in input signal D-chain
begin
    begin
    	if (enable)
    	begin
    	    detected <= (input_delay == 1'b1) && (input_signal == 1'b0); 
      end
      else
      begin
          detected <= 1'b0;
      end
    end
end

endmodule