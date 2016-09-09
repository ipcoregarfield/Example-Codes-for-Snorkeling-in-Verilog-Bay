/***********************************************
Module Name:   Top_Calling
Feature:       Called sub-modules without new width define
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, 8 bits(defined),operents
Output Ports:  result_a, 8 bits(defined), data for module without new define (= a + 1)
               result_b, 8 bits(defined), data for module with new define (= a + 1)
------------------------------------------------------
History:
02-03-2016: First Version by Garfield
02-03-2016: First verified by Define_Scope_test
***********************************************/
`timescale 10ns/100ps
`define WIDTH 8

module top_calling
  ( 
    input[`WIDTH - 1:0] a,
    output[`WIDTH - 1:0] result_a, result_b
  );
  
//Load other module(s)
sub_called_without S_WO (.a(a), .result(result_a));
sub_called_with    S_W  (.a(a), .result(result_b));

//Definition for Variables in the module

//Logic

endmodule

/***********************************************
Module Name:   Sub_Called_Without
Feature:       Called sub-modules without new width define
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, 8 bits(defined),operents
Output Ports:  result, 8 bits(defined), data for module without new define (= a + 1)
------------------------------------------------------
History:
02-03-2016: First Version by Garfield
02-03-2016: First verified by Define_Scope_test
***********************************************/
`timescale 10ns/100ps

module sub_called_without
  ( 
    input[`WIDTH - 1:0] a,
    output[`WIDTH - 1:0] result
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logic
assign result = a + 1;

endmodule

/***********************************************
Module Name:   Sub_Called_With
Feature:       Called sub-modules with new width define
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a, 8 bits(defined),operents
Output Ports:  result, 8 bits(defined), data for module without new define (= a + 1)
------------------------------------------------------
History:
02-03-2016: First Version by Garfield
02-03-2016: First verified by Define_Scope_test
***********************************************/
`timescale 10ns/100ps
`define WIDTH 7

module sub_called_with
  ( 
    input[`WIDTH - 1:0] a,
    output[`WIDTH - 1:0] result
  );
  
//Load other module(s)

//Definition for Variables in the module

//Logic
assign result = a + 1;

endmodule