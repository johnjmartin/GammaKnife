function [ insideOAR ] = isPointInsideOAR( point, OAR )
%ISPOINTINSIDEOAR Summary of this function goes here
%   Detailed explanation goes here
    
    if(norm(OAR(2:4) - point) <= OAR(1))
        insideOAR = 2;
    else
        insideOAR = 0;
    end
    
end

