function [angle, rej_A, rej_B] = compute_rejections(A, B)
%COMPUTE_REJECTIONS Compute angle and rejections between vectors
%   Compute angle dividing input vectors A and B by using the dot product
%   to derive rejection of A along B. Returns angle and normalized 
%   rejections orthogonal to A in A-B plane
if (A == B)
    angle = pi;
    rej_A = [0;0;0];
    rej_B = rej_A;
    return
end

dAB = dot(A,B);
dBB = dot(B,B);
len_A = norm(A);
len_B = norm(B);

rej_A = A - dAB/dBB * B;
rej_A = rej_A/norm(rej_A);
rej_B = -rej_A;

angle = max(0.01, acos(dAB/(len_A*len_B)));
end

