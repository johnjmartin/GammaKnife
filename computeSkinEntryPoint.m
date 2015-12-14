function [skinEntryPoint] = computeSkinEntryPoint(head, beamLongitude, beamLatitude, isocentrePoint)
    % convert longitude and latitutde to radians.
    directionVector = computeBeamDirectionVector(beamLongitude, beamLatitude);

    % Calls question 4, assignment 1. Intersection of ellipsoid and line.
    % Outputs the two found intersections.
    [entryPoint1, entryPoint2] = lineEllipsoidIntersection(directionVector, isocentrePoint, head(1), head(2), head(3));
    
    %positive point is located on the upper part of the head where the
    %helmet is placed
    if entryPoint1(3) > entryPoint2(3)
        skinEntryPoint = entryPoint1;
    elseif entryPoint2(3) > entryPoint2(3)
        skinEntryPoint = entryPoint2;
    elseif norm(directionVector - entryPoint1) < norm(directionVector - entryPoint2)
        skinEntryPoint = entryPoint1;
    else
        skinEntryPoint = entryPoint2;
    end
end
