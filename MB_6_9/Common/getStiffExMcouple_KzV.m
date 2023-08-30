function Kz = getStiffExMcouple_KzV(ELEMS, PTS, NEU)
% ----------------- getStiffExMcouple_KzV.m --------------------------
% THIS MATLAB FUNCTION CALCULATES THE FINITE ELEMENT STIFFNESS
% MATRIX AND EXCITATION!!!! elemsGFE,pointsGFEC AND NEU ARE 
% THE CONNECTICITY MATRIX COORDINATES MATRIX AND INVERSE OF 
% PERMEABILITY MATRIX FOR EACH ELEMENT

npts  = size(PTS,1); 
nelem = size(ELEMS,1);

% Kz IS THE SO CALLED 'STIFFNESS' MATRIX, Jz IS THE EXCITATION

Kz  = sparse(npts, npts); 

muR = zeros(2,2); 

for ielem = 1:nelem
    
    muR(1,1) = NEU(ielem,1); muR(1,2) = NEU(ielem,2);
    muR(2,1) = NEU(ielem,2); muR(2,2) = NEU(ielem,3);
    
    irange = ELEMS(ielem, 1:6).';
 
    nodeX  = PTS(irange, 2);
    nodeY  = PTS(irange, 3);
    
    EMT6   = getEMT6(nodeX,nodeY,muR);
    Kz(irange, irange) = Kz(irange, irange) + EMT6;
    
end