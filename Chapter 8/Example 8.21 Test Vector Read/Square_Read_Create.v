/***********************************************
Module Name:   Square_Read_Create
Feature:       Raed the square values in the file 
               and create them periodly
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
Output Ports:  square, 12 bits, square value at the moment
------------------------------------------------------
History:
03-01-2016: First Version by Garfield
03-01-2016: First verified by Square_Read_Create_test
***********************************************/

module square_read_create
  ( 
    input CLK, input RST,
 	  output[11:0] square
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[11:0] value[63:0];
//Buffer to sroe
reg[5:0] counter;
//Counter for the value circle

//Logical
assign square = value[counter];

initial
begin
    $readmemh("square_table.txt", value);
    //Get the square values    
end

always @(posedge CLK or negedge RST)
begin
    if ( !RST)
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
endmodule