function [ pointDoseValue ] = computePointDosefromBeam( head, beamRadius, beamLongitude, beamLatitude, isocentrePoint, pointOfInterest )
%COMPUTEPOINTDOSEFROMBEAM Summary of this function goes here
%   Detailed explanation goes here
    beamDirection = computeBeamDirectionVector(beamLongitude, beamLatitude);
    skinEntryPoint = computeSkinEntryPoint( head, beamLongitude, beamLatitude, isocentrePoint);
    radialDistance = computeRadialDistance(pointOfInterest, [skinEntryPoint, beamDirection]);
    radialDose = radialDoseTable(radialDistance/beamRadius);
    %http://math.oregonstate.edu/home/programs/undergrad/CalculusQuestStudyGuides/vcalc/dotprod/dotprod.html
    t = dot(pointOfInterest - skinEntryPoint,isocentrePoint - skinEntryPoint)/norm(isocentrePoint - skinEntryPoint);
    pointOnBeam = skinEntryPoint + t.*beamDirection;
    depth = norm(skinEntryPoint - pointOnBeam);
    depthDose = depthDoseTable(depth/d0);
    pointDoseValue = radialDose * depthDose;

end


  