function Kz = getStiffExMcouple_KzC(ELEMS,PTS,NEU,PDirs)
% ----------------- getStiffEx.m --------------------------
% THIS MATLAB FUNCTION CALCULATES THE FINITE ELEMENT STIFFNESS
% MATRIX AND EXCITATION!!!! elemsGFE,pointsGFEC AND MYNEU ARE 
% THE CONNECTICITY MATRIX COORDINATES MATRIX AND INVERSE OF 
% PERMEABILITY MATRIX FOR EACH ELEMENT

npts  = size(PTS,1); 
nelem = size(ELEMS,1);

% Kz IS THE SO CALLED 'STIFFNESS' MATRIX, Jz IS THE EXCITATION

Kz  = sparse(npts, npts); 

muR = sparse(2,2); 

for ielem = 1:nelem
    
    muR(1,1) = NEU(ielem,3); muR(1,2) = NEU(ielem,2);
    muR(2,1) = NEU(ielem,2); muR(2,2) = NEU(ielem,1);
    
%     iprop = ELEMS(ielem, 9);
%     J0    = CURDEN(ielem);
%     BR    = PMRF(ielem, :);
    PD_Labl = ELEMS(ielem,12);
    PD_Indx = find(PDirs(:,1) == PD_Labl);
    PD_Data = PDirs(PD_Indx,2:4);
          
    irange = ELEMS(ielem, 1:8).';
    
    nodeX  = PTS(irange,2);
    nodeY  = PTS(irange,3);

    EMQ8 = getEMQ8_1couple_KzC_modified(nodeX,nodeY,muR,PD_Data);

    Kz(irange, irange) = Kz(irange,irange) + EMQ8;
end