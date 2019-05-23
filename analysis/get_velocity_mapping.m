%% Script to generate quiver plot of velocity results in the plane
% Parameter specs
xrange = [-0.6 0.8]; % Meters
yrange = [-0.5 0.5]; % Meters
density = 0.03; % Arrows/m
point_size = 80;
ref = [0;0;0];
drones = [0.22, 0, 0, 0, 0, 0]';

x = xrange(1):density:xrange(2);
y = yrange(1):density:yrange(2);

[tx, ty] = meshgrid(x, y);
x = reshape(tx, 1, []);
y = reshape(ty, 1, []);
points = numel(x);

x = [x; y; zeros([4,points])];

if isempty(fc_params)
    disp('fc_params is not initialized')
    return
end

[~, N] = size(drones);
out = zeros(3, points);
for n=1:points
    e_r_ref = ref - x(1:3,n); % Position to reference
    e_r_ref_magn = norm(e_r_ref);
    e_r_ref_dir = e_r_ref/e_r_ref_magn;
    %e_rdot_ref = ref - x(4:6,i); % Velocity to reference
    e_rdot_ref = 0 * x(4:6,n); % Not implemented yet

    sum_ref_pos = e_r_ref * fc_params.r_ref;

    % Limit to +- 1 m/s
    ref_vel_limit = 1;
    %sum_ref_pos(sum_ref_pos>ref_vel_limit) = ref_vel_limit;
    %sum_ref_pos(sum_ref_pos<-ref_vel_limit) = -ref_vel_limit;

    sum_ref_vel = e_rdot_ref * fc_params.rdot_ref;
    out(:,n) = out(:,n) + sum_ref_pos + sum_ref_vel;

    for j=1:N
        e_x = x(:,n) - drones(:,j); % Difference between 2 drones in question
        e_r = e_x(1:3); % Position difference
        e_r_magn = norm(e_r);
        e_r_dir = e_r / e_r_magn;
        e_rdot = -e_x(4:6); % Velocity difference

        distance = max([e_r_magn, 0.1]); % Absolute distance, 10cm default for first cycle

        sum_pos = e_r_dir * fc_params.r_rel;
        sum_vel = e_rdot * fc_params.rdot_rel;

        sum = sum_pos + sum_vel;
        sum = sum/distance;

        out(:,n) = out(:,n) + sum;
        %out(:,j) = out(:,j) - sum;
    end
end
cla
quiver(x(1,:), x(2,:), out(1,:), out(2,:), 'DisplayName', 'Controller output')
hold on
scatter(drones(1,:), drones(2,:), point_size*4, 'o', 'black', 'HandleVisibility', 'off')
scatter(drones(1,:), drones(2,:), point_size*4, 'X', 'black', 'DisplayName', 'Other agents')
scatter(ref(1), ref(2), point_size*2, 'filled', 'red', 'DisplayName', 'Reference')
scatter(ref(1), ref(2), point_size*1.2, 'filled', 'white', 'HandleVisibility', 'off')
scatter(ref(1), ref(2), point_size*0.3, 'filled', 'red', 'HandleVisibility', 'off')
axis equal;
xlabel('X (meters)')
ylabel('Y (meters)')
title('Flocking controller field potential mapping')