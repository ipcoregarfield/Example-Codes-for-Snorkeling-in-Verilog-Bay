/***********************************************
Module Name:   sequence_detect_test
Feature:       Testbench for Sequence_Detect
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         counter: counter for data number
         data_4bit: 4 bit data for module input, invreace per 4 clock
         data: input port for the module 
         detected: output as scan result
------------------------------------------------------
History:
03-27-2014: First Version by Garfield
***********************************************/
`timescale 1 ns/100 ps
//Simulation time assignment


module sequence_detect_test;
//defination for Variables
reg clk;
reg reset;

reg[1:0] counter;

reg[3:0] data_4bit;
reg data;
reg [3:0] data_dis;
//Data for display

wire detected;

//Connection to the modules
sequence_detect S1(.clk(clk),.Reset(reset),
                   .data(data), .detected(detected) );
//Module Example

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
    
//Couner as input
    always @(posedge clk or reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            counter <= 2'b11;
        end
        else
        //Wroking, counter increasing
        begin
            counter <= counter + 2'b01;
        end
    end
    
//4 bit data as sequence to module
    always @(posedge clk or reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            data_4bit <= 4'b00;
        end
        else if (counter == 2'b11)
        //Start a scan
        begin
            data_4bit <= data_4bit + 4'b001;
        end
        else
        begin
        end
    end
end

//4 bit data as sequence to module to diaplay
    always @(posedge clk or reset)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            data_dis <= 4'b00;
        end
        else 
        //data srored
        begin
            data_dis <= { data, data_dis[3:1] }; 
        end
     end

//Data Generation
    always @(*)
    begin
        if ( !reset)
        //reset statement: counter keeps at 0
        begin
            data <= 1'b0;
        end
        else
        //Generate a random number as data
        begin
            case (counter)
                2'b00:
                begin
                   data <= data_4bit[0];
                end
                
                2'b01:
                begin
                   data <= data_4bit[1];
                end
                
                2'b10:
                begin
                   data <= data_4bit[2];
                end
                
                2'b11:
                begin
                   data <= data_4bit[3];
                end
            endcase
        end
    end

endmodule