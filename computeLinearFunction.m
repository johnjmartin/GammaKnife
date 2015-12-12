function y = computeLinearFunction(P1, P2, x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if(P2(1) == P1(1))
        disp('Line is vertical, undefined slope.');
        return;
    end
    if (P2(1) - P1(1) == 0)
        disp('Slope is undefined');
        return;
    end
m = (P2(2) - P1(2)) / (P2(1) - P1(1));
b = P1(2) - m * P1(1);
y = m * x + b;
end