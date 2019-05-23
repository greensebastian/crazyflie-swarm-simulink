function interp_data = interpolate_unchanged(data)
%INTERPOLATE_UNCHANGED Interpolates all measurement data
%   Interpolates all input data to smoothen for visualizations. Input data
%   should be in C-by-N-by-X matrix of C measured states of N drones at X
%   points in time. Interpolation necessary as all drone states may not be
%   updated simultaneously. Total resolution is not increased, each state
%   is interpolated if it was unchanged at current time.

if numel(size(data)) < 3 % If vector input
    new_state(:,1,:) = state;
    data = new_state;
end

[D, N, X] = size(data);

interp_data = data;

for n=1:N
    for d=1:D
        i_old = 1;
        for i=2:X
            if data(d,n,i) ~= data(d,n,i_old)
                delta = data(d,n,i) - data(d,n,i_old);
                delta_vec = linspace(0, delta, i-i_old+1);
                delta_vec(end) = 0; % Dont change end element
                interp_data(d,n,i_old:i) = reshape(data(d,n,i_old:i), 1, []) + delta_vec;

                i_old = i;
            end
        end
    end
end

end

