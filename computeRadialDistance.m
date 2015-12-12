

function distance = computeRadialDistance(point, line)
linePoint = line(1:3);
direction = line(4:6);
distance = norm(cross(direction, (point - linePoint))/norm(direction));
end
