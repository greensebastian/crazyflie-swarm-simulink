function load_traj(index)
%LOAD_TRAJ load predetermined trajectory for swarm
%   index is number of sequence to load
    % Reference sequence
    switch index
        case 0 % Hover in [0 0 1]
            disp("Trajectory 0: hover in [0 0 1]")
            traj.seq = [0 0 1; 0 0 1]';
            traj.seq_t = [0 1];
        case 1 % Step x - y - z
            disp("Trajectory 1: step x-y-z")
            traj.seq = [0 0 1 1 1 1 1 1;
                0 0 0 0 1 1 1 1;
                1 1 1 1 1 1 2 2];
            traj.seq_t = [0 1 1.001 2 2.001 3 3.001 4];
        case 2 % Helix, 1.5m high 2m diameter 2 rotations
            disp("Trajectory 2: helix")
            i = linspace(0, 360, 361);
            traj.seq = [sind(2*i); cosd(2*i); (i*1.5/361)+1];
            traj.seq_t = i * 10/361;
        case 3 % Steps in x
            disp("Trajectory 3: steps in x")
            traj.seq = [0 0 1 1;
                0 0 0 0;
                1 1 1 1];
            traj.seq_t = [0 1.5 1.501 3];
        case 4 % Line trajectory
            disp("Trajectory 4: line trajectory")
            traj.seq = [0 0 3 3;
                0 0 0 0;
                1 1 1 1];
            traj.seq_t = [0 2.001 5 10];
        case 5 % Line step
            disp("Trajectory 5: line step")
            traj.seq = [0 0 3 3;
                0 0 0 0;
                1 1 1 1];
            traj.seq_t = [0 2 2.001 10];
        case 6 % Three steps
            disp("Trajectory 6: sequence of steps")
            traj.seq = [0 0 0.5 0.5 0 0 0 0 0;
                0 0 0 0 0.5 0.5 -0.5 -0.5 0;
                1 1 1.5 1.5 1 1 1.5 1.5 1];
            traj.seq_t = [0 5 5.001 6 6.001 7 7.001 9 9.001];
        case 7 % Step in y
            disp("Trajectory 7: Step in y")
            traj.seq = [0 0 1; 0 0 1; 0 1 1; 0 1 1]';
            traj.seq_t = [0 2 2.001 5];
        case 8 % Step in z
            disp("Trajectory 8: Step in z")
            traj.seq = [0 0 1; 0 0 1; 0 0 2; 0 0 2]';
            traj.seq_t = [0 2 2.001 5];
        case 9 % Ramp Y
            disp("Trajectory 9: Report ramp y")
            traj.seq = [0 0 0 0;
                0 0 1 1;
                1 1 1 1];
            traj.seq_t = [0 6 8 10];
        otherwise
            disp(['Traj ' num2str(index) ' unknown, default chosen.'])
            traj.seq = [0 0 1; 0 0 1; 1 1 1; -1 1 2; -1 -1 1; 1 -1 1]';
            traj.seq_t = [0 1 2 3 4 5]*2;
    end
    %traj.seq_t = traj.seq_t * 10/max(traj.seq_t);
    assignin('base','traj',traj);
end

