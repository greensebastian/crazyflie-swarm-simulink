%% Weighted controller parameter initialization
fc_params.k = 1;
%fc_params.w = [1 0 0.04 0.005];
fc_params.w = [1 0 0.1 0.05];
%fc_params.w_norm = fc_params.w/norm(fc_params.w);
fc_params.w_norm = fc_params.w;

fc_params.r_ref = fc_params.w_norm(1) * fc_params.k; % Position relative to desired swarm center
fc_params.rdot_ref = fc_params.w_norm(2) * fc_params.k; % Velocity relative desired swarm average
fc_params.r_rel = fc_params.w_norm(3) * fc_params.k; % Position relative to other agents
fc_params.rdot_rel = fc_params.w_norm(4) * fc_params.k; % Velocity relative to other agents
fc_params.r_dist = 1; % Repulsion from disturbances

fc_params.enable_rejection = 0;
fc_params.angle_cap = deg2rad(15); % "Deadzone/Shadow" angle limit
fc_params.angle_k = 0.2; % Deadzone repulsion gain

fvc_params = fc_params; % Flocking vel controller parameters
fvc_params.center_k = 1;