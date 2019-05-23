function plot_volume(res)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d = res.volume;
r = res.in.ref;

f = figure;
% hold on
ax = plot(d.t, d.encapsulating_radius);
title('Encapsulating radius');
xlabel('Time (seconds)')
ylabel('Distance (meters)')
% hold off
f2 = figure;
ax2 = plot(d.t, d.distance_closest_neighbour');
title('Distance to closest neighbour');
xlabel('Time (seconds)')
ylabel('Distance (meters)')
xlim([4 14]);

end

