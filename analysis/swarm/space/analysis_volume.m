function [res, input] = analysis_volume(state, ref, t_state, t_ref)
%ANALYSIS_VOLUME Analysis pertaining to volume and density of swarm
%   This template describes input parameters and output of single swarm
%   analysis case. The following parameters are requried for analysis:
%
%   param state:
%       6-by-N-by-X1 matrix containing position and velocity measurements of
%       N drones for X1 points in time. 
%       [x, y, z, vx, vy, vz]-by-N-by-X1
%   param ref:
%       3-by-X2 matrix containing swarm position references x, y, and z at
%       X2 points in time. 
%       [x, y, z]-by-X2
%   param t_state:
%       X1-by-1 column vector containing timestamps for state parameter
%   param t_ref:
%       X2-by-1 column vector containing timestamps for ref parameter
%
%   output res:
%       struct containing analysis results
%   output input:
%       struct containing cleaned input, optional if preservation desired.

%% Pre-processing
[state, ref, t_state, t_ref, res, input] = analysis_preprocess(state, ref, t_state, t_ref);

X1 = res.X1;
X2 = res.X2;
N = res.drone_count;

s = state;
r = ref;
adj = generate_adjacency(N);

%% Analysis body

% Swarm volume
volume_range = zeros(3,2,X1);
area_xy = zeros(1,X1);
volume_cube = zeros(1,X1);
diameter_sphere = zeros(1,X1);
volume_sphere = zeros(1,X1);

% Density
density_sphere = zeros(1,X1);
density_axes = zeros(3,X1);
density_cube = zeros(1,X1);

% Distance between drone i and j at time k_t
distance = zeros(N,N,X1);
distance_min = zeros(1,X1);
distance_average = zeros(1,X1);
distance_closest_neighbour = zeros(N,X1);
distance_closest_neighbour_mean = zeros(1,X1);
distance_error = zeros(N,N,X1);
distance_error_average = zeros(N,X1);

% Center calculations
swarm_center = zeros(3, X1);
distance_to_center = zeros(N,X1);
encapsulating_radius = zeros(1,X1);

for k_t=1:X1
    if N==1
        break
    end
    volume_range(1,:,k_t) = [min(s(1,:,k_t)), max(s(1,:,k_t))];
    volume_range(2,:,k_t) = [min(s(2,:,k_t)), max(s(2,:,k_t))];
    volume_range(3,:,k_t) = [min(s(3,:,k_t)), max(s(3,:,k_t))];
    volume_cube_l = volume_range(:,2,k_t) - volume_range(:,1,k_t);
    area_xy(k_t) = volume_cube_l(1)*volume_cube_l(1);
    volume_cube(k_t) = volume_cube_l(1)*volume_cube_l(2)*volume_cube_l(3);
    for i=1:N
        swarm_center(:,k_t) = swarm_center(:,k_t) + s(1:3,i,k_t)./N;
        for j=i+1:N
            distance(i,j,k_t) = sqrt((s(1,i,k_t)-s(1,j,k_t)).^2 + (s(2,i,k_t)-s(2,j,k_t)).^2 + (s(3,i,k_t)-s(3,j,k_t)).^2);
            distance(j,i,k_t) = distance(i,j,k_t);
            distance_error(i,j,k_t) = adj(i,j) - distance(i,j,k_t);
            distance_error(j,i,k_t) = distance_error(i,j,k_t);
        end
    end
    distance_temp = distance(:,:,k_t);
    distance_error_temp = distance_error(:,:,k_t);
    distance_min(k_t) = min(distance_temp(distance_temp > 0));
    distance_average(k_t) = mean(distance_temp(distance_temp > 0));
%     distance_error_average(k_t) = mean(distance_error_temp(distance_error_temp > 0));
    for i=1:N
        d_t_t = reshape(distance_temp(i,:), 1, []);
        distance_closest_neighbour(i,k_t) = min(d_t_t(d_t_t > 0));
        distance_to_center(i,k_t) = norm(swarm_center(:,k_t) - s(1:3,i,k_t));
        distance_error_average(i,k_t) = mean(abs(distance_error_temp(i,:)));
    end
    distance_closest_neighbour_mean(k_t) = mean(distance_closest_neighbour(:,k_t));
    
    diameter_sphere(k_t) = max(distance_temp, [], 'all');
    volume_sphere(k_t) = 4/3 * pi * (diameter_sphere(k_t)/2)^3;
    density_sphere(k_t) = N/volume_sphere(k_t);
    density_axes(:,k_t) = N./volume_cube_l;
    density_cube(k_t) = N/volume_cube(k_t);
    
    encapsulating_radius(k_t) = max(distance_to_center(:,k_t));
end

% Append to res
res.volume_range = volume_range;
res.area_xy = area_xy;
res.volume_cube = volume_cube;
res.diameter_sphere = diameter_sphere;
res.volume_sphere = volume_sphere;

res.distance = distance;
res.distance_min = distance_min;
res.distance_average = distance_average;
res.distance_closest_neighbour = distance_closest_neighbour;
res.distance_closest_neighbour_mean = distance_closest_neighbour_mean;
res.distance_error = distance_error;
res.distance_error_average = distance_error_average;

res.density_sphere = density_sphere;
res.density_axes = density_axes;
res.density_cube = density_cube;

res.swarm_center = swarm_center;
res.distance_to_center = distance_to_center;

res.encapsulating_radius = encapsulating_radius;

end

