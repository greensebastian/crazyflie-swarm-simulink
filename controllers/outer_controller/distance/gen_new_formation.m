function [x_new] = gen_new_formation(drone_count,dist,option)

dc = drone_count;
angle = 2*pi/dc;

% Tetrahedron
tetrahedron = [0, dist, dist/2, dist/2, dist/2;
             0, 0,    dist,   dist/2, dist/2;
             0, 0,    0,      dist,   -dist];

circle = dist*[cos(0), cos(angle), cos(2*angle), cos(3*angle), cos(4*angle);
          sin(0), sin(angle), sin(2*angle), sin(3*angle), sin(4*angle);
          0,      0,          0,            0,            0];
% Line in x      
line = [0, dist, 2*dist, 3*dist, 4*dist;
        0, 0,    0,      0,      0;
        0, 0,    0,      0,      0];

switch option
    
    case 0 % Tetrahedron
        x_new = tetrahedron(:, 1:dc);
%         disp("Tetrahedron formation loaded.");
    case 1 % Circle
        x_new = circle(:, 1:dc);
%         disp("Circle formation loaded.");
    case 2 % Line
        x_new = line(:, 1:dc);
%         disp("Line formation loaded.");
end
         
end

