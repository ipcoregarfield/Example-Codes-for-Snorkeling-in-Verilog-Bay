/***********************************************
Module Name:   top_adder_line_generate
               Two adders with 4 bits and 6 bits width
Feature:       Line adeder with parameter input bit width
               Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a10,a11, 4 bits, operents
               a20,a21, 6 bits, operents
Output Ports:  sum1,sum2, results
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by adder_line_generate_test  ISE/Modelsim
***********************************************/
`define WIDTH1 4
`define WIDTH2 6
module  top_adder_line_generate
 ( 
    input[`WIDTH1 - 1 :0] a10, a11,
    output[`WIDTH1 :0] sum1,
    input[`WIDTH2 - 1 :0] a20, a21,
    output[`WIDTH2 :0] sum2
  );


//Load other module(s)
adder_line_generate #(.WIDTH(`WIDTH1))
      A1 (.a0(a10), .a1(a11), .sum(sum1));
      
adder_line_generate #(.WIDTH(`WIDTH2))
      A2 (.a0(a20), .a1(a21), .sum(sum2));      

//Definition for Variables in the module

//Carried bits in the line

endmodule

/***********************************************
Module Name:   adder_line_generate
Feature:       Line adeder with parameter input bit width
               Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a0,a1, operents with parameter bit width
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  sum, result
------------------------------------------------------
History:
02-05-2016: First Version by Garfield
02-05-2016: First verified by adder_line_generate_test  ISE/Modelsim
***********************************************/
module  adder_line_generate #(parameter WIDTH = 8)
 ( 
    input[WIDTH - 1 :0] a0, a1,
    output[WIDTH :0] sum
  );
//Definition for Variables in the module
wire[WIDTH - 1:0]  c;
//Carried bits in the line

//Load other module(s)
half_adder HALF_ADDER(.a0(a0[0]), .a1(a1[0]), 
          .s(sum[0]),.c1(c[0]));
//First bit: half adder
          
generate
//Other bits: full adder
genvar loop;
begin
    for (loop = 1; loop < WIDTH; loop = loop + 1)
    begin: FULL_ADDER
        full_adder F(.a0(a0[loop]), .a1(a1[loop]), .c0(c[loop - 1]),
                 .s(sum[loop]), .c1(c[loop]) );
    end
end
endgenerate

//Logic
assign sum[WIDTH] = c[WIDTH-1];
//Carried bit for the result
endmodule