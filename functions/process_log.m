function [state, control, ref, result] = process_log(timestamps_control, timestamps_state, timestamps_ref, control, state, ref)
%PROCESS_LOG Process information retrieved from python logs
%   control and state should be in the form [d01_state; d02_state ...]
[nx, X1] = size(state);
[~, X2] = size(control);
[~, X3] = size(ref);
X = min([X1, X2, X3]) - 1;
N = nx/6;

state = reshape(state, 6, N, []);
result.x = reshape(state(1,:,end-X:end), N, []);
result.y = reshape(state(2,:,end-X:end), N, []);
result.z = reshape(state(3,:,end-X:end), N, []);
result.vx = reshape(state(4,:,end-X:end), N, []);
result.vy = reshape(state(5,:,end-X:end), N, []);
result.vz = reshape(state(6,:,end-X:end), N, []);
result.rate_state = mean(diff(timestamps_state));

ref = reshape(ref, 3, 1, []);
ref = repmat(ref, [1, N]);
result.ux = reshape(ref(1,:,end-X:end), N, []);
result.uy = reshape(ref(2,:,end-X:end), N, []);
result.uz = reshape(ref(3,:,end-X:end), N, []);
result.rate_ref = mean(diff(timestamps_ref));

control = reshape(control, 3, N, []);
result.uvx = reshape(control(1,:,end-X:end), N, []);
result.uvy = reshape(control(2,:,end-X:end), N, []);
result.uvz = reshape(control(3,:,end-X:end), N, []);
result.rate_control = mean(diff(timestamps_control));

outx = {'x1', 'x2', 'x3', 'x4', 'x5'};
outy = {'y1', 'y2', 'y3', 'y4', 'y5'};
outz = {'z1', 'z2', 'z3', 'z4', 'z5'};
outvx = {'vx1', 'vx2', 'vx3', 'vx4', 'vx5'};
outvy = {'vy1', 'vy2', 'vy3', 'vy4', 'vy5'};
outvz = {'vz1', 'vz2', 'vz3', 'vz4', 'vz5'};

result.data_x = iddata(result.x', result.ux', result.rate_state, ...
    'OutputName', outx(1:N));
result.data_y = iddata(result.y', result.uy', result.rate_state, ...
    'OutputName', outy(1:N));
result.data_z = iddata(result.z', result.uz', result.rate_state, ...
    'OutputName', outz(1:N));
result.data_vx = iddata(result.vx', result.uvx', result.rate_state, ...
    'OutputName', outvx(1:N));
result.data_vy = iddata(result.vy', result.uvy', result.rate_state, ...
    'OutputName', outvy(1:N));
result.data_vz = iddata(result.vz', result.uvz', result.rate_state, ...
    'OutputName', outvz(1:N));

end

