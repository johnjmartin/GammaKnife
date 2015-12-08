% Function used to compute where the Gamma Knife x-ray will go through the
% person's skin. This function creates a line from the isocenter(tumor) and
% the point on the helmet determined by the longitude and latitude of source
% and radius of Gamma Knife. It then finds the intersection of this line
% and the head, defined as an elipsoid with 3 axis, A, B, and C. It then
% determines which of the (probable) 2 intersection points is closer to the
% source, and uses that as the skin entry point.
%
% Inputs: Ellipsoid of head given as [A,B,C] vertices (head)
%         Longitude of beam source (long)
%         Latitude of beam source (lat)
%         Center of hemisphere helmet (isocenter)
%         Radius of Gamma Knife helmet (radius)
%
% Output: Calculated skin entry point (EntryPoint)

function [EntryPoint] = computeSkinEntryPoint(head, long, lat, isocenter, radius)

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
    
    Point = [x,y,z]
    
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