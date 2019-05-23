function init_swarm(N)
    %% Initialize swarm by setting starting positions and number of drones
    % Drone starting positions
    swarm.count = N;
    swarm.density = 8; % drones per m
    swarm.p0 = [(rand(2, swarm.count)-0.5)*(swarm.count/swarm.density);
        (rand(1, swarm.count)-0.5)*(swarm.count/5/swarm.density)+1.05];
    swarm.x0 = [swarm.p0;zeros(9,N)];
    % Display drone starting formation
    %scatter3(fc_params.p0(1,:), fc_params.p0(2,:), fc_params.p0(3,:))

    assignin('base','swarm',swarm);
    disp(['Swarm of ' num2str(N) ' agents initilized'])
end