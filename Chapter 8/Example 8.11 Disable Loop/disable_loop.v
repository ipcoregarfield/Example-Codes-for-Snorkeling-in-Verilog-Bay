/***********************************************
Module Name:   Disable_Loop
Feature:       Show the disable application
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         enable: enable flag
         a, b, c, d, testee
------------------------------------------------------
History:
02-18-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/10 ps
//Simulation time assignment

module disable_loop;
reg [15:0] loop_var1 = 0, loop_var2 = 0;

initial
begin: break
    while(1)
    begin: continue
      loop_var1 = loop_var1 + 1;
      
      loop_var2 = loop_var2 + 1;
      
      if (loop_var1 >= 8)
      begin
          disable continue;
      end
      
      if (loop_var2 >= 18)
      begin
          disable break;
      end
      
    end
end

endmodule