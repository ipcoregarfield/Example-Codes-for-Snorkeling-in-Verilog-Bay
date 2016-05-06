/***********************************************
Module Name:   Switch_Detect_Press_test
Feature:       Testbench for Switch_Detect_Press
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

module switch_detect_press_test;
//defination for Variables
reg clk;
wire switch_in1, switch_in2;
wire switch_in;
reg[1:0] switch;

reg clk_switch;
reg switch_on;
reg reset;

wire detected;
wire[7:0] counter;

//Result for verification

//Connection to the modules

switch_short S1(.clk(clk_switch), .switch_on(switch_on),
       .switch_out(switch_in1));
switch_long S2(.clk(clk_switch), .switch_on(switch_on),
       .switch_out(switch_in2));
switch_detect_press S3 ( .CLK(clk), .RST(reset),
    .switch_in(switch_in),
    .detected(detected), .counter(counter)
  );

begin
assign switch_in = (switch == 2'h1) ? (switch_in1) : 
                           ( (switch == 2'h2) ? (switch_in2) :(1'b1) );
//switch_on operation
    initial  
    begin
      switch_on = 1;
      //Reset enable
      #100  switch_on = 0;
     //On in 100 ns
     #20 switch_on = 1;
     
     #30_000_000 #100  switch_on = 0;
     //2nd switch on after 30ms
     #20 switch_on = 1;
    end

//switch_in operation
    initial  
    begin
     switch = 2'h1;
     #30_000_000  switch = 2'h2;
     //2nd switch on after 30ms
     #50_000_000 switch<= 2'h0;
     //2nd switch off after 50ms
    end
   
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

//Reset operation
    initial  
    begin
      reset = 0;
      //Reset enable
      #14  reset = 1;
     //Counter starts
    end
end    
endmodule

/***********************************************
Module Name:   switch_short
Feature:       switch witch short press simulation
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

module switch_short
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
Module Name:   switch_long
Feature:       switch witch long press simulation
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

module switch_long
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
`define COUNTER_20MS 10_000
`define WIDTH_20MS   14
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
        switch_out = 1'b0;
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