%% Script to process output state of simulation
% Convert 12-N-X matrix to X Y Z components for plotting using plot3
% 12 states, N drones, X timesteps
% input is time series "state"

[~, N, X] = size(state.data);

X = X - 1;

x = state.data(1,:,2:end);
x = reshape(x, N, X);

y = state.data(2,:,2:end);
y = reshape(y, N, X);

z = state.data(3,:,2:end);
z = reshape(z, N, X);

phi = state.data(7,:,2:end);
phi = reshape(phi, N, X);

theta = state.data(8,:,2:end);
theta = reshape(theta, N, X);

psi = state.data(9,:,2:end);
psi = reshape(psi, N, X);

t = state.TimeInfo.getData;
t = t(2:end)';

axis_limits = [min(min(x, [], 2)), max(max(x, [], 2));
    min(min(y, [], 2)), max(max(y, [], 2));
    min(min(z, [], 2)), max(max(z, [], 2))];

axis_range = max(axis_limits(:,2)) -  min(axis_limits(:,1));

x_axis_limits = [mean(axis_limits(1,:)) - axis_range/2, mean(axis_limits(1,:)) + axis_range/2];
y_axis_limits = [mean(axis_limits(2,:)) - axis_range/2, mean(axis_limits(2,:)) + axis_range/2];
z_axis_limits = [mean(axis_limits(3,:)) - axis_range/2, mean(axis_limits(3,:)) + axis_range/2];

% Reshape disturbances to 4-C-X
if (numel(size(disturbances_real.data)) > 2)
    dist_real = disturbances_real.data(:,:,2:end);
else
    dist_real = repmat(disturbances_real.data(2:end,:)', [1 1 1]);
    dist_real = reshape(dist_real, 4, 1, []);
end
[~, C, ~] = size(dist_real);


