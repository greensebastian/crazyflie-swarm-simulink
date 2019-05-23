%% Script for analysing complete results folder
% Folder initialization
if ~exist('python_path', 'var')
    disp('Python results path not specified, running init_folders')
    init_folders
end

in = python2matlab();

if in.valid
    res.in = in;
    res.energy = analysis_energy(in.state, in.ref, in.t_state, in.t_ref);
    res.reference = analysis_reference(in.state, in.ref, in.t_state, in.t_ref);
    res.volume = analysis_volume(in.state, in.ref, in.t_state, in.t_ref);
end

if exist('state') && exist('ref')
    in_sim.valid = 1;
    if numel(size(state.data)) < 3
        in_sim.state(:,1,:) = state.data';
    else
        in_sim.state = state.data;
    end
    [~, in_sim.drone_count, ~] = size(in_sim.state);
    in_sim.ref = ref.data';
    in_sim.t_state = state.Time';
    in_sim.t_ref = ref.Time';
else 
    in_sim.valid = 0;
end

if in_sim.valid
    res_sim.in = in_sim;
    res_sim.energy = analysis_energy(in_sim.state, in_sim.ref, in_sim.t_state, in_sim.t_ref);
    res_sim.reference = analysis_reference(in_sim.state, in_sim.ref, in_sim.t_state, in_sim.t_ref);
    res_sim.volume = analysis_volume(in_sim.state, in_sim.ref, in_sim.t_state, in_sim.t_ref);
end