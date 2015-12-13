function safe = computeBeamSafety(beamRadius, beamLongitude, beamLatitude, isocenterPoint, OAR)

    beamVector = computeBeamDirectionVector(beamLongitude, beamLatitude);

    beamLine = [isocenterPoint, beamVector];

    distance = computeRadialDistance(OAR(2:4), beamLine);
    overlap = OAR(1) + beamRadius;

    if (distance > overlap)   
        safe = 1;
        return;
    end
    if (distance <= overlap)
        safe = 0;
        return;
    end

end