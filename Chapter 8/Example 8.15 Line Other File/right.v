//No Error here

`line 50 "right.v" 2
reg right;

always @ (clk)
//Error here
begin
    right = 1'b1;
end