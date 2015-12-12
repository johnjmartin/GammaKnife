

function safe = computeBeamSafety(beamRadius, beam_longitude, beam_latitude, isocenter_point, OARradius, OARcenter)
beamVector = computeBeamDirectionVector(beam_longitude, beam_latitude);
%adding the point to the first 3 indices of the array
beamLine = [isocenter_point, beamVector];
%function distance = computeRadialDistance(point, line)

distance = computeRadialDistance(OARcenter, beamLine);
overlap = OARradius + beamRadius;
if (distance > overlap)   
    safe = 1;
    return;
end
if (distance == overlap)
    safe = 0;
    return;
end
safe = -1;

end