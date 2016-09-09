`timescale 10ns/100ps

module commline_control;
localparam CHAR_LENGTH = 8;
//Length of one char
reg[8:0] comm_value_int;
real comm_value_real;
reg[CHAR_LENGTH*32 - 1: 0] comm_value_str;
//Values inputted by command line

initial
begin
    if ($test$plusargs("HELLO"))
    begin
        $display("HELLO inputted");
    end
    else
    begin
        $display("No HELLO inputted");
    end
    //String command line
    $stop();
    
    #10
    if ($value$plusargs("integer=%d", comm_value_int))
    begin
        $display("Integer inputted, value = %d", comm_value_int);
    end
    else
    begin
        $display("No Integer inputted");
    end
    //Integer command line 
    $stop(1);
    
    #10
    if ($value$plusargs("real=%g", comm_value_real))
    begin
        $display("Real inputted, value = %g", comm_value_real);
    end
    else
    begin
        $display("No Real inputted");
    end
    //Real command line
    $stop(2);
    
    #10
    if ($value$plusargs("string=%s", comm_value_str))
    begin
        $display("String inputted, value = %s", comm_value_str);
    end
    else
    begin
        $display("No string inputted");
    end
    //Real command line
    
    $finish;
end
endmodule