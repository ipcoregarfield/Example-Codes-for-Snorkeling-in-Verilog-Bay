/***********************************************
Module Name:   Complex_Multiplication_Pipeline
Feature:       Complex number multiplication with 4 bits signedreal-part and image-part
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   real_a, image_a, 4 bits signed real amd image parts of a, the oprent
               real_b, image_b, 4 bits signed real amd image parts of b, the oprent
               CLK, 1bit clock
               RST, 1 bit, reset
               data_start, 1 bit, data start flag
Output Ports:  product_real, product_image: 7 bits signed real amd image parts of a * b
------------------------------------------------------
History:
01-19-2016: First Version by Garfield
01-19-2016: First verified by Complex_Multiplication_test  ISE/Modelsim
***********************************************/
`define REAL_REAL   0
`define IMAGE_IMAGE 1
`define REAL_IMAGE  2
`define IMAGE_REAL  3
//Input statements

`define REAL_1      2
`define REAL_2      3
`define IMAGE_1     4
`define IMAGE_2     5
//Output statements

module complex_multiplication
//Multiplication in pipeline
  ( 
    input signed[3:0] real_a,
    input signed[3:0] image_a,
    input signed[3:0] real_b,
    input signed[3:0] image_b,
    input CLK, input RST,
    input data_start,
    output reg signed[7:0] product_real,
    output reg signed[7:0] product_image
  );

//Definition for Variables in the module
reg signed[6:0] real_1, real_2;
//Two operents for real part
reg signed[6:0] image_1, image_2;
//Two operents for image part
reg signed[3:0] a, b;
//Operents for signed multiplication
reg signed[6:0] product;
//Result for multiplication
reg[2:0] state_counter;
//Counter for scheduling statements

//Load other module(s)
                                                                                   
//Logical
always @(posedge CLK or negedge RST)
//Multiplication to be reused
begin
    if (!RST)
    begin
        product <= 7'sh0;
    end
    else
    //Statement counting
    begin
        product <= a * b;
    end
end 

always @(posedge CLK or negedge RST)
//Statement management
begin
    if (!RST)
    begin
        state_counter <= 3'h7;
    end
    else if (data_start)
    //New data and start the statement counting
    begin
        state_counter <= 3'h0;
    end
    else
    //Statement counting
    begin
        state_counter <= state_counter + 3'h1;
    end
end

//Reused multiplication part
always @(posedge CLK or negedge RST)
//Input Part
begin
    if (!RST)
    begin
        a <= 4'h0;
        b <= 4'h0;
    end
    else
    //Input Operations
    begin
        case (state_counter)
            `REAL_REAL: 
            begin
                a <= real_a;
                b <= real_b;
            end
            `IMAGE_IMAGE: 
            begin
                a <= image_a;
                b <= image_b;
            end
            `REAL_IMAGE: 
            begin
                a <= real_a;
                b <= image_b;
            end  
            `IMAGE_REAL: 
            begin
                a <= image_a;
                b <= real_b;
            end                                  
        endcase
    end
end

always @(posedge CLK or negedge RST)
//Output Part
begin
    if (!RST)
    begin
        real_1 <= 7'h0;
        real_2 <= 7'h0;
        image_1 <= 7'h0;   
        image_2 <= 7'h0;                             
    end
    else
    //Input Operations
    begin
        case (state_counter)
            `REAL_1: 
            begin
                real_1 <= product;
            end
            `REAL_2: 
            begin
                real_2 <= product;
            end
            `IMAGE_1: 
            begin
                image_1 <= product;
            end  
            `IMAGE_2: 
            begin
                image_2 <= product;
            end                                  
        endcase
    end
end

//Adder part
always @(posedge CLK or negedge RST)
//Input Part
begin
    if (!RST)
    begin
        product_real <= 8'sh0;
        product_image <= 8'sh0;
    end
    else
    //Input Operations
    begin
        product_real <= real_1 - real_2;
        product_image <= image_1 + image_2;
    end
end
endmodule

