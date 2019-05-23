function output = python2matlab()
%PYTHON2MATLAB Convert log variables from python to simulink
%   Reads state, ref and timestamps variables from base workspace and
%   returns in format equivalent to that of simulink output. Workspace
%   variables should be formatted as:
%   d01_state
%   d01_control
%   ...
%   dXX_state
%   dXX_control
%   flock_ref
%   timestamps_state
%   timestamps_control
%   timestamps_ref

% Read states
var_names = evalin('base', 'whos("d*_state")');
drones = ["dummy",];
drone_count = length(var_names);
for i = 1:drone_count
    var_name = var_names(i).name;
    var = evalin('base', var_name);
    drones(i) = var_name(2:3);
    state(:,i,:) = var;
end

if ~exist('state')
    output.valid = 0;
    return
else
    output.valid = 1;
end

% Read ref
var_names = evalin('base', 'whos("*_ref")');
for i = 1:length(var_names)
    var_name = var_names(i).name;
    var = evalin('base', var_name);
    if contains(var_name, 'time') ~= 1
        ref = var;
    end
end

% Read timestamps
var_names = evalin('base', 'whos("timestamps_*")');
for i = 1:length(var_names)
    var_name = var_names(i).name;
    var = evalin('base', var_name);
    if contains(var_name, 'state')
        t_state = var;
    elseif contains(var_name, 'ref')
        t_ref = var;
    end
end

X1 = numel(t_state);
X2 = numel(t_ref);
if X1 > X2
    t_state = t_state(1:X2);
    state = state(:,:,1:X2);
elseif X2 > X1
    t_ref = t_ref(1:X1);
    ref = ref(:,1:X1);
end

output.drone_count = drone_count;
output.drones = drones;
output.state = state;
output.ref = ref;
output.t_state = t_state;
output.t_ref = t_ref;
end

