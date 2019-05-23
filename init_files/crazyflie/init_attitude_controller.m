%% Inner attitude control parameters for the crazyflie
% Parameters
continuous_h = 1/2000;

% Loop rate at 500 Hz, Attitude at 250 Hz
inner_rate_h = 0.002;
inner_angle_h = 0.004;

% Omega saturation
inner_maxlim = 2500;
inner_minlim = 0;%500;

% Thrust limitation
inner_thrust_lim = 0.9; % 85%. Changed due to vel testing
inner_thrust_min = 20000/65535; % Min thrust is 20000, avoid winding down too much

% Rate reference limit
inner_rate_sat = 720; % 720 deg/s rate limit

% Attitude controller (ac) parameters
inner_ac.lpf_enabled = false;
inner_ac.lpf_cutoff = 15;
[inner_ac.lpf_b, inner_ac.lpf_a] = get2plpfargs(inner_angle_h, inner_ac.lpf_cutoff);

inner_ac.KP = 6;
inner_ac.KI = 3;
inner_ac.KD = 0;
inner_ac.integr_sat = 20;

% Attitude rate (arc)
inner_arc.lpf_enabled = false;
inner_arc.lpf_cutoff = 30;
[inner_arc.lpf_b, inner_arc.lpf_a] = get2plpfargs(inner_rate_h, inner_arc.lpf_cutoff);

%inner_arc.KP = 250;
%inner_arc.KI = 500;
%inner_arc.KD = 2.5;
inner_arc.integr_sat = 33.3;

k_arc = 1;

% inner_arc.KP = 250 * k_arc;
% inner_arc.KI = 500 * k_arc;
% inner_arc.KD = 20 * k_arc;
% inner_arc.KP = 250 * k_arc;
% inner_arc.KI = 500 * k_arc;
% inner_arc.KD = 5 * k_arc;

inner_arc.KP = 250 * k_arc;
inner_arc.KI = 500 * k_arc;
inner_arc.KD = 5 * k_arc;

% Yaw controller (yc) parameters
inner_yc.lpf_enabled = false;
inner_yc.lpf_cutoff = 15;
[inner_yc.lpf_b, inner_yc.lpf_a] = get2plpfargs(inner_angle_h, inner_yc.lpf_cutoff);

inner_yc.KP = 6;
inner_yc.KI = 1;
inner_yc.KD = 0.35;
inner_yc.integr_sat = 360;

% Yaw rate (yrc)
inner_yrc.lpf_enabled = false;
inner_yrc.lpf_cutoff = 30;
[inner_yrc.lpf_b, inner_yrc.lpf_a] = get2plpfargs(inner_rate_h, inner_yrc.lpf_cutoff);

k_yrc = 0.5;

% inner_yrc.KP = 120 * k_yrc;
% inner_yrc.KI = 16.7 * k_yrc;
% inner_yrc.KD = 0 * k_yrc;
inner_yrc.KP = 120 * k_yrc;
inner_yrc.KI = 16.7 * k_yrc;
inner_yrc.KD =  4 * k_yrc;
inner_yrc.integr_sat = 166.7;

%inner_yrc.KP = 12;
%inner_yrc.KI = 1.667;
%inner_yrc.KD = 0;