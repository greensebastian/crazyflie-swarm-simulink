function load_disturbance(index)
%LOAD_TRAJ load predetermined disturbances
%   index is number of setup to load
    % Reference sequence
    switch index
        case 0 % No disturbances
            disp("Disturbance 0: no disturbance")
            disturbances = [0 0 -10 0.00001]';
        case 1 % Point
            disp("Disturbance 1: point in [0.5 0 1]")
            disturbances = [0.5 0 1 1]';
        case 2 % Point
            disp("Disturbance 2: mag 10 point in [2 0.4 1]")
            disturbances = [2 0.4 1 10]';
        case 3 % Line
            disp("Disturbance 3: mag 5 line along z in [2 0.5 0.5:1.5]")
            disturbances = [2 0.5 0.5 5;
                2 0.5 1 5;
                2 0.5 1.5 5]';
        case 4 % Ring
            disp("Disturbance 4: ring about x in [2 0 1]")
            n_pts = 31;
            i = linspace(0, 360, n_pts);
            disturbances = [ones(1,n_pts)*2;sind(i)/2 + ones(1,n_pts)*0.3;cosd(i)/2+1;ones(1,n_pts)*0.5];
        case 5 % "Door"
            disp('Disturbance 5: "door"')
            n_y = 12;
            n_z = 16;
            y = linspace(-0.3, 1, n_y);
            z = linspace(-2, 2, n_z);
            [Y, Z] = meshgrid(y,z);
            Y = reshape(Y, 1, []);
            Z = reshape(Z, 1, []);
            disturbances = [ones(1,n_y*n_z)*2;Y;Z+1;ones(1,n_y*n_z)*0.4];
        case 6 % Two doors
            disp("Disturbance 6: 2 doors")
            n_y = 30;
            n_z = 30;
            y1 = linspace(-3, 0.3, n_y);
            y2 = linspace(-0.3, 3, n_y);
            z = linspace(-2, 2, n_z);
            [Y1, Z] = meshgrid(y1,z);
            [Y2, ~] = meshgrid(y2,z);
            Y = [reshape(Y1, 1, []), reshape(Y2, 1, [])];
            Z = [reshape(Z, 1, []), reshape(Z, 1, [])];
            disturbances = [[ones(1,n_y*n_z)*1, ones(1,n_y*n_z)*2.5];Y;Z+1;ones(1,n_y*n_z*2)*0.1];
        case 7 % "S"
            disp('Disturbance 7: "S"')
            n = 31;
            i = linspace(0, 360, n);
            disturbances = [ones(1,n)*2;sind(i);2/360*i;ones(1,n)*1];
        case 8 % Point
            disp("Disturbance 8: mag 3 point in [0 0 5]")
            disturbances = [0 0 5 3]';
        case 9 % Point
            disp("Disturbance 9: mag 1 point in [2 0 1]")
            disturbances = [2 0 1 1]';
        case 10 % Point
            disp("Disturbance 10: mag 1 point in [2 0 1.2]")
            disturbances = [2 0 1.2 1]';
        otherwise
            disp(['Disturbance ' num2str(index) ' unknown, default chosen.'])
            disturbances = [1 1 1 0]';
    end
    assignin('base','disturbances',disturbances);
end
