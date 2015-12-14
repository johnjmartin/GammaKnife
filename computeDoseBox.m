function [doseBox] = computeDoseBox(PTV,OAR)
    PTVmin = PTV(2:4)-PTV(1);
    OARmin = OAR(2:4)-OAR(1);
    PTVmax = PTV(2:4)+PTV(1);
    OARmax = OAR(2:4)+OAR(1);


    %The dose box alligns to the edge of the OAR and PTV spheres
    doseBox = min(PTVmin,OARmin);
    doseBox = [doseBox, max(PTVmax,OARmax)];
end