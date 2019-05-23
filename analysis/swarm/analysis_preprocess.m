function [state, ref, t_state, t_ref, res, input] = analysis_preprocess(state, ref, t_state, t_ref)
%ANALYSIS_TEMPLATE Template for analysis of swarm behaviour
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

%% Pre-processing in single drone case
if numel(size(state)) < 3
    new_state(:,1,:) = state';
    state = new_state;
end

[A, B] = size(ref);
if A > B
    ref = ref';
end

state = interpolate_unchanged(state);

%% Input preservation
input.state = state;
input.ref = ref;
input.t_state = t_state;
input.t_ref = t_ref;

%% Pre-processing of metadata
[~, N, X1] = size(state);
[~, X2] = size(ref);
res.X1 = X1;
res.drone_count = N;
res.X2 = X2;
res.t = t_state;
res.h_state = mean(diff(t_state));
res.h_ref = mean(diff(t_ref));

end

