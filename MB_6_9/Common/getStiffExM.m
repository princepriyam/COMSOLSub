function [Kz, Jz, bz] = getStiffExM(ELEMS,PTS,MYNEU,PMRF)

% ----------------- getStiffExM.m --------------------------
% THIS MATLAB FUNCTION CALCULATES THE FINITE ELEMENT STIFFNESS
% MATRIX AND EXCITATION!!!! elemsGFE,pointsGFEC AND MYNEU ARE 
% THE CONNECTICITY MATRIX COORDINATES MATRIX AND INVERSE OF 
% PERMEABILITY MATRIX FOR EACH ELEMENT

npts  = size(PTS,1); 
nelem = size(ELEMS,1);

% Kz IS THE SO CALLED 'STIFFNESS' MATRIX, Jz IS THE EXCITATION

Kz = sparse(npts, npts); 
% Cz = sparse(npts, npts); 
Jz = sparse(npts, 1);
bz = sparse(npts, 1);

muR = zeros(2,2); 

Total_Slot_Area = MODEL8_area(PTS,ELEMS,4);
Slot_Area = Total_Slot_Area/24;
Nturn = 5;

for ielem = 1:nelem
    
    muR(1,1) = MYNEU(ielem, 1); muR(1,2) = MYNEU(ielem, 2);
    muR(2,1) = MYNEU(ielem, 2); muR(2,2) = MYNEU(ielem, 3);
    
    eprop = ELEMS(ielem, 11);
    
    if(eprop == 64)     
        iprop = ELEMS(ielem, 9);
%         J0    = CURDEN(ielem);
        BR    = PMRF(ielem, :);
                      
        irange = ELEMS(ielem, 1:8).';
        nodeX  = PTS(irange,2);
        nodeY  = PTS(irange,3);
        
        [EMQ8,FQ8,bQ8] = getEMQ8_KCP_PM_rot(nodeX,nodeY,muR,iprop,BR,Slot_Area,Nturn);
               
%         Cz(irange, irange) = Cz(irange,irange)+ECQ8;
        Jz(irange) = Jz(irange) + FQ8 ;       
        bz(irange) = bz(irange) + bQ8 ;
        Kz(irange, irange) = Kz(irange,irange)+EMQ8;        
    else        
        irange = ELEMS(ielem, 1:6).';
        nodeX  = PTS(irange,2);
        nodeY  = PTS(irange,3);
        EMT6   = getEMT6(nodeX,nodeY,muR);
        Kz(irange, irange) = Kz(irange,irange)+EMT6;       
    end  
end