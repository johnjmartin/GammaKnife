
function [ beamDirectionVector ] = computeBeamDirectionVector(beamLongitude, beamLatitude)

    if (beamLatitude < 0)
        disp('Latitude is out of bounds');
    end

    longInRads = deg2rad(beamLongitude);
    latInRads = deg2rad(beamLatitude);

    [x,y,z] = sph2cart(longInRads,latInRads,1);

    beamDirectionVector = ([x,y,z] - [0,0,0]) / norm([x,y,z] - [0,0,0]);
    
end
