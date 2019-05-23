%% Script for pushing python reference to sequence struct
if exist('flock_ref', 'var') && exist('timestamps_ref', 'var')
    traj.seq = flock_ref;
    traj.seq_t = timestamps_ref;
else
    disp('No python sequence reference found in workspace')
end