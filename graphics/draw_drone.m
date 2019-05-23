function draw_drone(p, eta, mdl)
%DRAW_DRONE Summary of this function goes here
%   Detailed explanation goes here
    hold on
    pts = mdl.Points;
    con = mdl.ConnectivityList;
    R = eta2Rgb(-eta, false);
    pts = R*pts' + p;
    pts = pts';
    tria = triangulation(con, pts);
    trisurf(tria);
    hold off
end

