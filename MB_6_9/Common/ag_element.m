function [AGELEM, ag_T,ag_X,ag_Y] = ag_element(PTS,R,ELE)

Big_ptsN  = PTS;

% NUMBER OF DIVISIONS IN THE AIRGAP
% TolDiv = 1024            ;
TolDiv = 1024            ;
div1   = (2.0*pi)/TolDiv ;

% ag_R = ones(TolDiv+1,1)*0.5*(OD_ROT+THIC_AIRGAP)+(1/8)*THIC_AIRGAP+0.000001;

% ag_R = ones(TolDiv+1,1)*0.04775+0.0001;
% ag_R = ones(TolDiv+1,1)*0.047083333333333+0.0001;
ag_R = ones(TolDiv+1,1)*R+0.0001;

% ag_R = ones(TolDiv+1,1)*0.5*(OD_ROT+2*THIC_AIRGAP)+0.0001;
% ag_T = (0.0:div1:(2.0*pi)-div1)';
ag_T = (0.0:div1:(2.0*pi))';

[ag_X, ag_Y] = pol2cart(ag_T, ag_R);

% [AGELEM,AGELEM_INDEX] = getagelems(ag_X,ag_Y,Big_ptsN,ELE_STA);
[AGELEM,AGELEM_INDEX] = getEfL(ag_X,ag_Y,Big_ptsN,ELE);

end

