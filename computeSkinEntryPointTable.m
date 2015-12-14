function [ skinEntryPointTable ] = computeSkinEntryPointTable( head, isocentrePoint )
%COMPUTESKIN Summary of this function goes here
%   Detailed explanation goes here
    close all
    figure
    hold on
    [x, y, z] = ellipsoid(0,0,0,head(1),head(2),head(3));
    surf(x, y, z)
    plot3(isocentrePoint(1), isocentrePoint(2), isocentrePoint(3),'ro');
    axis equal
    alpha(0.1)
 
    
    global helmet;
    longitudeCount = 360/helmet(1);
    latitudeCount = 90/helmet(1);
    
    skinEntryPointTable = cell(latitudeCount+1,longitudeCount+1);
    skinEntryPointTable{1,1} = NaN;
    
    for n = 1:longitudeCount
        longitude = (n - 1) * helmet(1);
        skinEntryPointTable{1,n+1} = longitude;
        for m = 1:(latitudeCount + 1)
            latitude = (m - 1) * helmet(1);
            skinEntryPointTable{m+1,1} = latitude;
            skinEntryPointTable{m+1,n+1} = computeSkinEntryPoint(head, longitude, latitude, isocentrePoint);
            beamDirection = computeBeamDirectionVector(longitude, latitude);
            point = skinEntryPointTable{m+1,n+1};
            point2 = isocentrePoint;
            line = [point  + max(head)*beamDirection; point2]; %- max(head)*beamDirection];
            plot3(point(1), point(2), point(3),'b.');
            plot3(line(:,1), line(:,2), line(:,3))
        end
    end
    
    



end

