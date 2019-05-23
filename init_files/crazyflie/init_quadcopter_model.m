%% Model parameters of the crazyflie 2.0
% Extention of implementation by Marcus Greiff (2017)
% Cross configuration, Mike Hamer (2015)
% Parameters
g = 9.81;       % m/s^2
m = 0.028;      % kg
% m = 0.031;      % kg
l = 0.046;      % m
k = 2.2e-8;  % N m s^2
b = 2e-9;       % N s^2
Im = 3e-6;    % kg*m^2
I = [1.66e-5;    % kg*m^2
     1.66e-5;    % kg*m^2
     2.93e-5];   % kg*m^2
A = [0.92e-6;      % kg/s
	 0.91e-6;      % kg/s
	 1.03e-6];     % kg/s

% Thrust per rotor required to hover steadily
hover_omega = sqrt(g*m/(4*k));

% Initial states fo the system
initial_xi = [0; 0; 0];
initial_xidot = [0; 0; 0];
initial_eta = [0; 0; 0];
initial_etadot = [0; 0; 0];

cf_model.stl = stlread('cf.stl');

cf_model.C = [255, 0, 0];

% Battery voltage
voltage_battery = 4;