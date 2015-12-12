function [Intersection] = question4(L1, L2, A, B, C)
%find the vector equation of our line
line = twoPointLineEq(L1, L2);
syms t;
%subbing the line equation into the elipsoid equation, solve for tVal
tVal = solve((line(1)^2)/A^2 + (line(2)^2)/B^2 + (line(3)^2)/C^2 - 1);
%if the values are the same the line is tangent to the sphere, only one
%intersection point
if tVal(1) ==tVal(2)
    tVal = tVal(1);
end
Intersection = subs(line, t, tVal);
d = digits(2);
Intersection = vpa(Intersection,d);
end

function line = twoPointLineEq(L1, L2)
syms t;
line = L1 + t*((L2-L1)/norm(L2-L1));
end

function [EntryPoint] = computeSkinEntryPoints(head, long, lat, isocenter, radius)
    % convert longitude and latitutde to radians.
    long = degtorad(long);
    lat = degtorad(lat);
    
    % Latitude is defined as angle between flat "equator" plane and a line
    % between point and center.
    % Longitude is defined as angle east of west of perpendicular plane and
    % a line between point and center.
    % Because of these definitions, we can plot them as we would on a
    % sphere.
    x = radius .* cos(lat) .* cos(long);
    y = radius .* cos(lat) .* sin(long);
    z = radius .* sin(lat);
    
    Point = [x,y,z];
    
    % Calls question 4, assignment 1. Intersection of ellipsoid and line.
    % Outputs the two found intersections.
    [EntryPoint1, EntryPoint2] = Q4A1(Point, isocenter, head(1), head(2), head(3));
    
    % Compute distance between first entry point and source.
    Distance1 = EntryPoint1' - Point;
    Distance1 = Distance1.^2;
    Distance1 = sqrt(Distance1);
    
    % Compute distance between second entry point and source
    Distance2 = EntryPoint2' - Point;
    Distance2 = Distance2.^2;
    Distance2 = sqrt(Distance2);
    
    % Take which ever entry point is closer to the source
    if (Distance1 < Distance2)
        EntryPoint = EntryPoint1;
    else % Distance1 >= Distance2
        EntryPoint = EntryPoint2;
    end
end
