/***********************************************
Module Name:   Multiplication_Pipeline
Feature:       8 bits unsigned numbers multiplication 
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   a,b , 8 bits, operents unsigned
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  product: 16 bits, = a * b
------------------------------------------------------
History:
01-15-2016: First Version by Garfield
01-15-2016: First verified by Multiplication_Pipeline_test  ISE/Modelsim
***********************************************/
module multiplication_pipeline
//Multiplication in pipeline
  ( 
    input[7:0] a,
    input[7:0] b,
    input CLK, input RST,
    output[15:0] product
  );

//Definition for Variables in the module
wire[7:0] a0, a1, a2, a3, a4, a5, a6, a7;
//In a's delay chain
wire[7:0] b0;
wire[6:0] b1;
wire[5:0] b2;
wire[4:0] b3;
wire[3:0] b4;
wire[2:0] b5;
wire[1:0] b6;
wire b7;
//In b's delay chain
wire [7:0] result1;
wire [9:0] result2;
wire [10:0] result3;
wire [11:0] result4;
wire [12:0] result5;
wire [13:0] result6;
wire [14:0] result7;
wire [15:0] result8;
//In Result's Chain

//Load other module(s)
mul_pipe_step1 M1(.a_prev(a0),.b_prev(b0),
                  .CLK(CLK), .RST(RST),
                  .a_next(a1),.b_next(b1),.result_next(result1));
                  
mul_pipe_step2 M2(.a_prev(a1),.b_prev(b1),.result_prev(result1),
                  .CLK(CLK), .RST(RST),
                  .a_next(a2),.b_next(b2),.result_next(result2));                  

mul_pipe_step3 M3(.a_prev(a2),.b_prev(b2),.result_prev(result2),
                  .CLK(CLK), .RST(RST),
                  .a_next(a3),.b_next(b3),.result_next(result3));  
                  
mul_pipe_step4 M4(.a_prev(a3),.b_prev(b3),.result_prev(result3),
                  .CLK(CLK), .RST(RST),
                  .a_next(a4),.b_next(b4),.result_next(result4));    
                  
mul_pipe_step5 M5(.a_prev(a4),.b_prev(b4),.result_prev(result4),
                  .CLK(CLK), .RST(RST),
                  .a_next(a5),.b_next(b5),.result_next(result5)); 
                  
mul_pipe_step6 M6(.a_prev(a5),.b_prev(b5),.result_prev(result5),
                  .CLK(CLK), .RST(RST),
                  .a_next(a6),.b_next(b6),.result_next(result6));   
                  
mul_pipe_step7 M7(.a_prev(a6),.b_prev(b6),.result_prev(result6),
                  .CLK(CLK), .RST(RST),
                  .a_next(a7),.b_next(b7),.result_next(result7));  
                  
mul_pipe_step8 M8(.a_prev(a7),.b_prev(b7),.result_prev(result7),
                  .CLK(CLK), .RST(RST),
                  .result_next(result8));                                                                                      
//Logical
assign a0 = a;
assign b0 = b;
assign product = result8;

endmodule

module mul_pipe_step1
//Step1 in pipeline
  ( 
    input[7:0] a_prev,
    input[7:0] b_prev,
//  input result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[6:0] b_next,
    output reg[7:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 7'h00;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[7:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 9'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <= a_prev;
        end
        else
        begin
            result_next <= 8'h00;
        end
    end 
end

endmodule

module mul_pipe_step2
//Step2 in pipeline
  ( 
    input[7:0] a_prev,
    input[6:0] b_prev,
    input[7:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[5:0] b_next,
    output reg[9:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 6'h00;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[6:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 10'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={2'b0, result_prev} + {1'b0, a_prev, 1'b0};
            // = result + (a << 2)
            //max bit width 10
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step3
//Step3 in pipeline
  ( 
    input[7:0] a_prev,
    input[5:0] b_prev,
    input[9:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[4:0] b_next,
    output reg[10:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 5'h00;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[5:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 11'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={1'b0, result_prev} +{1'b0, a_prev, 2'b00};
            // = result + (a << 3)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step4
//Step4 in pipeline
  ( 
    input[7:0] a_prev,
    input[4:0] b_prev,
    input[10:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[3:0] b_next,
    output reg[11:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 4'h0;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[4:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 12'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={1'b0, result_prev} + {1'b0, a_prev, 3'b000};
            // = result + (a << 4)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step5
//Step5 in pipeline
  ( 
    input[7:0] a_prev,
    input[3:0] b_prev,
    input[11:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[2:0] b_next,
    output reg[12:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 3'h0;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[3:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 13'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={1'b0, result_prev} + {1'b0, a_prev, 4'b0000};
            // = result + (a << 5)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step6
//Step6 in pipeline
  ( 
    input[7:0] a_prev,
    input[2:0] b_prev,
    input[12:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg[1:0] b_next,
    output reg[13:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 2'h0;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[2:1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 14'h000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={1'b0, result_prev} + {1'b0, a_prev, 5'b0_0000};
            // = result + (a << 1)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step7
//Step7 in pipeline
  ( 
    input[7:0] a_prev,
    input[1:0] b_prev,
    input[13:0] result_prev,
    input CLK, input RST,
    output reg[7:0] a_next,
    output reg b_next,
    output reg[14:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        a_next <= 8'h00;
        b_next <= 1'h0;
    end
    else 
    begin
        a_next <= a_prev;
        b_next <= b_prev[1];
    end 
end

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 15'h0000;
    end
    else 
    begin
        if (b_prev[0])
        begin
            result_next <={1'b0, result_prev} + {1'b0, a_prev, 6'b00_0000};
            // = result + (a << 1)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule

module mul_pipe_step8
//Step7 in pipeline
  ( 
    input[7:0] a_prev,
    input b_prev,
    input[14:0] result_prev,
    input CLK, input RST,
//  output reg[7:0] a_next,
//  output reg b_next,
    output reg[15:0] result_next
  );

//Definition for Variables in the module

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//Staoring for input delay
begin
    if (!RST)
    //Reset
    begin
        result_next <= 16'h0000;
    end
    else 
    begin
        if (b_prev)
        begin
            result_next <={1'b0, result_prev} + {1'b0, a_prev, 7'b000_0000};
            // = result + (a << 1)
        end
        else
        begin
            result_next <= {1'b0, result_prev};
        end
    end 
end

endmodule