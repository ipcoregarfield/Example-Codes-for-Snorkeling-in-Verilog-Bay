/***********************************************
Module Name:   function_2line
Feature:       Area calculation with 2 functions with circle and square
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   CLK, 1 bit, clock
               RST, 1 bit, reset
               width, 8 bits, width length, unsiged
                     one void value in one clock
Output Ports:  area, 16 bits, area value with the sharp
------------------------------------------------------
History:
01-29-2016: First Version by Garfield
01-29-2016: First verified by Function_test
***********************************************/

module function_2lines
  ( 
    input CLK, input RST,
    input[7:0] width,
    output reg[16:0]area
  );
  
//Load other module(s)

//Definition for Variables in the module
reg[15:0] circle_area;
reg[15:0] square_area;
//Area for circle and square

//Functions for area calculation
function[15:0] circle(input[7:0] diameter);
begin
    circle = (24'd201 * {16'h0, diameter} * {16'h0, diameter}) / 256;
end
endfunction

function[15:0] square(input[7:0] width);
begin
    square = {8'h0, width} * {8'h0, width};
end
endfunction

//Logical
always @(width)
begin
    circle_area <= circle(width);
    square_area <= square(width);
end

always @(posedge CLK, negedge RST)
begin
    if (!RST)
    //Reset
    begin
       area <= 17'h0000;
    end
    else 
    //Data comes
    begin
        area <= circle_area +  square_area;
    end
end

endmodule