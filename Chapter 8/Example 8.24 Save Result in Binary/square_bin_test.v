/***********************************************
Module Name:   square_test
Feature:       Testbench for square
               to write the value and square into a binary file 
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

module square_bin_test;
//defination for Variables
reg clk;
reg reset;

reg[5:0] counter;
wire[11:0] square;

reg[15:0] square_store[63:0];
//Store regs for square values

integer file_id;
//File ID

integer loop;
//Loop variable

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
      file_id = $fopen("square_bin.txt","w");
      //Open file
      #2000
      //Delay for all the values created
      if ( file_id != 0)
      begin
          for (loop = 0; loop < 64; loop = loop + 1)
          begin
              $fwrite(file_id, "%c%c", 
                    square_store[loop][15:8],square_store[loop][7:0]);
              //Write the binary values into file
          end
          $fclose(file_id);
          //Close the file
      end
    end
    
    always @(posedge clk)
    begin
        square_store[counter] <= {4'h0, square};
    end
    
 end
 endmodule    