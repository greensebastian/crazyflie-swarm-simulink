function R = eta2Rgb(eta, useDeg)
%ETA2RGB Converts eta to rotational matrix
%   Uses Tait-Bryan ZYX to convert given angles eta 3x1 matrix [x;y;z] to a
%   rotational matrix. Degrees if useDeg = 1, else radians.
    if useDeg
        eta = eta * pi/180;
    end
    Sphi = sin(eta(1)); Stheta = sin(eta(2)); Spsi = sin(eta(3));
    Cphi = cos(eta(1)); Ctheta = cos(eta(2)); Cpsi = cos(eta(3));
    
    R = [Cpsi*Ctheta, Cpsi*Stheta*Sphi-Spsi*Cphi, Cpsi*Stheta*Cphi + Spsi*Sphi;
        Spsi*Ctheta, Spsi*Stheta*Sphi+Cpsi*Cphi, Spsi*Stheta*Cphi - Cpsi*Sphi;
        -Stheta, Ctheta*Sphi, Ctheta*Cphi];
    R = transpose(R);
end

