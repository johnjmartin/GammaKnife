function [ pointDoseValue ] = computePointDosefromBeam( head, beamRadius, beamLongitude, beamLatitude, isocentrePoint, pointOfInterest )
%COMPUTEPOINTDOSEFROMBEAM Summary of this function goes here
%   Detailed explanation goes here
    
    global depthDoseTable;
    global radialDoseTable;
    global d0;
    
    beamDirection = computeBeamDirectionVector(beamLongitude, beamLatitude);
    skinEntryPoint = computeSkinEntryPoint( head, beamLongitude, beamLatitude, isocentrePoint);
    radialDistance = computeRadialDistance(pointOfInterest, [skinEntryPoint, beamDirection]);
    
    %radial distance is close enough to have a dose that isn't 0
    if (radialDistance/beamRadius) < 1.5
        radialIndex = findTableIndex(radialDistance/beamRadius,radialDoseTable(:,1));
        radialDose = radialDoseTable(radialIndex,2);
        %http://math.oregonstate.edu/home/programs/undergrad/CalculusQuestStudyGuides/vcalc/dotprod/dotprod.html
        t = dot(pointOfInterest - skinEntryPoint,isocentrePoint - skinEntryPoint)/norm(isocentrePoint - skinEntryPoint);
        pointOnBeam = skinEntryPoint + t.*beamDirection;
        depth = norm(skinEntryPoint - pointOnBeam);
        depthIndex = findTableIndex(depth/d0,depthDoseTable(:,1)); 
        depthDose = depthDoseTable(depthIndex,2);
        pointDoseValue = radialDose * depthDose;
    else
        pointDoseValue = 0;
    end

end


  