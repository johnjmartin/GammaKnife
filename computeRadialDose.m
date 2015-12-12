%{
Compute raidial dose, this function returns a table with the distance from
the beam as the first row, and each corresponding dose values at the next value
%}
function radialDoseLUT = computeRadialDose( max_distance, beamRadius, radial_resolution )

radialDoseLUT = [];
for radius = 1: radial_resolution: max_distance
    x = radius/beamRadius;
    if (x >= 0 && x <= 0.5)
        depthDoseAtX = 1;
    end
    if (x > 0.5)
        depthDoseAtX = computeLinearFunction([0.5, 1], [1.5, 0], x);
    end
    if (x > 1.5)
        depthDoseAtX = 0;
    end
    radialDoseLUT = [radialDoseLUT,[radius; depthDoseAtX]];
end

