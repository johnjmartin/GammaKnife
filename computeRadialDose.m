function [ radialDoseLUT ] = computeRadialDose( maxRadialDistance, beamRadius, radialDistanceResolution )
%COMPUTERADIALDOSE Summary of this function goes here
%   Detailed explanation goes here
    depthP1 = [0.5,1];
    depthP2 = [1.5,0];
        
    %round to ceiling to account for all dose possibilities and maintaining
    %an int
    numberOfEntries = ceil(maxRadialDistance/radialDistanceResolution);
    radialDoseLUT = zeros(numberOfEntries,2);
    
    radialZeroEntries = floor((beamRadius/2)/radialDistanceResolution);

    for i = 1:(radialZeroEntries + 1)
        radialDoseLUT(i,1) = (i * radialDistanceResolution) - 1;
        radialDoseLUT(i,2) = 1;
    end
    
    radialHalfEntries = ceil(maxRadialDistance/radialDistanceResolution);

    for i = (radialZeroEntries + 2):(1.5 * beamRadius + 1)
        disp((i - radialZeroEntries)/beamRadius);
        radialDoseLUT(i,1) = (i * radialDistanceResolution) - 1;
        radialDoseLUT(i,2) = computeLinearFunction(depthP1, depthP2, (i - 1)/beamRadius );
    end

    for i = ceil(1.5 * beamRadius + 1):(radialHalfEntries + 1)
        radialDoseLUT(i,1) = (i * radialDistanceResolution) - 1;
        radialDoseLUT(i,2) = 0;
    end

end

