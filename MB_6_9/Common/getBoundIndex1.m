function bound_index = getBoundIndex1(ID_ROT, OD_STA, PTS_MESH)

%----------------------- getBoundIndex.m ------------------------------
%THIS MATLAB FUNCTION EXATRACT THE NODES CORRESPONDS TO THE OUTER BOUNDARY
%TO APPLY THE BOUNDARY CONDITION

%GET THE BOUNDARY OF THE DOMAIN TO PUT THE BOUNDARY CONDITION
PTS_MESH_P = PTS_MESH; % Convert coordinates from Cartesian to Polar

[PTS_MESH_P(:,3), PTS_MESH_P(:,2)] = cart2pol(PTS_MESH(:,2), PTS_MESH(:,3));

bound_index1 = find(abs(PTS_MESH_P(:, 2)-0.5*OD_STA)<1E-6);
bound_index2 = find(abs(PTS_MESH_P(:, 2)-0.5*ID_ROT)<1E-6);

bound_index = [bound_index1; 
               bound_index2];

end 

% [BND_NDS(:,3), BND_NDS(:,2)] = cart2pol(BND_NDS(:,2), BND_NDS(:,3));