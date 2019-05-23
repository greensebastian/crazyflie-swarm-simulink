function [res, input] = analysis_energy(state, ref, t_state, t_ref)
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
m = 0.031;

% Kinetic energy
kinetic_drones = zeros(N,X1);
kinetic_swarm = zeros(1,X1);

% Potential energy
potential_swarm_drones = zeros(N,X1);
potential_ref_drones = zeros(N,X1);
potential_swarm_total = zeros(1,X1);
potential_ref_total = zeros(1,X1);

for k_t=1:X1
    swarm_center = [0;0;0];
    for i=1:N
        swarm_center = swarm_center + state(1:3,i,k_t)/N;
    end
    for i=1:N
        v = norm(state(4:6,i,k_t));
        dist_ref = norm(ref(:,k_t) - state(1:3,i,k_t));
        dist_center = norm(swarm_center - state(1:3,i,k_t));
        kinetic_drones(i,k_t) = m*v^2/2;
        potential_swarm_drones(i,k_t) = m*dist_center;
        potential_ref_drones(i,k_t) = m*dist_ref;
    end
    kinetic_swarm(1,k_t) = sum(kinetic_drones(:,k_t));
    potential_swarm_total(1,k_t) = sum(potential_swarm_drones(:,k_t));
    potential_ref_total(1,k_t) = sum(potential_ref_drones(:,k_t));
end

% Append to res
res.m = m;
res.kinetic_drones = kinetic_drones;
res.kinetic_swarm = kinetic_swarm;

res.potential_swarm_drones = potential_swarm_drones;
res.potential_ref_drones = potential_ref_drones;
res.potential_swarm_total = potential_swarm_total;
res.potential_ref_total = potential_ref_total;

end

