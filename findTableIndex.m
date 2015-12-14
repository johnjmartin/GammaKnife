function [ index ] = findTableIndex( xValue, xValueTable )
%FINDTABLEINDEX Summary of this function goes here
%   Detailed explanation goes here
    [~, index] = min(abs(xValueTable-xValue));
end

