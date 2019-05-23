%% Init files for crazyflie_model
run('init_folders')

% Onboard controller parameters
run('init_attitude_controller')

% Rotor model
run('init_rotor_model')

% Quadcopter model
run('init_quadcopter_model')

% Initialize swarm and trajectory
init_swarm(1)
load_traj(0)
load_disturbance(0);

% Velocity controller
run('init_velocity_controller')

% Weighted controller
run('init_flocking_controller')

% Distance controller
run('init_distance_controller')

% Animation settings
run('init_animations')