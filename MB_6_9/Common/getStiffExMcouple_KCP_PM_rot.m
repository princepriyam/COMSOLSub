function [Kz,Pz,bz] = getStiffExMcouple_KCP_PM_rot(ELEMS,PTS,SLOT_STA,MYNEU,PMRF,PDirs)
% -------------- getStiffExMcouple_KCP_SLIP_rot.m -------------------------
% THIS MATLAB FUNCTION CALCULATES THE FINITE ELEMENT STIFFNESS
% MATRIX AND EXCITATION!!!! elemsGFE,pointsGFEC AND NEU ARE 
% THE CONNECTICITY MATRIX COORDINATES MATRIX AND INVERSE OF 
% PERMEABILITY MATRIX FOR EACH ELEMENT

npts  = size(PTS,   1); 
nelem = size(ELEMS, 1);

% Kz IS THE SO CALLED 'STIFFNESS' MATRIX,
Kz = sparse(npts, npts); 
Pz = sparse(npts, 2*SLOT_STA);

% Cz  = sparse(npts, npts);
% Pr  = sparse(npts,   SLOT_ROT);
% P_dash_f  = sparse(npts, SLOT_ROT);

bz  = sparse(npts, 1);
muR = zeros(2,    2); 

Area_hlf_slot1 = ele8_area_slot(PTS,ELEMS, 1);  % Half slot area for odd
                                                % numbered coil sides
Area_hlf_slot2 = ele8_area_slot(PTS,ELEMS, 2);  % Half slot area for even
                                                % numbered coil sides

% Total_Slot_Area = MODEL8_area(PTS,ELEMS,4);
% Slot_Area       = Total_Slot_Area/24;
% Slot_Area_half  = 0.5*Slot_Area;
Nturn = 5;
% Nturn = 15;

% krange = [];

for ielem = 1:nelem
    
    muR(1,1) = MYNEU(ielem,1);  muR(1,2) = MYNEU(ielem,2);
    muR(2,1) = MYNEU(ielem,2);  muR(2,2) = MYNEU(ielem,3);
    
    eprop = ELEMS(ielem, 11);
    iprop = ELEMS(ielem, 9);
    islot = ELEMS(ielem, 10);
    BR    = PMRF(ielem, :);
    PD_Labl = ELEMS(ielem,12);
    PD_Indx = find(PDirs(:,1) == PD_Labl);
    PD_Data = PDirs(PD_Indx,2:4);
    
    if(eprop == 64)
%         J0    = CURDEN(ielem);            
        irange = ELEMS(ielem, 1:8).';
        nodeX  = PTS(irange,2);
        nodeY  = PTS(irange,3);
        
        if (iprop == 4) 
            if (mod(ELEMS(ielem,10),2) == 1)
                Area_slot = Area_hlf_slot1;   % Half slot area for odd 
                                              % numbered coil sides
            else
                Area_slot = Area_hlf_slot2;   % Half slot area for even 
                                              % numbered coil sides
            end
        else
            Area_slot = 0;     % As we need area only of the slots 
                               % (Half slot area or coil side area)
        end
        
        [EMQ8,PQ8,bQ8] = getEMQ8_KCP_PM_rot_modified(nodeX,nodeY,muR,iprop,BR,Area_slot,Nturn,PD_Data);
        
        Kz(irange, irange) = Kz(irange,irange) + EMQ8;
        
        if (iprop == 4)   
%             krange = [krange; irange];
            Pz(irange, islot) = Pz(irange,islot) + PQ8;
        end
          
        if (iprop==8)|(iprop==6)
            bz(irange, 1) = bz(irange, 1) + bQ8;
        end
        
    else
        
        irange = ELEMS(ielem, 1:6).';
        nodeX  = PTS(irange,2);
        nodeY  = PTS(irange,3);
        EMT6   = getEMT6(nodeX,nodeY,muR);   % Require editing for priciple direction info
        Kz(irange, irange) = Kz(irange,irange)+EMT6;
        
    end  
end