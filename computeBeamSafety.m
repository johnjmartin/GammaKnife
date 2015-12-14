function [safety] = computeBeamSafety(beamRadius, beamLongitude, beamLatitude, isocentrePoint, OAR)

    beamVector = computeBeamDirectionVector(beamLongitude, beamLatitude);

    beamLine = [isocentrePoint, beamVector];

    distance = computeRadialDistance(OAR(2:4), beamLine);
    overlap = OAR(1) + beamRadius;
    
    %weird error where distance would have a double result of distance.000
    %repeating making it unequal to the overlap. rounding removes excess
    %decimals
    distance = round(distance*100000)/100000;
    overlap = round(overlap*100000)/100000;
    
    if (distance > overlap) 
        safety = 1;
    else
        safety = 0;
    end

end