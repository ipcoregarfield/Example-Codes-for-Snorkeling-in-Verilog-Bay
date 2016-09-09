module display_task;

reg a, b, c;

initial
//Variables assignment
begin: a_b_assignment
    $monitor ("%0t %m a = %b, b = %b",
              $time, a, b);
        
    #100
    {a, b} = 2'b01;
    c = 1;
    b <= 1'b0;
    //Assign two times at the same time
    
    #100
    {a, b} = 2'b10;
    c = 1'bz;
    
    #100
    {a, b} = 2'b11;
    c = 1'b0;
end 

initial
//Monitor task
begin: extra
    $monitor("%0t %m c = %b", $time, c);
    $monitor("%0t 2nd monitor task c = %b", $time, c);
end

always @(*)
//Strobe task
begin: strobe
    $strobe("%0t %m STROBE_ALWAYS:a = %b, b = %b, c = %b", 
               $time, a, b, c);
end

always @(*)
//Display task
begin: display
    $display("run %0t %m DISPLAY_ALWAYS:a = %b, b = %b, c = %b", 
               $time, a, b, c);
end

endmodule