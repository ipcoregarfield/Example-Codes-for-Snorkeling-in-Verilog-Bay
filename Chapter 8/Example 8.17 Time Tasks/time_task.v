`timescale 10ns/100ps

module time_task;
time t_1, t_2;
realtime r_t_1, r_t_2;
reg[63:0] reg_a;
time time_gap;

initial
begin
    $printtimescale(time_task);
    //Display si,\mulation time information
        
    t_1 = $time();
    r_t_1 = $realtime();
    //Get time
    reg_a = 64'd30;
    //Assign the reg variable
    
    $display("time1 = %t", t_1);
    $display("realtime1 = %t", r_t_1);
    $display("time reg_a = %t", reg_a);
         
    #15
    t_2 = $time();
    r_t_2 = $realtime();
    //Get time
    time_gap = t_2 - t_1;
    //Assign the reg variable
    
    $display("15 simulation time delayed\ntime2 = %t", t_2);
    $display("realtime2 = %t", r_t_2);
    $display("time difference between time2 and time1 = %t", time_gap);
    
    $timeformat( -6, 3, "  us", 10);
    //Change format
    $display("Format changed: time2 = %t", t_2);
    $display("Format changed: realtime2 = %t", r_t_2);
end
endmodule