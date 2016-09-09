/***********************************************
Module Name:   ROM_task
Feature:       ROM for berification with timing task
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RD, 1 bit, read enable, 1 clock
               address, 8 bits,reading address
Output Ports:  data, 8 bits, data for output (= address + 1;)
------------------------------------------------------
History:
02-02-2016: First Version by Garfield
02-02-2016: First verified by Task_Timing_test
***********************************************/
`timescale 10ns/100ps

`define REPARE_TIME 3
//Data repaering 3 clocks after address come
`define INIT_TIME 100
//ROM initial time 
`define OFFSET 1 

module ROM_task
  ( 
    input CLK, input RD,
    input[7:0] address,
    output reg[7:0] data
  );
  
//Load other module(s)

//Definition for Variables in the module

task init(output reg[7:0] data);
begin
   data = 8'hff;
   #(`INIT_TIME) data = 8'hzz;
   //Waiting for initial period
end
endtask

task read(input[7:0] address, 
          output reg[7:0] data);
begin
  repeat(`REPARE_TIME) @(posedge CLK);
  //Waiting for data ready:3 clocks
  data = address + `OFFSET;
  //Set data
end
endtask

//Logical
initial
//Initial processing
begin
    init(data);
end

always @(posedge CLK)
//Read processing
begin
    if (RD)
    //To be read
    begin
        read(address, data);
    end
end

endmodule