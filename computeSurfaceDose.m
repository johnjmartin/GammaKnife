function [ ] = computeSurfaceDose( head, helmet, isocentrePoint, PTV, OAR )
%COMPUTESURFACEDOSE Summary of this function goes here
%   Detailed explanation goes here
    sphereResolution = 10;
    figure
    hold on
    colormap jet
    axis equal
        
    %PTV
    %surf(X*OAR(1)+OAR(2),Y*OAR(1)+OAR(3),Z*OAR(1)+OAR(4))
    
    %ignore last columns of X,Y,Z, i.e. if sphere(10), go 1-10, ignore 11
    %disp(X);
    
    OARdose = [];
    OARsa = [];
    PTVdose = [];
    PTVsa = [];
    
    dose = zeros(1,sphereResolution^2);
    sa = zeros(1,sphereResolution^2);
    
    for o = 1:2
        
        if o == 1
            [X,Y,Z] = sphere(sphereResolution);
            [X] = (X*PTV(1)+PTV(2));
            [Y] = (Y*PTV(1)+PTV(3));
            [Z] = (Z*PTV(1)+PTV(4));
            surf(X,Y,Z)
        else
            [X,Y,Z] = sphere(sphereResolution);
            [X] = (X*OAR(1)+OAR(2));
            [Y] = (Y*OAR(1)+OAR(3));
            [Z] = (Z*OAR(1)+OAR(4));
            surf(X,Y,Z)
        end
        
        for n = 1:sphereResolution
            for m = 1:sphereResolution
                point1 = [X(n,m), Y(n,m), Z(n,m)];
                point2 = [X(n+1,m), Y(n+1,m), Z(n+1,m)];
                point3 = [X(n,m+1), Y(n,m+1), Z(n,m+1)];
                point4 = [X(n+1,m+1), Y(n+1,m+1), Z(n+1,m+1)];
                
                [centrePoint,~] = lineLineIntersection(point1,point4,point2,point3);
 
                dose(10 * (n-1) + m) = computePointDose( head, helmet, OAR, isocentrePoint, centrePoint );
                sa(10 * (n-1) + m) = norm(cross(point3 - point1,point2 - point1))/2 + norm(cross(point3 - point4,point2 - point4))/2;
            end
        end  
        
        if o == 1
            PTVdose = dose;
            PTVsa = sa;
        else
            OARdose = dose;
            OARsa = sa;
        end
            
    end
    
    %disp(PTVsa);
    %disp(OARsa);

end

