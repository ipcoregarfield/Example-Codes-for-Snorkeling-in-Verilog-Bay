/***********************************************
Module Name:   Sum_Paralell_Enable
Feature:       8 bits summer, 128 input per group 
Coder:         Garfield
Organization:  XXXX Group, Department of Architecture
------------------------------------------------------
Input ports:   input_data, 8 bits, operents
							 data_start, 1 bit, first data flag
               CLK, 1bit clock
               RST, 1 bit, reset
Output Ports:  sum, 17 bits, sum of the 128 inputs
               sum_enable, 1 bit, right result output flag
------------------------------------------------------
History:
01-13-2016: First Version by Garfield
01-13-2016: First verified by Sum_Paralell_Enable_test  ISE/Modelsim
***********************************************/

module sum_parallel_enable
  ( 
    input[7:0] input_data,
    input data_start,
    input CLK, input RST,
    output reg[16:0] sum,
    output reg sum_enable
  );

//Definition for Variables in the module
reg[7:0] count;
//For 7 bits timer
reg[3:0] enables;
//Phased enable
reg[2:0] count1;
//For 2 bits timer

reg[7:0] data1, data2, data3, data4;
//Sample for 4 paralell operation modules
reg [14:0] sum1, sum2,sum3, sum4;
//Result (sum) for 4 paralell operation modules

//Load other module(s)

//Logical

always @(posedge CLK or negedge RST)
//7 bits timer
begin
    if (!RST)
    //Reset
    begin
        count <= 8'h00;
    end
    else if(data_start)
    begin
        count <= 8'h7f + 8'h04;  
        //Constant 4 is for 4 clock delay for last 4 data input
        //Constant 7f for 128 total data      
    end 
    else if (count != 8'h00)
    begin
        count <= count - 8'h01;      	
    end
    else
    begin
        count <= 8'h00;      	
    end
end

always @(posedge CLK or negedge RST)
//7 bits timer
begin
    if (!RST)
    //Reset
    begin
        enables <= 4'b0000;
    end
    else if (data_start)
    begin
        enables <= 4'b0001;
    end
    else if (count != 8'h00)
    begin
        enables <= {enables[2:0], enables[3]}; 
        //Circled for phases     	
    end
    else
    begin
        enables <= 4'b0000;      	
    end
end

always @(posedge CLK or negedge RST)
//2 bits timer
begin
    if (!RST)
    //Reset
    begin
        count1 <= 3'b000;
    end
    else if(count == 7'h01)
    begin
        count1 <= 3'b111;        
    end 
    else if (count1 != 3'b000)
    begin
        count1 <= count1 - 3'b001;      	
    end
end

always @(posedge CLK or negedge RST)
//Sample for branch 1
begin
    if (!RST)
    //Reset
    begin
        data1 <= 8'h00;
    end
    else if  (count != 8'h00) 
    begin
        if (enables[0])
        begin
            data1 <= input_data;
        end
    end
    else
    begin
        data1 <= 8'h00;
   end    
end

always @(posedge CLK or negedge RST)
//Sample for branch 2
begin
    if (!RST)
    //Reset
    begin
        data2 <= 8'h00;
    end
    else if(count != 8'h00)
    begin
        if (enables[1])
        begin
            data2 <= input_data;
        end
    end
    else
    begin
        data2 <= 8'h00;
   end    
end

always @(posedge CLK or negedge RST)
//Sample for branch 3
begin
    if (!RST)
    //Reset
    begin
        data3 <= 8'h00;
    end
    else if(count != 8'h00)
    begin
        if (enables[2])
        begin
            data3 <= input_data;
        end
    end
    else
    begin
        data3 <= 8'h00;
   end    
end

always @(posedge CLK or negedge RST)
//Sample for branch 4
begin
    if (!RST)
    //Reset
    begin
        data4 <= 8'h00;
    end
    else if(count != 8'h00)
    begin
        if (enables[3])
        begin
            data4 <= input_data;
        end
    end
    else
    begin
        data4 <= 8'h00;
   end    
end

always @(posedge CLK or negedge RST)
//Paralell sum brach 1
begin
    if (!RST)
    //Reset
    begin
        sum1 <= 15'h0000;
    end
    else
    begin
        if (enables[0])
        begin
            sum1 <= sum1 + {7'h00, data1};
        end
    end
end

always @(posedge CLK or negedge RST)
//Paralell sum brach 2
begin
    if (!RST)
    //Reset
    begin
        sum2 <= 15'h0000;
    end
    else
    begin
        if (enables[1])
        begin
            sum2 <= sum2 + {7'h00, data2};
        end
    end
end

always @(posedge CLK or negedge RST)
//Paralell sum brach 3
begin
    if (!RST)
    //Reset
    begin
        sum3 <= 15'h0000;
    end
    else
    begin
        if (enables[2])
        begin
            sum3 <= sum3 + {7'h00, data3};
        end
    end
end

always @(posedge CLK or negedge RST)
//Paralell sum brach 4
begin
    if (!RST)
    //Reset
    begin
        sum4 <= 15'h0000;
    end
    else
    begin
        if (enables[3])
        begin
            sum4 <= sum4 + {7'h00, data4};
        end
    end
end

always @(posedge CLK or negedge RST)
//Sum
begin
    if (!RST)
    //Reset
    begin
        sum <= 17'h0_0000;
    end
    else
    begin
        sum <= {2'h0,sum1} + {2'h0,sum2} + {2'h0,sum3} + {2'h0,sum4}; 
    end
end

always @(posedge CLK or negedge RST)
//Sum
begin
    if (!RST)
    //Reset
    begin
        sum_enable <= 1'b0;
    end
    else if (count1 == 3'b001)
    begin 
        sum_enable <= 1'b1; 
    end
    else
    begin 
        sum_enable <= 1'b0; 
    end
end
endmodule