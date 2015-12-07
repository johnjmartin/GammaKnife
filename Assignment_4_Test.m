function void = Assignment_4_Test()
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
oar_radius = 15; %mm
oar_centre = [0,30,45]; %mm

draw_3D_scene(headCentre, headAxis(1), headAxis(2), headAxis(3),ptv_radius,iso,oar_radius,oar_centre,L,R);

%%
% Test_compute_depth_dose
clear
d0 = 30;
x=1;
for depth_from_skin = 0:15:240
    depth_dose_value = compute_depth_dose(depth_from_skin,d0);
    test_table(x,1) = depth_from_skin/d0;
    test_table(x,2) = depth_dose_value;
    x=x+1;
end
test_table

%%
% Test_compute_depth_dose
clear
beam_radius = 15;
x=1;
for radial_distance = 0:3.75:18.75
    radial_dose_value = compute_radial_dose(beam_radius, radial_distance);
    test_table(x,1) = radial_distance/beam_radius;
    test_table(x,2) = radial_dose_value;
    x=x+1;
end
test_table


end


function y = LinearFunc(P1,P2,x)

%Test for correct bounds and non-zero denominator
if (P1(1)<=x && x<=P2(1)) && P2(1)-P1(1) ~= 0
    
    %Calculate slope and intercept to find y value
    m = (P2(2)-P1(2))/(P2(1)-P1(1));
    b = P1(2) - m*P1(1);
    y = m*x + b;
else
    display('Requested x value out of range or slope is infinite')
    y = 9999;
end

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
