%% Inner attitude control parameters for the crazyflie
% Parameters
vel_sample_h = 1/100;
%vel_param_xy = [50;20;5];
%vel_param_z = [8;5;0.5];

%vel_param_xy = [15;0;1];
%vel_param_z = [15;0;0.8];

% Actual controller values
vel_param_xy = [25;1;0]; % Changed from vel testing. Old: [25;1;0];
vel_param_z = [22;15;0;100];% Changed from velocity testing. Old:[25;15;0;100];, [20.4;25;0;1.2]

%vel_param_xy = [18.3;0;0.9]; % From vel testing. Old: 
%vel_param_z = [10;20;0.3;1]; % New from velocity testing with drone. 
% Old: [10;20;0.8;0.5]

% Angle saturation, calculate angle limit based on thrust balance
vel_sat_abs_overhead = 1.1;
vel_sat_abs = 1*vel_sat_abs_overhead;
vel_sat_angle = 20; % Baseline
F_vertical_max = 4*k*(inner_maxlim*inner_thrust_lim)^2;
F_gravity = m*g;
F_ratio_controllable = F_gravity/F_vertical_max;
% Thrust_z = thrust*cos(phi)*cos(theta)
% vel_sat_angle = min(vel_sat_angle, acosd(F_ratio_controllable));

%thrust_feedforward =  hover_omega / inner_maxlim * 65535;
thrust_feedforward = 43000; % 43000 for 28g
% thrust_feedforward = 46500; % ~46500 for 31g
