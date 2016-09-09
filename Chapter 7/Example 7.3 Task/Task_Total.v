/***********************************************
Module Name:   task_total
Feature:       Area calculation with 2 functions with circle and square
               And task total_area to call the functions
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
02-01-2016: First Version by Garfield
02-01-2016: First verified by Task_test
***********************************************/

module task_total
  ( 
    input CLK, input RST,
    input[7:0] width,
    output reg[16:0]area
  );
  
//Load other module(s)

//Definition for Variables in the module

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

task total(input[7:0] width, output[17:0] area);
begin
   area <= {2'h0, square(width)} + {2'h0, circle(width)};
end
endtask

//Logical
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
        total(width, area);
    end
end

endmodule