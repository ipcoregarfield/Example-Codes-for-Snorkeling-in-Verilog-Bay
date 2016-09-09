function [ points, max_err ] = sin2line_point( limit, step, draw)
%Approx. sin function with lines
%   limit: maximum allowed error
%   step: delta_angle fro sin

%   draw: draw the figures flag
%   points: changing points
%   max_err: maximum error
points=[];
max_err = 0;
%Initial

x = 0 : pi/2/(step-1) : pi/2;
%Points on x can be selected

sin_value = sin(x);
%sin value


start_point = 1;
%Start of the line

for end_point = 2 : length(x)
    %Seach points
    delta_line = sin_value(end_point) - sin_value(start_point);
    delta_line = delta_line / (end_point - start_point +1);
    %step on the line
    line = delta_line * ((start_point: end_point) - start_point);
    line = sin_value(start_point) + line;
    %values for the line
    
    sin_part = sin_value(start_point : end_point);
    %sin with that start and end
    
    err = max(abs(line - sin_part));
    %maximum error
    if ( err > max_err)
        max_err = err;
    end
    
    if (err > limit)
        start_point = end_point - 1;
        %recording the farrest point
        points = [points, start_point];
    end
end

points = [points, end_point];
%add pi/2
if (draw == 1)
    hold on;
    line_y = sin_value(points);
    line_x = (points - 1) * pi/2/(step-1);
    %lines calculate
    
    subplot(2,1,1);
    plot(line_x, line_y,'r+-');
    hold on;
    plot(x, sin_value,'b');
    grid on
    xlim([0,pi/2]);
    ylim([0, 1]);
    legend('sin and lines');
    %sin+lines draw
    
    err_value =[0];
    %initial
    start_point = 1;
    for loop = 2 : length(points)
        %Seach points
        end_point = points(loop);
        delta_line = sin_value(end_point) - sin_value(start_point);
        delta_line = delta_line / (end_point - start_point +1);
        %step on the line
        line = delta_line * ((start_point: end_point) - start_point);
        line = sin_value(start_point) + line;
        %values for the line
        
        sin_part = sin_value(start_point : end_point);
        %sin with that start and end
        
        err = abs(line - sin_part);
        %error
        err_value = [err_value, err(2:length(err))];
        
        start_point = end_point;
        %move to next line
    end
    %calculate error values
    
    subplot(2,1,2);
    
    plot(x, err_value,'k');
    grid on
    xlim([0,pi/2]);
    %error draw
    max_err = max(err_value);
    legend(['error and max-err = ' , num2str(max_err)]);
end
end

