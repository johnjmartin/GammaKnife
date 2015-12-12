function [ pointDoseValue ] = computePointDosefromBeam( head, beamRadius, beamLongitude, beamLatitude, isocenterPoint, pointOfInterest )
%COMPUTEPOINTDOSEFROMBEAM Summary of this function goes here
%   Detailed explanation goes here
    beamDirection = computeBeamDirectionVector(beamLongitude, beamLatitude);
    skinEntryPoint = computeSkinEntryPoint( head, beamLongitude, beamLatitude, isocenterPoint);
    radialDistance = computeRadialDistance(pointOfInterest, [skinEntryPoint, beamDirection]);
    radialDose = radialDoseTable(radialDistance/beamRadius);
    %http://math.oregonstate.edu/home/programs/undergrad/CalculusQuestStudyGuides/vcalc/dotprod/dotprod.html
    t = dot(pointOfInterest - skinEntryPoint,beamDirectionVector)/norm(beamDirectionVector)^2;
    pointOnBeam = skinEntryPoint + t.*beamDirection;
    depth = norm(skinEntryPoint - pointOnBeam);
    depthDose = depthDoseTable(depth/d0);
    pointDoseValue = radialDose * depthDose;

end


  