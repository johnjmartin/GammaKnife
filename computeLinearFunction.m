%james
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
%stranger
function y = compute_linear_function(P1,P2,x)

%Test for correct bounds and non-zero denominator
if (P1(1)<=x && x<=P2(1)) && P2(1)-P1(1) ~= 0
    
    %Calculate slope and intercept to find y value
    m = (P2(2)-P1(2))/(P2(1)-P1(1));
    b = P1(2) - m*P1(1);
    y = m*x + b;
else
    display('Requested x value out of range or slope is infinite')
    y = 9999;
end
end