function [ hr,accRise ] = accDecision( hr,estm,accClass,idx)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    init_glb; 
    accRise = false;
    prev_hr = estm(idx-1);
    global window Fs; 
    bound  = 0.2;
    mean_len = 40;
    alen = 12;
    hrDiff = hr - prev_hr;
    if idx < alen+1
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%% CASE 1:  ACC very very stable  %%%%
    if length(unique(accClass(idx-alen:idx))) == 1   
        if hrDiff >= 0.09999
            hr = hr * 0.6 + prev_hr * 0.4;
        end
        return;
    end
    
    %%%% CASE 2:  ACC a sharp rise %%%%
    v = unique(accClass(idx-alen:idx-1));
    incm = Fs/window;
    if length(v) == 1 && v < accClass(idx)
        if prev_hr < 1.5 
            incm = incm*1.5;
            accRise = true;
        end
        if  prev_hr < mean(estm(1:idx-1)) && prev_hr < expRaiseThreshold(estm(1:idx-1))
             accRise = true;
        end
        if hr <= prev_hr+ Fs/window/3 
            hr = hr + incm;
        end
        return;
    end
    
    %%%% CASE 3: a sharp rise on hr, no matter how acc going
    if abs(hrDiff) >= bound
       hr = 0.7*hr + prev_hr *0.3;
       return;
    end    
end

