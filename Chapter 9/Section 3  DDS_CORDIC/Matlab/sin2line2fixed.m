function [ points, a, b, max_err, max_err_fixed, max_err_float, value_fixed] = sin2line2fixed( limit, Address_Width, Value_Width )
%Approx. sin function with lines  fixed point
%   limit: maximum allowed error
%   Address_Width: LUT address bit width
%   Value_width: LUT Value bit width

%   points: fixed point changing points
%   max_err,max_err_float, max_err_fixed: maximum error value  
%                   of system, and method and fixed point
%   a and b: fixed point ceofficients for the lines
%   value: fixed point values as a test vector

step = 2^Address_Width;
%Get the step in float

[ points_f, a_f, b_f, max_err_float ] = sin2line( limit, step);
%Calculate the float result

points = ceil(points_f/( pi/2/(step-1)));
a = ceil(a_f * pi/2 * (2^Value_Width -1 ));
b = ceil(b_f * (2^Value_Width -1 ));
%Fixed point
b(1) = 0;
%Force sin(0) = 0;

value_fixed=[];
value_float=[];
err=[];
%initial

num = length(a);
for address=0:2^Address_Width-1
    x = pi/2/(step-1)*address;
    y = sin(x);
    %Get function value
      
    for line = 1: num
        if ( points(line) > address)
        %Found the line
            break;
        end
    end
   
    A = a(line);
    B = b(line);
    %Get ceofficients
    
    Y =floor( A * address / (2^Address_Width)) + B ;
    %Fixed point calculation
    
    Y_f = (a_f(line) * x + b_f(line)) * (2 ^ Value_Width -1);
    value_float = [value_float, Y_f];
    %Referred float value
   
    y_f = Y_f / (2 ^ Value_Width -1);
    value_fixed =[value_fixed, Y];
    err = [err, abs(y - y_f)];
    %Information collection
end

max_err = max(err);
max_err_fixed = max(abs(value_fixed - value_float)/(2^Value_Width-1));
%Get maximum error value
end