function [ distance ] = computeRadialDistance( point, line )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    distance = norm(cross((point - line(1:3)),line(4:6))/norm(line(4:6)));
end

