%% Distance based velocity vector controller intialization

%Variable parameters
distc_params.kp = 1.2;
distc_params.ki = 0;
distc_params.kd = 0.1;
distc_params.kdisturb = 0.025; % 0.025 works fine with 2 doors
distc_params.h = 0.05; % 50 ms sample rate
drone_count = 3;
dist = 0.5; %Defined distance between each drone

distc_params.d = generate_adjacency(drone_count);


% distc_params.d = zeros(drone_count,drone_count);
% 
% % Option;
% % 0 = Tetrahedron
% % 1 = Circle
% % 2 = Line in x
% xnew = gen_new_formation(drone_count,dist,0);
% 
% %Generate adjacency matrix
% for i=1:drone_count
%     for j=1:drone_count
%         distc_params.d(i,j) = sqrt((xnew(1,i)-xnew(1,j))^2 + (xnew(2,i)-xnew(2,j))^2 + (xnew(3,i)-xnew(3,j))^2);
%     end
% end
