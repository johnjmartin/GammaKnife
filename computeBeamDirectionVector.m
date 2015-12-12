
function beamVector = computeBeamDirectionVector(beam_long, beam_lat)
if (beam_lat < 0)
    disp('Latitude is out of bounds');
end
helmetRadius = 20;
long = deg2rad(beam_long);
lat = deg2rad(beam_lat);

%[x, y, z] = sphere();
%h = surf(x*2 , y*2 , z*2); %create a surface of the sphere in the correct location
%alpha(h,.15);

%hold on; %pause graph formation until we can add the points

[x,y,z] = sph2cart(long,lat,ones(1,1));
x = helmetRadius*x;
y = helmetRadius*y;
z = helmetRadius*z;
beamVector = -1*([x,y,z] - [0,0,0]) / norm(([x,y,z] - [0,0,0]));
%plot3(x*2,y*2,z*2,'r.');
    
end
