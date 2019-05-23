function [b,a] = get2plpfargs(sample_rate, cutoff_freq)
%get2plpfargs Compute low-pass filter arguments
%   Detailed explanation goes here

b_t = zeros(1, 3);
a_t = zeros(1, 2);

sample_freq = 1/sample_rate;

fr = sample_freq/cutoff_freq;
ohm = tan(pi/fr);
c = 1 + 2*cos(pi/4)*ohm + ohm^2;

b_t(1) = ohm*ohm/c;
b_t(2) = 2*b_t(1);
b_t(3) = b_t(1);

a_t(1) = 2*(ohm^2-1)/c;
a_t(2) = (1-2*cos(pi/4)*ohm + ohm^2)/c;

b = b_t;
a = a_t;
end

