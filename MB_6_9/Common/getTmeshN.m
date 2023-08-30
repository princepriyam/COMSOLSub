function [ELE_AG,PTS_AG] = getTmeshN(PTS_RO,PTS_SI,npts_ro,npts_si,pts_ofset)

% ------------------------------- getTmeshN.m -----------------------------
% FUNCTION TO STITCH THE AIRGAP WITH SIX NODED TRIANGULAR ELEMENT

npts_bnd = (npts_ro+npts_si)/2;

ELE_AG = zeros(npts_bnd,  12);
PTS_AG = zeros(npts_bnd+1, 3);

PTS_AG(:,1) = (1:npts_bnd+1)'+pts_ofset;

PTS_AG(1,2) = 0.5*(PTS_RO(1,2)+PTS_SI(1,2));
PTS_AG(1,3) = 0.5*(PTS_RO(1,3)+PTS_SI(1,3));

ELE_AG(1,1) = PTS_RO(1,1);
ELE_AG(1,3) = PTS_SI(1,1);
ELE_AG(1,6) = PTS_AG(1,1);

ELE_DU(1,1) = 1;
ELE_DU(1,2) = 1;

X01 = PTS_RO(1, 2); 
Y01 = PTS_RO(1, 3);

X02 = PTS_SI(3, 2); 
Y02 = PTS_SI(3, 3);
 
dist1 = sqrt((X01-X02)*(X01-X02)+(Y01-Y02)*(Y01-Y02));
 
X11 = PTS_RO(3, 2); 
Y11 = PTS_RO(3, 3);
X12 = PTS_SI(1, 2); 
Y12 = PTS_SI(1, 3);
    
% disp([X11 Y11 X12 Y12]) ;
% disp(' check the x and y coordinates ')
% pause
dist2 = sqrt((X11-X12)*(X11-X12)+(Y11-Y12)*(Y11-Y12));

if(dist1 > dist2) 
    PTS_AG(2,2) = 0.5*(PTS_RO(3,2)+PTS_SI(1,2));
    PTS_AG(2,3) = 0.5*(PTS_RO(3,3)+PTS_SI(1,3));
    ELE_AG(1,2)=PTS_RO(3,1); 
    ELE_AG(1,4)=PTS_RO(2,1); 
    ELE_AG(1,5)=PTS_AG(2,1);
    rot_index1 = 3 ;
    sta_index1 = 1 ;
    prop = 1;
else
    PTS_AG(2,2) = 0.5*(PTS_RO(1,2)+PTS_SI(3,2));
    PTS_AG(2,3) = 0.5*(PTS_RO(1,3)+PTS_SI(3,3));
    ELE_AG(1,2)=PTS_SI(3,1); 
    ELE_AG(1,4)=PTS_AG(2,1);
    ELE_AG(1,5)=PTS_SI(2,1);
    rot_index1 = 1 ;
    sta_index1 = 3 ;
    prop = 2;
end 

for ielem = 2:npts_bnd
  if(prop == 1)
    ELE_AG(ielem, 1) = ELE_AG(ielem-1, 2);
    ELE_AG(ielem, 3) = ELE_AG(ielem-1, 3); 
  else
    ELE_AG(ielem, 1) = ELE_AG(ielem-1, 1);
    ELE_AG(ielem, 3) = ELE_AG(ielem-1, 2);
  end

  rot_index = find(abs(ELE_AG(ielem, 1)-PTS_RO(:, 1))<1E-10);
  sta_index = find(abs(ELE_AG(ielem, 3)-PTS_SI(:, 1))<1E-10);
  
  index_i = rot_index ;
  index_m = sta_index ;
  
  if(sta_index == (npts_si-1)) sta_index = -1; else sta_index = sta_index; end
  if(rot_index == (npts_ro-1)) rot_index = -1; else rot_index = rot_index; end
  
  index_j = sta_index+2 ;
  
  X01 = PTS_RO(index_i, 2); Y01 = PTS_RO(index_i, 3);
  X02 = PTS_SI(index_j, 2); Y02 = PTS_SI(index_j, 3);

  dist1 = sqrt((X01 - X02)*(X01 - X02)+(Y01 - Y02)*(Y01 - Y02));	
  
  index_k = rot_index+2 ;
  
  X11 = PTS_RO(index_k, 2); Y11 = PTS_RO(index_k, 3);
  X12 = PTS_SI(index_m, 2); Y12 = PTS_SI(index_m, 3);
  
  dist2 = sqrt((X11 - X12)*(X11 - X12)+(Y11 - Y12)*(Y11 - Y12));
  
  if(dist1 > dist2)	
      ELE_AG(ielem,2)=PTS_RO(rot_index+2,1);
      if(sta_index==-1)
        PTS_AG(ielem+1,2) = 0.5*(PTS_RO(rot_index+2,2)+PTS_SI(npts_si-1,2));
        PTS_AG(ielem+1,3) = 0.5*(PTS_RO(rot_index+2,3)+PTS_SI(npts_si-1,3));
      else
        PTS_AG(ielem+1,2) = 0.5*(PTS_RO(rot_index+2,2)+PTS_SI(sta_index,2));
        PTS_AG(ielem+1,3) = 0.5*(PTS_RO(rot_index+2,3)+PTS_SI(sta_index,3));
      end
      if(rot_index == -1)
          ELE_AG(ielem,4)=PTS_RO(npts_ro,1);
      else
          ELE_AG(ielem,4)=PTS_RO(rot_index+1,1);
      end
      if(ielem==npts_bnd)
        ELE_AG(ielem,5)=PTS_AG(1,1);
      else
        ELE_AG(ielem,5)=PTS_AG(ielem+1,1);
      end      
      
      prop = 1;
  else 
      ELE_AG(ielem,2)=PTS_SI(sta_index+2,1);
      
      if(rot_index==-1)
        PTS_AG(ielem+1,2) = 0.5*(PTS_RO(npts_ro-1,2)+PTS_SI(sta_index+2,2));
        PTS_AG(ielem+1,3) = 0.5*(PTS_RO(npts_ro-1,3)+PTS_SI(sta_index+2,3));
      else
        PTS_AG(ielem+1,2) = 0.5*(PTS_RO(rot_index,2)+PTS_SI(sta_index+2,2));
        PTS_AG(ielem+1,3) = 0.5*(PTS_RO(rot_index,3)+PTS_SI(sta_index+2,3));
      end
      
      if(sta_index==-1)
        ELE_AG(ielem,5)=PTS_SI(npts_si,1);
      else
        ELE_AG(ielem,5)=PTS_SI(sta_index+1,1);
      end  
      
      if(ielem==npts_bnd)
        ELE_AG(ielem,4)=PTS_AG(1,1);
      else
        ELE_AG(ielem,4)=PTS_AG(ielem+1,1);
      end
          
      prop = 2; 
  end
  
  ELE_AG(ielem,6) = PTS_AG(ielem,1);
end


PTS_AG(npts_bnd+1,:) = [];
ELE_AG(:,  9) =    3;
ELE_AG(:, 11) =   32;
ELE_AG(:, 12) = 7001;
ELE_AG(:, 13) =    0;