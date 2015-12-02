function [ y ] = computeLinearFunction( P1, P2, x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if(P2(1) == P1(1))
        disp('Line is vertical, undefined slope.')
    else    
        slope = (P2(2) - P1(2)) / (P2(1) - P1(1));
        b = P1(2) - slope * P1(1);
        y = slope * x + b;
    end

end

