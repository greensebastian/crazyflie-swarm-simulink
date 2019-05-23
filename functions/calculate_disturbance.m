function [dir, magn] = calculate_disturbance(dist, option)
%CALCULATE_DISTURBANCE Calculate direction and magnitude of force from
%   disturbance
%   dist is relative position [x;y;z;magnitude] of drone and disturbance
distance = norm(dist(1:3));
dir = dist(1:3)/distance;
magnitude = dist(4);
switch option
    case 0 % Inverse cube
        magn = magnitude/distance^3;
    case 1 % Cutoff linear
        k = 1;
        cutoff = 0.5;
        magn = max(0, (cutoff-distance)*k);
    case 2 % Inverse root & slope
        k1 = -1.5;
        k2 = 0.5;
        k3 = 1.5;
        ampl = k1*distance+k2/sqrt(distance) + k3;
        magn = max(0, ampl * magnitude);
    case 3 % Inverse cube & cutoff
        k1 = -1;
        k2 = 1.5;
        k3 = 0;
        magn = max(0, k1*distance+k2/distance + k3);        
    case 4 %Inverse cube & cutoff Distance controller
        k1 = -0.3;
        k2 = 0.9;
        k3 = 0;
        magn = max(0, k1*distance+k2/distance + k3);
    case 5 % Inverse root & slope
        k1 = -1;
        k2 = 1;
        k3 = 0;
        ampl = k1*distance+k2/sqrt(distance) + k3;
        magn = max(0, ampl * magnitude);
    case 6 % Linear from 2m
        k1 = -1;
        k3 = 1.5;
        magn = max(0, k1*distance + k3);
    otherwise
        magn = 0;
end

