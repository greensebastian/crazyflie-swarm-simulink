function result = get_freq_ampl_shift(vec, ref, t_vec, t_ref)
%GET_FREQ_AMPL_SHIFT Calculates gain and shift of the two vectors entered
%   Used for frequency response analysis. Input is reference vector ref,
%   process state vector vec and corresponding timestamp vectors.
rate_vec = mean(diff(t_vec));
rate_ref = mean(diff(t_ref));

% Reference analysis
threshhold = max(ref)/10;
[pk_ref, pk_ref_loc] = findpeaks(ref, 'MinPeakProminence', threshhold);
if numel(pk_ref) > 0
    [pk, pk_loc] = findpeaks(vec, 'MinPeakProminence', threshhold);
    period_steps = median(diff(pk_ref_loc));
    i0 = round(pk_ref_loc(1) - period_steps/5);
    t0 = t_ref(i0);
    t_ref = t_ref(t_ref >= t0);
    ref = ref(t_ref >= t0);
    t_vec = t_vec(t_vec >= t0);
    t_vec = t_vec(1:min([numel(vec), numel(t_vec)]));
    vec = vec(t_vec >= t0);

    freq = 1/(period_steps*rate_ref);
    amp_ref = round(mean(pk_ref), 2);

    [mid_ref_loc] = round(midcross(ref, 'StateLevels', [-threshhold threshhold]));
    [mid_loc] = round(midcross(vec, 'StateLevels', [-threshhold threshhold]));

    while mid_loc(1) < mid_ref_loc(1)
        mid_loc = mid_loc(2:end);
    end
    mid_ref_loc = mid_ref_loc(1:numel(mid_loc));
    shift = median(t_ref(mid_ref_loc) - t_vec(mid_loc))*freq*2*pi;
    amp = median(pk)/median(pk_ref);
else
    freq = 0;
    amp_ref = 0;
    shift = 0;
    amp = 0;
end

% Append to result
result.freq = freq;
result.amp_ref = amp_ref;
result.shift = shift;
result.amp = amp;

%% Old code for reference
% %% Y direction
% % Reference analysis
% threshhold = max(result.uvy)/10;
% [pk_ref, pk_ref_loc] = findpeaks(result.uvy, 'MinPeakProminence', threshhold);
% period_steps = mean(diff(pk_ref_loc));
% freq = 1/round(period_steps*result.rate_ref, 2);
% amp_ref = round(mean(pk_ref), 2);
% 
% % Result analysis
% [pk, pk_loc] = findpeaks(result.vy, 'MinPeakProminence', threshhold);
% if numel(pk_ref) > 0
%     while numel(pk_loc) > numel(pk_ref_loc)
%         pk = pk(1:end-1);
%         pk_loc = pk_loc(1:end-1);
%     end
%     pk_ref_loc = pk_ref_loc(1:numel(pk_loc));
%     shift = mean(pk_ref_loc - pk_loc)/period_steps*2*pi;
%     amp = median(pk)/median(pk_ref);
% else
%     freq = 0;
%     amp_ref = 0;
%     shift = 0;
%     amp = 0;
% end
% % Append to result
% result.freq_vy = freq;
% result.amp_ref_vy = amp_ref;
% result.shift_vy = shift;
% result.amp_vy = amp;

end

