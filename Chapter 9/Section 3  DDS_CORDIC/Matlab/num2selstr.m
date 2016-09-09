function num_str = num2selstr(num, number_line)
%Generate selection string for verilog
%    num: line number
%    number_line: total lines' number
num_str='';

if ( num == number_line)
    for i = 1:number_line-1;
        num_str = strcat( '0',num_str);
    end
else
    for i = 1:number_line-1;
        if (i >= num)
            num_str = strcat( '1',num_str);
        else
            num_str = strcat('0', num_str);
        end
        
    end
end
