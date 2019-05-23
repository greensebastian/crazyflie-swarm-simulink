


% Initialize 1 drone, step in z
init_swarm(1);
load_traj(7);

distc_params.kp = 2;
distc_params.kd = 0.1;

close all
% Number of simulations
runs = 10;
%y_state = zeros(runs,1);

for i_pd=1:runs

    %for y_pd=1:runs
        %states(i) = state;

        sim('distance_controller');
        
        % y/z from process_state
        y_state(i_pd,:) = y;
%       z_state(i_pd,:) = z;
        
        distc_params.kd = distc_params.kd + 0.1;
    %end
    %distc_params.kp = distc_params.kp + 0.2;
    
end

rate = continuous_h;

% Y-plotting
reference = ref.data(2:end,2);
reference = repmat(reference', [runs,1]);

results = iddata(y_state',reference',rate);
figure('Name','Step response');
plot(results)
grid on

% Z-plotting
% reference = ref.data(2:end,3);
% reference = repmat(reference', [runs,1]);
% 
% results = iddata(z_state',reference',rate);
% figure('Name','Step response');
% plot(results)
% grid on

% kp = 2.8 and kd = 0.6 seems to be optimal in the y-direction, not optimal
% on actual drone
% kp = 2.5, kd = 0.3
% kp = 2, kd = 0.2 (with 0.05 delay)