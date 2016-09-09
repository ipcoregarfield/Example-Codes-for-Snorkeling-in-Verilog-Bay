//Error display for include

`line 25 "right.v" 2
wire error1;

always @ (clk)
//Error here
begin
    error1 = 1'b1;
end