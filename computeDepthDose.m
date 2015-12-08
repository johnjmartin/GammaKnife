function depth_dose_value = computeDepthDose(depth_from_skin,d0)

    D = depth_from_skin/d0;

    %Depth intensity calculation based on provided zones.
    if D >= 0 && D <= 1 
        P1 = [0 0];
        P2 = [1 1];
        depth_dose_value = compute_linear_function(P1,P2,D);
    elseif D > 1 && D < 11
        P1 = [1 1];
        P2 = [11 0];
        depth_dose_value = compute_linear_function(P1,P2,D);
    else
        depth_dose_value = 0;
    end
end