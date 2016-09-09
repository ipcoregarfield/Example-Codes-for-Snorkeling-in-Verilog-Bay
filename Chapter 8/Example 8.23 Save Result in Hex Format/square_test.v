/***********************************************
Module Name:   square_test
Feature:       Testbench for square
               to write the value and square into a file 
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
----------------------------------------------------
History:
03-01-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

module square_test;
//defination for Variables
reg clk;
reg reset;

reg[5:0] counter;
wire[11:0] square;

integer file_id;
//File ID

//Connection to the modules
square_cal S1( .value(counter),.square(square) );

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

always @(posedge clk or negedge reset)
//Counter
begin
    if ( !reset)
    begin
        counter <= 6'h00;
        //Reset
    end
    else
    begin
        counter <= counter + 6'h01;
        //Increase
    end
end

//File operation
    initial  
    begin
      file_id = $fopen("square_test.txt","a");
      //Open file
      #1280
      //Delay for all the values
      $fclose(file_id);
      //Close the file
      file_id = 0;
    end
    
always @(posedge clk )
//File write
begin
    if (file_id != 0)
    begin
        $fdisplay(file_id, "%h %h ", counter, square);
    end
    else
    begin
    end  
end
end
endmodule