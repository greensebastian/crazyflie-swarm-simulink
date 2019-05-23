function [posx,posy,posz] = generate_formation(dist, drone_count,option)

switch option
    
    %Flat line in xy-plane, not working
    case 0
        x = 0:dist:dist*drone_count-dist;
        y = 0;
        z = 0;
        
        [posx, posy, posz] = meshgrid(x,y,z);
        posx = reshape(posx,[drone_count,1]);
        posy = reshape(posy,[drone_count,1]);
        posz = reshape(posz,[drone_count,1]);
    
    %Triangle
    case 1
        
        posx = [0,0,dist,0,0,dist];
        posy = [0,dist,dist/2,0,dist,dist/2];
        posz = [0,0,0,1,1,1];
end




end

