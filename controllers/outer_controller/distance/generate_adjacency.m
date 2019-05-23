function adj = generate_adjacency(drone_count)

dist = 0.5; %Defined distance between each drone

adj = zeros(drone_count,drone_count);

% Generate formation
form = gen_new_formation(drone_count,dist,0);

%Generate adjacency matrix
for i=1:drone_count
    for j=1:drone_count
        adj(i,j) = sqrt((form(1,i)-form(1,j))^2 + (form(2,i)-form(2,j))^2 + (form(3,i)-form(3,j))^2);
    end
end


end

