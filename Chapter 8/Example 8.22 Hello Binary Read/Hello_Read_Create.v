/***********************************************
Module Name:   Hello_Read_Create
Feature:       Raed the hello.txt in the file 
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

module hello_read_create
  ( 
    input CLK, input RST,
 	  output[11:0] letter
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[7:0] letters[11:0];
//Buffer to stroe
integer file_id;
//File iditification
integer code;
//Error code
reg[4:0] counter;
//Counter for the value circle

//Logical
assign letter = letters[counter];

initial
begin
    file_id = $fopen("hello.txt", "r");
    //Open file with read mode
    code = $fread( letters, file_id);
    //Read data
    $fclose(file_id);
    //Close file 
end

always @(posedge CLK or negedge RST)
begin
    if ( !RST)
    begin
        counter <= 4'h0;
        //Reset
    end
    else if (counter <= 10)
    begin
        counter <= counter + 4'h1;
        //Increase
    end
    else
    begin
        counter <= 4'h0;
        //Return to the first letter
    end
end
endmodule