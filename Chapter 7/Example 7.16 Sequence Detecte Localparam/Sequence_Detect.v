/***********************************************
Module Name:   sequence_detect
Feature:       Sequence detect with FSM and localparam
               An example for the book
Coder:         Garfield
Organization:  xxxx Group, Department of Architecture
------------------------------------------------------
Input ports:   clk: System clock @ XXX MHz
               Reset: System reset
               data: data in bit, LSB in advance
Output Ports:  detected: Flag for sequence detected, 1 for true, eles 0
------------------------------------------------------
History:
04-01-2014: First Version by Garfield
04-01-2014: Verified by Garfield with sequence_detect_test in Modelsim
***********************************************/

`define SYNC_CODE   4'b1001
//Sequence to be detected

module sequence_detect
  ( 
    input clk,
    input Reset,
    input data,
    output reg detected
  );
localparam STATE_IDLE = 0;
localparam STATE_BIT0 = 1;
localparam STATE_BIT1 = 2;
localparam STATE_BIT2 = 3;
localparam STATE_BIT3 = 4;
//State definition

//Defination for Varables in the module
reg[3:0] state;

wire[3:0] detecting_sequnce;

//Logicals
//Combanitory logicals
assign detecting_sequnce = `SYNC_CODE;
//Timing
always @ (posedge clk or negedge Reset)
//Statement management part
begin
    if (!Reset)
    //Reset enable
    begin
        state <= STATE_IDLE;
    end
    else 
    //state change
    begin
        case (state)
            STATE_IDLE:
            //Idle statement, waiting for bit 0
            begin
                if ( data == detecting_sequnce[0])
                //Bit 0 detected
                begin
                    state <= STATE_BIT0;
                end
                else
                begin
                end
            end
            
            STATE_BIT0:
            //Bit0 statement, waiting for bit 1 or return idle
            begin
                if ( data == detecting_sequnce[1])
                //Bit 1 detected
                begin
                    state <= STATE_BIT1;
                end
                else
                //Return idle statement
                begin
                    state <= STATE_IDLE;
                end
            end
            
            STATE_BIT1:
            //Bit1 statement, waiting for bit 2 or return idle
            begin
                if ( data == detecting_sequnce[2])
                //Bit 2 detected
                begin
                    state <= STATE_BIT2;
                end
                else
                //Return idle statement
                begin
                    state <= STATE_IDLE;
                end
            end
            
            STATE_BIT2:
            //Bit2 statement, waiting for bit 3 or return idle
            begin
                if ( data == detecting_sequnce[3])
                //Bit 2 detected
                begin
                    state <= STATE_BIT3;
                end
                else
                //Return idle statement
                begin
                    state <= STATE_IDLE;
                end
            end
            
            STATE_BIT3:
            //Bit3 statement, return idle
            begin
            //Return idle statement
            state <= STATE_IDLE;
            end
            
            default:
            begin
            //Return idle statement
            state <= STATE_IDLE;
            end
        endcase
    end
end

always @ (posedge clk or negedge Reset)
//Output part
begin
    if (!Reset)
    //Reset enable
    begin
        detected <= 1'b0;
    end
    else if (STATE_BIT3 == state)
    //Sequence detected
    begin
        detected <= 1'b1;
    end
    else 
    //Idle and detecting
    begin
        detected <= 1'b0;
    end
end

endmodule