function plot_reference(res)
%PLOT_REFERENCE Summary of this function goes here
%   Detailed explanation goes here

d = res.reference;
r = res.in.ref;

if isfield(d, 'step_direction')
    dir = d.step_direction;
else
    disp('No step detected')
    dir = 0;
end

dir_text = '';
if dir == 1
    dir_text = 'x';
elseif dir == 2
    dir_text = 'y';
elseif dir == 3
    dir_text = 'z';
end

if dir ~= 0
    %f = figure;
    %ax2 = plot(d.t, r(d.step_direction,:), 'DisplayName', 'Reference');
    hold on
    ax = plot(d.t, d.swarm_center(d.step_direction,:), 'DisplayName', [dir_text '_{swarm,sim}']);
    hold off
    title('Swarm response');
    legend
    xlabel('Time (seconds)')
    ylabel(['Center position ' dir_text ' (meters)'])
end

%f2 = figure;
%ax3 = plot(d.t, d.swarm_error, 'DisplayName', 'e_{swarm}');
%legend
end

