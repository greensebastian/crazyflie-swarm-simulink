function [res, input] = analysis_reference(state, ref, t_state, t_ref)
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

%% Analysis body

% Swarm volume
swarm_center = zeros(3, X1);
swarm_error = zeros(1, X1);
swarm_error_components = zeros(3, X1);
drone_error_components = zeros(3, N, X1);
drone_error_absolute = zeros(N, X1);
drone_error_mean = zeros(1, X1);

step_start_indices = [];

for k_t=1:X1
    
    for i=1:N
        swarm_center(:,k_t) = swarm_center(:,k_t) + s(1:3,i,k_t)./N;
        drone_error_components(:,i,k_t) = ref(:,k_t) - s(1:3,i,k_t);
        drone_error_absolute(i,k_t) = norm(drone_error_components(:,i,k_t));
        for j=i+1:N
            
        end
    end
    
    swarm_error_components(:,k_t) = ref(:,k_t) - swarm_center(:,k_t);
    swarm_error(k_t) = norm(swarm_error_components(:,k_t));
    drone_error_mean(k_t) = mean(drone_error_absolute(:,k_t));
    
    if t_state(k_t) > 5 && all(ref(:,k_t)-ref(:,k_t-1) == 0) ~= 1
        step_start_indices = [step_start_indices, k_t];
    end
end

% Find first swarm step
if numel(step_start_indices) > 0
    i = step_start_indices(1);
    i_range = i:i+10/res.h_state; % 5 seconds after i
    i_range = i_range(i_range <= X1);
    
    d_r = ref(:,i)-ref(:,i-1);

    j = find(d_r~=0);
    res.step_direction = j;
    t_step = t_state(i);
    step_info = stepinfo(swarm_center(j,i_range), t_state(i_range) - t_state(i), ref(j,i), 'SettlingTimeThreshold',0.05);
end

% Append to res
res.swarm_center = swarm_center;
res.swarm_error = swarm_error;
res.swarm_error_components = swarm_error_components;
res.drone_error_components = drone_error_components;
res.drone_error_absolute = drone_error_absolute;

if exist('step_info', 'var')
    res.step_info = step_info;
    res.t_step = t_step;
end

end

