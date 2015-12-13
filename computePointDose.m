function [ pointDoseValue ] = computePointDose( head, helmet, OAR, isocentrePoint, pointOfInterest )
%COMPUTEPOINTPOSE Summary of this function goes here
%   Detailed explanation goes here
    global safetyTable;
    
    pointDoseValue = 0;
    totalLon = floor(360 / helmet(1));
    
    %one beam at the top of the helmet
    if mod(90,helmet(1)) == 0 
        totalLat = (90 / helmet(1));
        pointDoseValue = pointDoseValue + ...
                computePointDosefromBeam( head, helmet(2), 0, 90, isocentrePoint, pointOfInterest );
    %no beams at the top of the helmet
    else
        totalLat =  floor(90 / helmet(1)) + 1;
    end    
       
    
    for lon = 1:totalLon
        for lat = 1:totalLat
            %beam is safe, can be used
            if(safetyTable(lat+1,lon+1)) == 1
                pointDoseValue = pointDoseValue + ...
                computePointDosefromBeam( head, helmet(2), (lon+1)*helmet(1), (lat+1)*helmet(1), isocentrePoint, pointOfInterest );
            end              
        end
    end
    
end

