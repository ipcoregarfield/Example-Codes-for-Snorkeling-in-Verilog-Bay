/***********************************************
Module Name:   timer
Feature:       timer with set
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               timer_circle, 8 bits, timer with the clock circle
               start_flag, 1 bit, start flag
                           timer starts when the flag is 1
                           as well as counter inside is set
Output Ports:  timer_over, 1 bit, output
                           1 clock circle 1 when timer is over
------------------------------------------------------
History:
12-24-2015: First Version by Garfield
12-24-2015: First verified by Timer_test
***********************************************/

module timer
  ( 
    input CLK, input RST,
    input[7:0] timer_circle,
	  input start_flag,
    output reg timer_over 
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[7:0] counter;
//Inside counter
//Logical
always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
        counter <= 8'h00;
    end
    else if ( (start_flag == 1'b1) && (counter == 8'h00) )
    //Timer start with original value
    begin
        counter <= timer_circle;
    end
    else if (counter != 8'h00)
    //Timer on going
    begin
        counter <= counter - 8'h01;
    end
    else
    //Timer is over
    begin
    end
end

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
        timer_over <= 1'b0;
    end
    else if (counter == 8'h01)
    //Timer is over, considering one clock delay
    begin
        timer_over <= 1'b1;
    end
    else
    //Timer on going or not to be started
    begin
        timer_over <= 1'b0;
    end
end
endmodule