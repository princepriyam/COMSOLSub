function bound_index = getBoundIndex(OD_STA, PTS_MESH)

%----------------------- getBoundIndex.m ------------------------------
%THIS MATLAB FUNCTION EXATRACT THE NODES CORRESPONDS TO THE OUTER BOUNDARY
%TO APPLY THE BOUNDARY CONDITION

%GET THE BOUNDARY OF THE DOMAIN TO PUT THE BOUNDARY CONDITION
PTS_MESH_P = PTS_MESH; % Convert coordinates from Cartesian to Polar

[PTS_MESH_P(:,3), PTS_MESH_P(:,2)] = cart2pol(PTS_MESH_P(:,2), PTS_MESH_P(:,3));

bound_index = find(abs(PTS_MESH_P(:, 2)-0.5*OD_STA)<1E-6);

end 

% [BND_NDS(:,3), BND_NDS(:,2)] = cart2pol(BND_NDS(:,2), BND_NDS(:,3));