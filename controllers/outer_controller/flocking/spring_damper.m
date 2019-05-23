function F = spring_damper(d, param)
%SPRING_DAMPER spring-damper function based on distance d
%   Generate force F acting on spring based on distance d through formula
d = abs(d);
F = param.gain*(param.k1./(d.^param.pow) - param.k2*d);
end

