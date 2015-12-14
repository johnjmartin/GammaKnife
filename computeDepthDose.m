function [ depthDoseLUT ] = computeDepthDose( maxDepthFromSkin, d0, depthFromSkinResolution )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    global depthP1;
    global depthP2;
    global depthP3;
        
    %round to ceiling to account for all dose possibilities and maintaining
    %an int
    numberOfEntries = ceil(maxDepthFromSkin/depthFromSkinResolution);
    depthDoseLUT = zeros(numberOfEntries,2);    
    
    depthZeroEntries = floor(d0/depthFromSkinResolution);

    for i = 1:(depthZeroEntries + 1)
        depthDoseLUT(i,1) = (i  - 1)/d0;
        depthDoseLUT(i,2) = computeLinearFunction(depthP1, depthP2, (i - 1)/d0);
    end
    
    depthd0Entries = ceil(maxDepthFromSkin/depthFromSkinResolution);

    for i = (depthZeroEntries + 2):(depthd0Entries + 1)
        depthDoseLUT(i,1) = (i  - 1)/d0;
        depthDoseLUT(i,2) = computeLinearFunction(depthP2, depthP3, (i - 1)/d0 );
    end
            
end

