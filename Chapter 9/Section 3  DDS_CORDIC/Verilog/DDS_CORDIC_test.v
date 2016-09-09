/***********************************************
Module Name:   DDS_CORDIC_test
Feature:       Testbench for DDS_ROM
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
------------------------------------------------------
History:
03-16-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules
`define FILE_NAME "DDS_value_one_circle.txt"
module DDS_CORDIC_test;
//defination for Variables
reg clk;
reg reset;

reg[7:0] step;

reg set;
reg set_delay;
//Set step value flag
//_delay: wait for step increase

wire  signed[7:0] value;
reg signed[7:0] value_delay;

wire zero;

time old_time, now_time;
time gap;
//Time between two zero flags

integer file_id;
reg[1:0] first_circle;
//Save only the first circle data
//0: not start yet
//1: in the first circle
//2: The first circle finished


//Connection to the modules
DDS_CORDIC   DDS( .CLK(clk), .RESET(reset), .SET(set_delay),
               .step_in(step), .value(value),
               .zero_address(zero));

begin
   

//Clock generation
    initial
    begin
      clk = 0;
      //Reset
      forever  
      begin
           #10 clk = !clk;
           //Reverse the clock in each 10ns
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
    
//Set operation
    initial  
    begin
      set = 0;
      //Initial Step
       #36014  set = 1;
       #20 set = 0;
       //First set the value
       //Reset time added
       
      forever
      begin
      #36000  set = 1;
      #20 set = 0;
     //Set the value
      end
    end
    
//Set delay
    always @(posedge clk or negedge reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            set_delay <= 1'b0;
        end
        else
        //Wroking, counter increasing
        begin
            set_delay <= set;
        end
    end
    
//Step operation
    always @(posedge clk or negedge reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            step <= 8'h01;
        end
        else if(set)
        //Wroking, counter increasing
        begin
            step <= step + 8'h01;
        end
    end


//Time operation
   initial
   begin
        old_time = $time();
        now_time = $time();
    end
    
    always @(posedge clk or negedge reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
        end
        else if(set)
        //Wroking, counter increasing
        begin
            old_time = 0;
            now_time = 0;
            $display("New step(= %d) value setted @ %t!", step+1, $time);
        end
        else if(zero)
        //Wroking, counter increasing
        begin
           now_time = $time();
           if ( (old_time != now_time) && (old_time != 0))
           //Gap there
           begin
               gap = now_time - old_time;
               $display("Zero address arrived!");
               $display("Old time = %t and now = %t", old_time, now_time);
               $display("Gap = %t", gap);
               old_time = now_time;
           end
           else
           begin
               old_time = now_time;
           end
        end
    end

//File operation
   initial
   begin
        file_id = $fopen(`FILE_NAME,"w");
        first_circle = 2'h0;
   end
   
   always @ (posedge clk or negedge reset)
   begin
       if ( (zero) && (first_circle <= 2'h1))
       begin
           first_circle <= first_circle + 2'h1;
       end
       else
       begin
       end
   end 
   
   always @ (posedge clk)
   begin
       value_delay <= value;
   end
   
   always @ (posedge clk or negedge reset)
   begin
       if ( first_circle == 2'h1)
       begin
           if (file_id != 0)
           begin
               $fdisplay(file_id, "%d", value_delay);
           end
      end
      else if(first_circle == 2'h2)
      begin
          if (file_id != 0)
           begin
               $fclose(file_id);
               file_id <= 0;
           end      
       end
       else
       begin
       end
   end        
end
endmodule