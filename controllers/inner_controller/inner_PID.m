function [u, pers_new] = inner_PID(error, params, rate, pers)
% INNER_PID General PID implementation used by all Crazyflie onboard
% controllers

    % Initialization of persistent variables
    out = 0;
    out = out + error*params.KP;
    
    deriv = (error-pers.prev_error)/rate;
    if(params.lpf_enabled)
        pers.delay_e(1) = deriv - params.lpf_a(1) * pers.delay_e(1) - params.lpf_a(2) * pers.delay_e(2);
        deriv = pers.delay_e(1) * params.lpf_b(1) + pers.delay_e(2) * params.lpf_b(2) + pers.delay_e(3) * params.lpf_b(3);
        pers.delay_e(3) = pers.delay_e(2);
        pers.delay_e(2) = pers.delay_e(1);
    end
    out = out + deriv*params.KD;
    
    pers.integ = pers.integ + error*rate;
    if pers.integ > params.integr_sat
        pers.integ = params.integr_sat;
    elseif pers.integ < -params.integr_sat
        pers.integ = -params.integr_sat;
    end
    out = out + pers.integ*params.KI;
    
    pers.prev_error = error;
    pers_new = pers;
    u = out;
end
