function [PTS_ROT,PTS_RO,PTS_AG,ELE_AG] = rotor_moved_mesh(ang,PTS_ROT,PTS_RO,PTS_SI,npts_ro,npts_si,pts_ofset)

    % Rotation matrix
    R = [ cos(ang)  -sin(ang) ;
          sin(ang)   cos(ang)];
     
    PTS_ROT(:,2:3) = PTS_ROT(:,2:3) * R.';
    PTS_RO(:, 2:3) = PTS_RO(:, 2:3) * R.';
    
    [PTS_RO(:,3),PTS_RO(:,2)]    = cart2pol(PTS_RO(:,2),PTS_RO(:,3))   ;

    pts_neg                      = find(PTS_RO(:,3)<0.0)               ;
    PTS_RO(pts_neg,3)            = PTS_RO(pts_neg,3) + 2.0*pi          ;
    PTS_RO                       = sortrows(PTS_RO,3)                  ;

    [PTS_RO(:,2),PTS_RO(:,3)]    = pol2cart(PTS_RO(:,3),PTS_RO(:,2))   ;
    
    
    [ELE_AG,PTS_AG] = getTmeshN(PTS_RO,PTS_SI,npts_ro,npts_si,pts_ofset);

end