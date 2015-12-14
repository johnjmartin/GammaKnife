%Question 4: compute the intersection of a line and an ellipsoid
function [ intersect1, intersect2 ] = lineEllipsoidIntersection( directionVector, point2, a, b, c )
    
    %error checking
    if length(directionVector) ~= 3 || length(point2) ~= 3 
       disp ('incorrect number of coordinates in points')
       return
    end
      
    %determine the 3 coefficients of the quadratic equation
    coeff1 = directionVector(1).^2/a.^2 + directionVector(2).^2/b.^2 + directionVector(3).^2/c.^2;
    coeff2 = 2.*directionVector(1).*point2(1)/a.^2 + 2.*directionVector(2).*point2(2)/b.^2 + 2.*directionVector(3).*point2(3)/c.^2;
    coeff3 = point2(1).^2/a.^2 + point2(2).^2/b.^2 + point2(3).^2/c.^2 - 1;
       
    %determine the roots of the polynomial, i.e. find t
    p = [coeff1 coeff2 coeff3];
    r = roots(p);

    %discriminant is less than 0, meaning complex roots and no solution
    if (coeff2^2 - 4*coeff1*coeff3) < 0
        disp('no solution');
        intersect1 = 'null';
        intersect2 = 'null';
        return
    else
        %substitute t back into the equation of the line to determine where
        %the line intersects the ellipsoid
        intersect1 = [point2(1) + r(1).*directionVector(1),point2(2) + r(1).*directionVector(2), point2(3) + r(1).*directionVector(3)];
        intersect2 = [point2(1) + r(2).*directionVector(1),point2(2) + r(2).*directionVector(2), point2(3) + r(2).*directionVector(3)];
    end
end

