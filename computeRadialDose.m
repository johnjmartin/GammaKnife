function [ radialDoseLUT ] = computeRadialDose( maxRadialDistance, beamRadius, radialDistanceResolution )
%COMPUTERADIALDOSE Summary of this function goes here
%   Detailed explanation goes here
    global radialP1
    global radialP2
        
    %round to ceiling to account for all dose possibilities and maintaining
    %an int
    numberOfEntries = ceil(maxRadialDistance/radialDistanceResolution);
    radialDoseLUT = zeros(numberOfEntries,2);
    
    radialOneEntries = floor((beamRadius/2)/radialDistanceResolution);

    for i = 1:(radialOneEntries + 1)
        radialDoseLUT(i,1) = (i - 1) / beamRadius;
        radialDoseLUT(i,2) = 1;
    end
    
    for i = (radialOneEntries + 2):(maxRadialDistance + 1)
        radialDoseLUT(i,1) = (i - 1) / beamRadius;
        radialDoseLUT(i,2) = computeLinearFunction(radialP1, radialP2, (i - 1)/beamRadius );
    end
    
    %any points greater than 1.5 has radial dose of 0
    radialDoseLUT(i + 1,1) = 1.5;
    radialDoseLUT(i + 1,2) = 0;


end

