function void = Assignment_4_Test()
%%
% Testing DoseBox.m and DrawScene
% PVT = [PVT Raidus, PVT Center]
PVTCenter = [30,0,15];
PVTRadius = 15;
% OAR = [OAR Raidus, OAR Center]
OARRadius = 15;
OARCenter = [0, 30, 45];
[L, R] = DoseBox(PVTRadius, PVTCenter, OARRadius, OARCenter);

headAxis = [80, 100, 80];
headCentre = [0,0,0]; %mm
ptv_radius = 15; %mm
iso = [30,0,15]; %mm
ptv_centre = iso;
oarRadius = 15; %mm
oarCentre = [0,30,45]; %mm

% setting beam list Helmet: [beam_separation_angle = 10 degrees, beam_radius = 15 mm]
beamLongitudeList = [];
beamLatitudeList = [];

for i = 0:35
    if (i < 10)
        beamLatitudeList = [beamLatitudeList, i*10];
    end
    beamLongitudeList = [beamLongitudeList, i*10];
end
array2table(beamLatitudeList);
array2table(beamLongitudeList);

%draw_3D_scene(headCentre, headAxis(1), headAxis(2), headAxis(3),ptv_radius,iso,oar_radius,oar_centre,L,R);
%%
% computeLinearFunction.m

p1 = [1, 1];
p2 = [5, 5];
disp('LinearFunction test case: ');
for x = 0:6
    y = computeLinearFunction(p1, p2, x);
end
%}

%%
% computeRadialDistance.m
% run the function with two known examples of ground truth
% Ground Truth # 1 ( line along y-axis, Point at [3,0,0] it is fairly easy to
% visualize that the closest distance from point to line should be 3
point = [3, 0, 0];
lVector = [0, 1, 0];
lPoint = [0, 0, 0];
line = [lPoint,lVector];
distanceGroundTruth1 = computeRadialDistance(point,line)

% Ground Truth # 2
point = [3, 1, 1];
lVector = [0, 1, 0];
lPoint = [0, 0, 0];
line = [lPoint,lVector];
distanceGroundTruth2 = computeRadialDistance(point,line)



%%
% computeDepthDose.m 
% Running the function, returning and printing our LUT, showing that my
% values match the graph
% using the value of 100mm for max depth from skin because that is the max
% size of our head diameter, the beam dose will not need to be examined 
% further than that distance.

d0 = 20;
depth_from_skin_resolution = 1;
max_depth_from_skin = max(headAxis);

depth_dose_table = computeDepthDose(max_depth_from_skin,d0,...
    depth_from_skin_resolution)


%%
% computeRadialDose.m 
% Running the function, printing LUT, showing that my values match the
% graph
% Beam radius is a global
% 
beamRadius = 15;

maxRadialDistance = 1.5 * beamRadius;
radialDistanceResolution = 1;
radial_dose_table = computeRadialDose(maxRadialDistance, beamRadius,... 
radialDistanceResolution)



%%
% computeBeamDirectionVector.m

testLat = [0,90];
testLong = [0,90,180,270];
disp('Beam Direction Vector Test:');
disp(' ');


testArray = [];

for i = 1:4
    v1=computeBeamDirectionVector(testLong(i),testLat(1));
    v2=computeBeamDirectionVector(testLong(i),testLat(2));
    testArray = [testArray; v1,v2];
end
disp('        Latitude = 0                       Latitude = 90');
disp(testArray);
%T = array2table(testArray,...
%    'RowNames',{'Long0' 'Long90' 'Long180' 'Long270'})
 
 % Now that I have a working beam direction vector, I will calculate a beam
     % vector table
% beamVectorArray = [];
% for i = 1:10
%     for j = 1:36
%         v = computeBeamDirectionVector(testLong(j),testLat(i));
%         beamVectorArray = 
%     end
%      
% end
 
%%
% computeBeamSafety.m
% no tests required, I will just create the Beam Safety table here

%this is the last thing you worked on
%function safe = computeBeamSafety(beamRadius, beam_longitude, beam_latitude, isocenter_point, OARradius, OARcenter)
isocenter = [0,0,0];
beamSafetyTable = [0,beamLatitudeList];
for i = 1:36
    longSafe = [];
    for j = 1:10
       safe = computeBeamSafety(beamRadius, beamLongitudeList(i), beamLatitudeList(j), isocenter, oarRadius, oarCentre);
       longSafe = [longSafe, safe];
    end
    beamSafetyTable = [beamSafetyTable; beamLongitudeList(i), longSafe];
end

disp('Longitude              Latitude ----->');
disp(beamSafetyTable);
end

function void = draw_3D_scene(head_centre,a,b,c,ptv_radius,isocentre_point,oar_radius,oar_centre,LLcorner,URcorner)

% Depiction of 3D scene on which operation will occur.
hold on

%{
## creates a half sphere
[X,Y,Z] = sphere(50);
shading interp;
X = X/1.1;
Y = Y/1.1;
Z = Z/1.1;
[ A B ] = find(X>=0 & Y>=0 & Z>=0);

A = sort(A);
A = unique(A);

colormap gray;
surfl(X(A,B),Y(A,B),Z(A,B));
alpha(0.2)

shading flat;
axis equal;
hold on;
%}

[x,y,z] = ellipsoid(0,0,0,a,b,c);
surf(x,y,z)

alpha(0)
hidden off

[x,y,z] = sphere();
surf(ptv_radius*x+isocentre_point(1),ptv_radius*y+isocentre_point(2),ptv_radius*z+isocentre_point(3))
alpha(0.3)

plot3(isocentre_point(1),isocentre_point(2),isocentre_point(3),'ok','MarkerSize',14)

[x,y,z] = sphere();
surf(oar_radius*x+oar_centre(1),oar_radius*y+oar_centre(2),oar_radius*z+oar_centre(3))
alpha(0.3)

plot3([-15 -15 -15 -15],[-15 45 -15 45],[0 0 60 60],'LineWidth',5);
plot3([45 45 45 45],[-15 45 -15 45],[0 0 60 60],'LineWidth',5);
%}

end


