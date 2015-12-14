%Question 2: compute the (approximate) intersection of two lines
function [ approxInter, error ] = lineLineIntersection(line1point1, line1point2, line2point1, line2point2)
    
    %error checking
    if length(line1point1) ~= 3 || length(line1point2) ~= 3 || length(line2point1) ~= 3 || length(line2point2) ~= 3
       disp ('incorrect number of coordinates in points')
       return
    end
   
    %direction vectors for the three lines
    v1 = line1point2 - line1point1;
    v2 = line2point2 - line2point1;
    v3 = cross(v1,v2);
    
    %creating the matrices for the system of linear equations (based on
    %class notes)
    A = [-v1(1) v2(1) v3(1); -v1(2) v2(2) v3(2); -v1(3) v2(3) v3(3)];
    B = transpose(line1point1 - line2point1);

    %solving the system and finding t1 and t2
    t = A\B;
    
    %determining the point of intersection by substituting t into the
    %equations of the lines to find where they are equal
    L1 = line1point1 + t(1)*v1;
    L2 = line2point1 + t(2)*v2;
    

    %if v3 = 0 (cross product of the two direction vectors are 0) the lines are parallel
    %if error == 0, exact intersection otherwise an approximation
    %otherwise they are skew line
    
    approxInter = (L1+L2)/2;
    %distance from approximate centre to a line
    error = norm(L1-L2)/2;


end

