function [ ] = computeDoseVolumeHistogram( head, helmet, PTV, OAR, isocentrePoint )
%COMPUTEDOSEVOLUMEHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
    global doseBox;
    %dosebox dimensions
    dbX = abs(doseBox(1) - doseBox(4));
    dbY = abs(doseBox(2) - doseBox(5));
    dbZ = abs(doseBox(3) - doseBox(6));
    
    voxelSize = 5;
    
    xVoxelCount = dbX/voxelSize;
    yVoxelCount = dbY/voxelSize;
    zVoxelCount = dbZ/voxelSize;
    
    %3D matrix representing the dosebox
    dbMatrix = zeros(xVoxelCount,yVoxelCount,zVoxelCount);
    
    doseValueOAR = zeros(1,xVoxelCount*yVoxelCount*zVoxelCount);
    doseValuePTV = zeros(1,xVoxelCount*yVoxelCount*zVoxelCount);
    doseValueOARCount = 1;
    doseValuePTVCount = 1;
    
    for n = 1:zVoxelCount
        for m = 1:xVoxelCount
            for o = 1:yVoxelCount
                cornerPoint1 = [doseBox(1) + voxelSize * (m - 1), doseBox(2) + voxelSize * (o - 1), doseBox(3) + voxelSize * (n - 1)];
                cornerPoint2 = cornerPoint1 + voxelSize;
                voxelCentre = (cornerPoint1 + cornerPoint2) / 2;
                dbMatrix(m,o,n) = isPointInsideOAR(voxelCentre, OAR);
                
                if dbMatrix(m,o,n) == 0
                    dbMatrix(m,o,n) = isPointInsidePTV(voxelCentre, PTV);
                end
                
              
                if dbMatrix(m,o,n) > 0
                    voxelDose = computePointDose( head, helmet, OAR, isocentrePoint, voxelCentre );
                    %inside PTV
                    if dbMatrix(m,o,n) == 1                       
                        doseValuePTV(doseValuePTVCount) =  voxelDose;
                        doseValuePTVCount = doseValuePTVCount + 1;
                    %inside OAR
                    elseif dbMatrix(m,o,n) == 2
                        doseValueOAR(doseValueOARCount) =  voxelDose;
                        doseValueOARCount = doseValueOARCount + 1;
                    end
                  
                end

            end
             
        end
         disp(n);
    end
    doseValuePTV = doseValuePTV(1:doseValuePTVCount-1);
    doseValueOAR = doseValueOAR(1:doseValueOARCount-1);
    disp(doseValuePTV);
    disp(doseValueOAR);
    
    figure
    h = histfit(doseValuePTV,[],'kernel');
    %h.BinEdges = [0:max(doseValuePTV)];
    figure
    i = histfit(doseValueOAR,[],'kernel');
    %i.BinEdges = [0:max(doseValueOAR)];
    
    
    
end

