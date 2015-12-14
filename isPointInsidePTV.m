function [ insidePTV ] = isPointInsidePTV( point, PTV )
%ISPOINTINSIDEPTV Summary of this function goes here
%   Detailed explanation goes here
    
    if(norm(PTV(2:4) - point) <= PTV(1))
        insidePTV = 1;
    else
        insidePTV = 0;
    end
    

end

