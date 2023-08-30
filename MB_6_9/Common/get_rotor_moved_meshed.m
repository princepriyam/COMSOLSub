function [PTS_ROT,PTS_RO,PTS_AGM,ELE_AGM,KPTS_ROT] = get_rotor_moved_meshed(del_t,OME_MECH,PTS_ROT,PTS_RO,PTS_SI,...
    npts_ro,npts_si,pts_ofset,KPTS_ROT,ti)

TH  = OME_MECH * (ti-1)*del_t;

% MODIFY THE ANGULAR POSITION OF THE ROTOR 

[PTS_ROT(:, 3), PTS_ROT(:,2)]  = cart2pol(PTS_ROT(:, 2), PTS_ROT(:,3)) ;
[KPTS_ROT(:,3),KPTS_ROT(:,2)]  = cart2pol(KPTS_ROT(:,2),KPTS_ROT(:,3)) ;

PTS_ROT(:,3)                 = PTS_ROT(:,3) + TH                   ;
[PTS_ROT(:,2),PTS_ROT(:,3)]  = pol2cart(PTS_ROT(:,3),PTS_ROT(:,2)) ;

KPTS_ROT(:,3)                 = KPTS_ROT(:,3) + TH                   ;
[KPTS_ROT(:,2),KPTS_ROT(:,3)]  = pol2cart(KPTS_ROT(:,3),KPTS_ROT(:,2)) ;

% MODIFY THE ANGULAR POSITION OF THE NODES ON THE OUTER RADIUS OF THE ROTOR

[PTS_RO(:,3),PTS_RO(:,2)]    = cart2pol(PTS_RO(:,2),PTS_RO(:,3))   ;
PTS_RO(:,3)                  = PTS_RO(:,3) + TH                    ;
[PTS_RO(:,2),PTS_RO(:,3)]    = pol2cart(PTS_RO(:,3),PTS_RO(:,2))   ;
[PTS_RO(:,3),PTS_RO(:,2)]    = cart2pol(PTS_RO(:,2),PTS_RO(:,3))   ;

pts_neg           = find(PTS_RO(:,3)<0.0)      ;
PTS_RO(pts_neg,3) = PTS_RO(pts_neg,3) + 2.0*pi ;
PTS_RO            = sortrows(PTS_RO,3)         ;

[PTS_RO(:,2),PTS_RO(:,3)]    = pol2cart(PTS_RO(:,3),PTS_RO(:,2))   ;

% STITCH THE ROTOR AND STATOR WITH SIX NODED TRIANGULAR ELEMENT

[ELE_AGM,PTS_AGM] = getTmeshN(PTS_RO,PTS_SI,npts_ro,npts_si,pts_ofset);
end