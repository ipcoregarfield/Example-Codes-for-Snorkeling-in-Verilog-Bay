/***********************************************
Module Name:   CORDIC_Element
Feature:       One step CORDIC calculation
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock
               Reset: System reset
               x_k, y_k, z_k: result from pre-step
Output Ports:  x_k1, y_k1, z_k1: result of this step
------------------------------------------------------
History:
03-19-2016: First Version by Garfield
03-19-2016: Verified by DDS_Line_test
***********************************************/

module CORDIC_elemet
#(parameter ADDRESS_WIDTH = 8,
//Address bit width for z_k
parameter VALUE_WIDTH = 8,
//Output value's bit width, internal one, for x_k and y_k
parameter[ADDRESS_WIDTH - 1 : 0] e_k = 2**(ADDRESS_WIDTH - 1),
//The rotation angle in this step
parameter ORDER = 0)
//Order of this element


  ( 
    input CLK,
    input RESET,
    input signed[VALUE_WIDTH : 0] x_k,
    input signed[VALUE_WIDTH : 0] y_k,
    input signed[ADDRESS_WIDTH : 0] z_k,
    output reg signed[VALUE_WIDTH : 0] x_k1,
    output reg signed[VALUE_WIDTH : 0] y_k1,
    output reg signed[ADDRESS_WIDTH : 0] z_k1
  );

//Defination for Varables in the module
wire d_k;

//Logicals
assign d_k = z_k[ADDRESS_WIDTH];
//Get the symbol of z_k

//z_k calculation
//Angle rotation operation
always @ (posedge CLK or negedge RESET)
begin
    if (!RESET)
    begin
        z_k1 <= {(ADDRESS_WIDTH){1'b0}};
    end
    else if (d_k == 1'b0)
    //d_k is positive or zero
    begin
        z_k1 <= z_k -{1'b0, e_k};
    end
    else
    //d_k is positive or zero
    begin
        z_k1 <= z_k + {1'b0, e_k};
    end
end

//x_k and z_k calculation
//Value operation
always @ (posedge CLK or negedge RESET)
begin
    if (!RESET)
    begin
        x_k1 <= {(VALUE_WIDTH){1'b0}};
    end
    else if (d_k == 1'b0)
    //d_k is positive or zero
    begin
        x_k1 <= x_k - (y_k>>>ORDER);
    end
    else
    //d_k is negative
    begin
        x_k1 <= x_k + (y_k>>>ORDER);
    end
end

always @ (posedge CLK or negedge RESET)
begin
    if (!RESET)
    begin
        y_k1 <= {(VALUE_WIDTH){1'b0}};
    end
    else if (d_k == 1'b0)
    //d_k is positive or zero
    begin
        y_k1 <= y_k + (x_k>>>ORDER);
    end
    else
    //d_k is negative
    begin
        y_k1 <= y_k - (x_k>>>ORDER);
    end
end
endmodule