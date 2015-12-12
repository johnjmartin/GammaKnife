% This function computes the skin entry point table for all longitude and
% latitudes allowed in the Gamma-knife. 
function [skin_entry_table] = getSkinEntryPointTable(head, center, radius, increment)
    
    LongitudeAngles = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360];
                   
    LatitudeAngles = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90];
    
    sizeLong = size(LongitudeAngles);
    sizeLong = sizeLong(2);
    
    sizeLat = size(LatitudeAngles);
    sizeLat = sizeLat(2);
    
    EntryArray = zeros(370,3);
    count = 1;
    for i = 1 : sizeLat
        for j = 1 : sizeLong
            EntryPoint = Compute_Skin_Entry_Point(head, LongitudeAngles(j), LatitudeAngles(i), center, radius);
            EntryArray(count,:) = EntryPoint;
            count = count + 1;
        end
    end
    
    
    EntryMatrix = zeros(36, 30);
    EntryMatrix(1:37,1:3) = EntryArray(1:37,1:3);
    EntryMatrix(1:37,4:6) = EntryArray(38:74, 1:3);
    EntryMatrix(1:37,7:9) = EntryArray(75:111, 1:3);
    EntryMatrix(1:37,10:12) = EntryArray(112:148, 1:3);
    EntryMatrix(1:37,13:15) = EntryArray(149:185, 1:3);
    EntryMatrix(1:37,16:18) = EntryArray(186:222, 1:3);
    EntryMatrix(1:37,19:21) = EntryArray(223:259, 1:3);
    EntryMatrix(1:37,22:24) = EntryArray(260:296, 1:3);
    EntryMatrix(1:37,25:27) = EntryArray(297:333, 1:3);
    EntryMatrix(1:37,28:30) = EntryArray(334:370, 1:3);
    
    LatArray = [0,0,0,0,10,10,10,20,20,20,30,30,30,40,40,40,50,50,50,60,60,60,70,70,70,80,80,80,90,90,90];
    
    LongArray = LongitudeAngles';
    EntryMatrix = cat(2,LongArray,EntryMatrix);
    EntryMatrix = cat(1, LatArray, EntryMatrix);
    skin_entry_table = EntryMatrix;
end