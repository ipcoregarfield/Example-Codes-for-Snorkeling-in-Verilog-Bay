/***********************************************
Module Name:   Reset_Recovery_test
Feature:       Testbench for Reset_Recovery
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for system, 200 ns period
         reset: reset flag
         clk_switch: clock for switch module, 2 ns period
         switch_on: swith pushed on
         
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
***********************************************/
`timescale 1 ns/100 ps
//Simulation time assignment

//Insert the modules

module reset_recovery_test;
//defination for Variables
reg clk;
wire PCB_reset;

reg clk_switch;
reg switch_on;

wire recoved_reset;

//Result for verification

//Connection to the modules

switch S1(.clk(clk_switch), .switch_on(switch_on),
       .switch_out(PCB_reset));
reset_recovery R1 ( .CLK(clk), .PCB_RST(PCB_reset),
                    .reset(recoved_reset));

begin
   
//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      forever  
      begin
           #100 clk = !clk;
           //Reverse the clock in each 100ns
      end
    end

//Clock generation
    initial
    begin
      clk_switch = 0;
      //Reset
      forever  
      begin
           #1 clk_switch = !clk_switch;
           //Reverse the clock in each 1ns
      end
    end

//Switch on simulation
    initial
    begin
      switch_on = 1'b0;
      //Reset
      forever  
      begin
           #200 switch_on = 1'b1;
           #2  switch_on = 1'b0;
           #200_000_000  switch_on = 1'b1;
           //switch on per 200ms+
      end
    end
        
end

endmodule

/***********************************************
Module Name:   switch
Feature:       switch simulation
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 2 ns period
               switch_on, switch on flag, high level avaiable
Output Ports:  reset, reset signal on PCB
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: Verified by Garfield with Reset_Recovery_test in Modelsim
***********************************************/

module switch
  ( 
    input clk,
    input switch_on,
    output reg switch_out
  );
//Signal: swith_on == high -----> 400 ns low level  ----> 20 ms up-and-down randomly -----> high(until next switch_on avaiable)

//Defination for Varables in the module
`define COUNTER_400NS 200
`define WIDTH_400NS   8
//Satrt number for 400 ns, 200 clock periods
`define COUNTER_20MS 10_000_000
`define WIDTH_20MS   24
//Satrt number for 20 ms, 10,000 clock periods

reg start1, start2;
//Timer start flags
//start1 trigged by switch_on possedge
//start2 trigged by switch_on negsedge
reg switch_on_delay, timer_on1_delay;
//Delay for edge detect

wire timer_on1, timer_on2;
//Timer on flags

//Modules inline
timer #(.number(`COUNTER_400NS), .width(`WIDTH_400NS))
        T1  (.clk(clk),.start(start1),.on(timer_on1));
timer #(.number(`COUNTER_20MS), .width(`WIDTH_20MS))
        T2  (.clk(clk),.start(start2),.on(timer_on2));          
//Logicals
//Combanitory logicals
always @ (posedge clk)
//Counter operations
begin
    switch_on_delay <= switch_on;
    timer_on1_delay <= timer_on1;
end

always @(posedge clk)
begin
    start1 <= (switch_on_delay == 1'b0 ) && (switch_on != switch_on_delay);
end

always @(posedge clk)
begin
    start2 <= (timer_on1_delay == 1'b1 ) && (timer_on1 != timer_on1_delay);
end

always @ (posedge clk)
//Counter operations
begin
    if ( timer_on1)
    begin
        switch_out = 1'b0;
    end
    else if (timer_on2)
    begin
        switch_out = $random();    	
    end
    else
    begin
        switch_out = 1'b1;
    end
 
end

endmodule

/***********************************************
Module Name:   timer
Feature:       timer with constant counter number
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 2 ns period
               start, timer start flag, high level avaiable
Output Ports:  timer_on, high if time is on counter
------------------------------------------------------
History:
01-21-2016: First Version by Garfield
01-21-2016: Verified by Garfield with Reset_Recovery_test in Modelsim
***********************************************/

module timer
  ( 
    input clk,
    input start,
    output on
  );
parameter number = 100, width = 7;

//Defination for Varables in the module
reg[width-1:0] counter = 0;
//Logicals
//Combanitory logicals
assign on = (counter != 0);

always @ (posedge clk)
//Counter operations
begin
    if ( start)
    begin
        counter <= number;
    end
    else if (counter != 0)
    begin
        counter <= counter - 1'b1;
    end
    else
    begin
    end
end

endmodule