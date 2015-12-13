function [ pointDoseValue ] = computePointDose( head, helmet, OAR, isocenterPoint, pointOfInterest )
%COMPUTEPOINTPOSE Summary of this function goes here
%   Detailed explanation goes here
    pointDoseValue = 0;
    totalLon = floor(360 / helmet(1));
    
    %one beam at the top of the helmet
    if mod(90,helmet(1)) == 0 
        totalLat = (90 / helmet(1) - 1);
        pointDoseValue = pointDoseValue + ...
                computePointDosefromBeam( head, helmet(2), 0, 90, isocenterPoint, pointOfInterest );
    %no beams at the top of the helmet
    else
        totalLat =  floor(90 / helmet(1));
    end    
    
    for lon = 1:totalLon
        for lat = 1:totalLat
            pointDoseValue = pointDoseValue + ...
                computePointDosefromBeam( head, helmet(2), lon*helmet(1), lat*helmet(1), isocenterPoint, pointOfInterest );
        end
    end
    
end

