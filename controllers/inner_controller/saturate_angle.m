function ref_saturated = saturate_angle(desired, sat_angle)
%SATURATE_ANGLE Scale angle references to ensure hover thrust is achievable
%   Attitude is limited by maximum possible thrust as too steep angles
%   will render the rotors incapable of maintaining vertical velocity.
%   Desired is 3-by-1 column matrix of [roll; pitch; yaw] in degrees.
acc_dir = [sind(min(80, max(-80, desired(1))));
    sind(min(80, max(-80, desired(2))))];
vec_max_length = sind(sat_angle);
if(norm(acc_dir) > vec_max_length)
    out = acc_dir*vec_max_length/norm(acc_dir);
else
    out = [acc_dir; desired(3)];
end
out = [asind(out(1)); asind(out(2)); desired(3)];
ref_saturated = out;
end

