function plot_energy(res)
%PLOT_ENERGY Plot energy results of folder analysis
%   Detailed explanation goes here

d = res.energy;
r = res.in.ref;

%f = figure;
ax = plot(d.t, d.kinetic_swarm/res.in.drone_count);
title(['Kinetic energy of swarm (' num2str(res.in.drone_count) ' agents)']);
xlabel('Time (seconds)');
ylabel('Kinetic energy (J)');
grid on;
xlim([4 14]);

end

