/***********************************************
Module Name:   Complex_Multiplication_test
Feature:       Testbench for Complex_Multiplication
               An example for the book
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Variables:
         clk: clock for processing
         reset: reset flag
         clk_8: 8 period clok
         data_start: complex data start flag 
         
         EN: module counter input
         CLR: module counter input
         out_num: output port for the counter module, 8 bits 
			   sel: for selection, 2 bits
         OV: overflow flag
------------------------------------------------------
History:
01-19-2016: First Version by Garfield
***********************************************/
`timescale 10 ns/100 ps
//Simulation time assignment

//Insert the modules

module complex_multiplication_test;
//defination for Variables
reg clk;
reg reset;

wire EN;
wire CLR;
wire[15:0] out_num;

wire clk_8;
wire data_start;

wire signed[3:0] real_a, real_b, image_a, image_b;
//Data seperation
wire signed[6:0] real_1, real_2, image_1, image_2;
//Middle variable
wire signed[7:0] product_real, product_image;
//Outout by the module
wire signed[7:0] product_real1, product_image1;
//Result for verification

//Connection to the modules
counter16 C1(.clk(clk_8), .Reset(reset), .EN(EN), 
             .CLR(CLR), .counter(out_num));
//Data generation by a 16-bit counter as {real_a, real_b, image_s, image_b}
PLL P1(.clk(clk), .Reset(reset),
       .clk_8(clk_8), .data_start(data_start));
complex_multiplication C2 ( 
    .real_a(real_a), .image_a(image_a),
    .real_b(real_b), .image_b(image_b),
    .CLK(clk), .RST(reset),
    .data_start(data_start),
    .product_real(product_real), .product_image(product_image)  );

begin
   
    assign EN = 1'b1;
    assign CLR = 1'b0;
    
    assign real_a = out_num[15:12];
    assign real_b = out_num[11:8];
    assign image_a = out_num[7:4];
    assign image_b = out_num[3:0];
    
    assign real_1 = real_a * real_b;
    assign real_2 = image_a * image_b;
    assign image_1 = real_a * image_b;
    assign image_2 = image_a * real_b;
    
    assign product_real1 = real_1 - real_2;
    assign product_image1 = image_1 +image_2;
  
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
    
end

endmodule

/***********************************************
Module Name:   counter16
Feature:       16 bits counter
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
               EN: Enable signal to increase the counter
               CLR: Clear signal to make counter 0
Output Ports:  counter, 16 bits, result
------------------------------------------------------
History:
01-08-2016: First Version by Garfield
01-08-2016: Verified by Garfield with counter_test in Modelsim
***********************************************/

module counter16
  ( 
    input clk,
    input Reset,
    input EN,
    input CLR,
    output reg[15:0] counter
  );

//Defination for Varables in the module

//Logicals
//Combanitory logicals
always @ (posedge clk or negedge Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 16'h0000;
    end
    else if (CLR)
    //Clear the counter
    begin
        counter <= 15'h0000;
    end
    else if(EN)
    //Enable signal to increase counter
    begin
        counter <= counter + 16'h01;
    end
    else
    //Idle statement
    begin
    end
end

endmodule

/***********************************************
Module Name:   PLL
Feature:       8X clock PLL
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ 10 MHz
               Reset: System reset
Output Ports:  clk_8, 1 bit, 8X clock
               data_start, 1 bit, 1 at first 8X clock and 0 else
------------------------------------------------------
History:
01-19-2016: First Version by Garfield
01-19-2016: Verified by Garfield with PLL_test in Modelsim
***********************************************/

module PLL
  ( 
    input clk,
    input Reset,
    output reg clk_8,
    output reg data_start
  );

//Defination for Varables in the module
reg[2:0] counter;

//Logicals
//Combanitory logicals
always @ (posedge clk or negedge Reset)
//Counter operations
begin
    if ( !Reset)
    //Reset enable
    begin
        counter <= 3'h0;
    end
    else
    //Enable signal to increase counter
    begin
        counter <= counter + 3'h1;
    end
end

always @ (posedge clk or negedge Reset)
//8X clock operations
begin
    if ( !Reset)
    //Reset enable
    begin
        clk_8 <= 1'b1;
    end
    else
     begin
        clk_8 = ~counter[2];
    end
end

always @ (posedge clk or negedge Reset)
//Data_start flag operations
begin
    if ( !Reset)
    //Reset enable
    begin
        data_start <= 1'b0;
    end
    else if (counter == 3'h0)
    //First clock
    begin 
        data_start <= 1'b1;
    end
    else
    begin
        data_start <= 1'b0;
    end
end

endmodule