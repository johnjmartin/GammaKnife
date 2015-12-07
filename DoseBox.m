function [Left, Right] = DoseBox(ptvRadius,ptvCenter,oarRadius,oarCenter)
PTVmin = ptvCenter-ptvRadius;
OARmin = oarCenter-oarRadius;
PTVmax = ptvCenter+ptvRadius;
OARmax = oarCenter+oarRadius;


%The dose box alligns to the edge of the OAR and PTV spheres
Left = min(PTVmin,OARmin);
Right = max(PTVmax,OARmax);
end