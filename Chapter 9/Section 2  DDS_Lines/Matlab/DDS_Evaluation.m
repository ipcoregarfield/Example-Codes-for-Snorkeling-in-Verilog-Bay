function [ SNR, Peak_2nd_rate ] = DDS_Evaluation( file_name )
%Evaluate the DDS sin function performence
%by FFT

values = importdata(file_name);
%Get the raw data

VALUE = fft(values);
len = length(VALUE);
%FFT
VALUE_AC = VALUE(2:len/2);
%Detelete DC value and only half spretrum 
%Tips: real signal
abs_V = abs(VALUE_AC);
len_half = length(abs_V);

[Peak, num] = max(abs_V);
%Peak search

Depeak = abs_V;
Depeak(num) = 0;
Peak_2 = max(Depeak);
%2nd Peak value

noise = sum(Depeak.^2);
%Total noise value

SNR = 10*log10(Peak^2/noise);
%SNR in dB
Peak_2nd_rate = 20*log10(Peak/Peak_2);
%Peak to 2nd peak ratio

%Draw figures
figure();
plot(values);
axis('tight');
title('DDS Generate Function Values')
grid

figure();
plot(abs_V.^2);
axis('tight');
title('FFT of Values')
grid
end