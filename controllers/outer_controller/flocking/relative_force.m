function [force, dir, magn, dist] = relative_force(er, params, option)
%RELATIVE_FORCE Summary of this function goes here
%   Detailed explanation goes here
e_pos = er(1:3);
e_vel = -er(4:6);
dist = max([norm(e_pos), 0.05]); % Absolute distance, 5cm default for first cycle
dir = e_pos/dist;
magn = dist;

switch option
    case 1 % Linear
        magn = dist;
    case 2 % Exponential
        a = 1;
        b = exp(1);
        c = 0;
        magn = a*b^(dist) + c;
        
    otherwise
        disp('Invalid relative_force option: ' + num2str(option))
end

force = dir * magn * params.r_rel + e_vel * params.rdot_rel;

end

