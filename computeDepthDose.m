function depthDoseLUT = computeDepthDose(max_depth, d0, depth_resolution)

depthDoseLUT = [];

for depth = 1: depth_resolution: max_depth
    x = depth/d0;
    if (x >= 0 && x <= 1)
        depthDoseAtX = computeLinearFunction([0,0], [1,1], x);
    end
    if (x > 1)
        depthDoseAtX = computeLinearFunction([1,1], [6, 0.5], x);
    end
    if (x < 0)
        depthDoseAtX = 0;
    end
    depthDoseLUT = [depthDoseLUT,[depth;depthDoseAtX]];
end