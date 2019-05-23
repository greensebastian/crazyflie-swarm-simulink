%% Animate 12-N-X matrix to X Y Z components for plotting using plot3
% 12 states, N drones, X timesteps
% input is time serie "state"
process_state

%an_y = animateline;
%an_z = animateline;
axis([x_axis_limits y_axis_limits z_axis_limits])
grid on
%legend

plot_i0 = 1;
plot_steplength = 300;
plot_speedscale = 1;
plot_updaterate = plot_steplength*continuous_h*plot_speedscale;

set(gcf, 'OuterPosition', [10 80 1200 1000])
pause(1)
hold on
for i = plot_i0:plot_steplength:X
    cla
    %draw_disturbances
    for j = 1:N
        draw_drone([x(j,i);y(j,i);z(j,i)],[phi(j,i);theta(j,i);psi(j,i)],cf_model.stl)
    end
    %for c = 1:C
    %    draw_disturbance(dist_real(:,c,i));
    %end
    if exist('show_disturbances', 'var') && show_disturbances == 1
        hold on
        scatter3(dist_real(1,:,i)', dist_real(2,:,i)', dist_real(3,:,i)', dist_real(4,1,1)*100, 'filled', 'r')
        hold off
    end
    pause(plot_updaterate)
end
hold off