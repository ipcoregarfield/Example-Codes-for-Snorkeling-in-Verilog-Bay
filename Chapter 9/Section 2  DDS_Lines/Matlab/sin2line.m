function [ points, a, b, max_err ] = sin2line( limit, step )
%Approx. sin function with lines method
%   limit: maximum allowed error
%   step: delta_angle fro sin

%   points: changing points
%   max_err: maximum error
%   a and b: ceofficients of the lines

[line.points, line.max_err] = sin2line_point(limit, step, 0);

line_x = (line.points - 1) * pi/2/(step-1);
line_y = sin(line_x);
%values

delta_x = [line_x(1), line_x(2:length(line_x)) - line_x(1:length(line_x)-1)];
delta_y = [line_y(1), line_y(2:length(line_y)) - line_y(1:length(line_y)-1)];
%deltas

line.a = delta_y./delta_x;
line.b =[0, line_y(2:length(line_y))] - line.a .*[0, line_x(2:length(line_x))];
%Calculate ceofficients
 points = line.points * pi/2/(step-1);
 max_err = line.max_err;
 a = line.a;
 b = line.b;
end

