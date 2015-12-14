function [ beamSafetyTable ] = computeBeamSafetyTable( beamRadius, isocentrePoint, OAR )
%COMPUTEBEAMSAFETYTABLE Summary of this function goes here
%   Detailed explanation goes here
    global helmet;
    longitudeCount = 360/helmet(1);
    latitudeCount = 90/helmet(1);
    
    beamSafetyTable = zeros(latitudeCount+1,longitudeCount+1);
    beamSafetyTable(1,1) = NaN;
    
    for n = 1:longitudeCount
        longitude = (n - 1) * helmet(1);
        beamSafetyTable(1,n+1) = longitude;
        for m = 1:(latitudeCount + 1)
            latitude = (m - 1) * helmet(1);
            beamSafetyTable(m+1,1) = latitude;
            beamSafetyTable(m+1,n+1) = computeBeamSafety(beamRadius, longitude, latitude, isocentrePoint, OAR);
        end
    end
    
    
    
end

