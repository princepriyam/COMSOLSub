function [BN, BT, BM] = RSK_B_only_4m_Az(Az,PTS_MESH,OD_ROT,THIC_AIRGAP,ELE_STA)


mu_O = pi*4E-7 ; % PERMEABILITY OF THE FREE SPACE

%Big_ptsN  = [PTS_ROT; PTS_STA; PTS_AG];
Big_ptsN  = PTS_MESH;

% Big_connN = [ELE_ROT; ELE_STA; ELE_AG];

% NUMBER OF DIVISIONS IN THE AIRGAP
TolDiv = 1024            ;
div1   = (2.0*pi)/TolDiv ;

ag_R = ones(TolDiv+1,1)*0.5*(OD_ROT+THIC_AIRGAP);
%ag_R = ones(TolDiv+1,1)*0.5*(OD_ROT+2*THIC_AIRGAP);
% ag_T = (0.0:div1:(2.0*pi)-div1)';
ag_T = (0.0:div1:(2.0*pi))';

[ag_X, ag_Y] = pol2cart(ag_T, ag_R);

%[AGELEM,AGELEM_INDEX] = getagelems(ag_X,ag_Y,Big_ptsN,ELE_STA);
[AGELEM,AGELEM_INDEX] = getEfL(ag_X,ag_Y,Big_ptsN,ELE_STA);

[ag_T1, ag_R] = cart2pol(ag_X, ag_Y);
[Bx, By, BM]  = getBxByQ8(AGELEM,Big_ptsN,Az,ag_X,ag_Y);

BN =      Bx.*cos(ag_T) + By.*sin(ag_T) ;
BT = (-1)*Bx.*sin(ag_T) + By.*cos(ag_T) ;


