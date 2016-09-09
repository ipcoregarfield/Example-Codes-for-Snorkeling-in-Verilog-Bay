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
02-08-2016: First Version by Garfield
02-08-2016: First verified by adder_line_generate_test  ISE/Modelsim
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
02-08-2016: First Version by Garfield
02-08-2016: First verified by adder_line_generate_test  ISE/Modelsim
***********************************************/
module  adder_line_generate #(parameter WIDTH = 8)
 ( 
    input[WIDTH - 1 :0] a0, a1,
    output[WIDTH :0] sum
  );
//Definition for Variables in the module
          
generate
//Other bits: full adder
genvar loop;
begin
    for (loop = 0; loop < WIDTH; loop = loop + 1)
    begin: ADDER
    	  wire c;
    	  //Carried bit in the loop named ADDER[loop].c
    	  if (loop == 0)
    	  begin
    	      half_adder h(.a0(a0[loop]), .a1(a1[loop]),
                 .s(sum[loop]), .c1(c) );
    	  end
    	  else
    	  begin
    	  	  full_adder F(.a0(a0[loop]), .a1(a1[loop]), .c0(ADDER[loop-1].c),
                 .s(sum[loop]), .c1(c) );            	
        end
    end
end
endgenerate

//Logic
assign sum[WIDTH] = ADDER[WIDTH-1].c;
//The MLB of summery is set as the highest carried bit
endmodule