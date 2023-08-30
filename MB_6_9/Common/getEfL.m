function [AGELEM,AGELEM_INDEX] = getEfL(ag_X,ag_Y,PTS,ELE)

% ---------------------------- getEfL.m ------------------------------
% THIS MATLAB FUNCTION CALCULATES THE ELEMENTS IN THE AIRGAP AND ITS INDEX
% IN THE BIG COORDINATE MATRIX

% ----------------------------  NOTE ----------------------------------
% ONE CONDITION HAS TO PUT TO MAKE SURE THAT DENOMINATOR DOESNOT BECOME 
% ZERO

ne  = size(ELE,  1); 
np  = size(PTS,  1);
ng  = size(ag_X, 1); 

Xd = zeros(5, 1); 
Yd = zeros(5, 1);

AGELEM       = []; 
AGELEM_INDEX = [];

incr = 0;
for it = 1:ng
    for jt = 1:ne
        irange = [ELE(jt,1:4) ELE(jt,1)]';
        Xd = PTS(irange, 2); 
        Yd = PTS(irange, 3);
        THETA = 0.0;
        for kt = 1:4
            a = [Xd(kt)-ag_X(it)    Yd(kt)-ag_Y(it)  ]; 
            b = [Xd(kt+1)-ag_X(it)  Yd(kt+1)-ag_Y(it)]; 
            d = (sqrt(a*a')*sqrt(b*b')) ;
            THETA = THETA + acos((a*b')/d);
        end
        if(abs(THETA-2*pi)<1E-4)
            AGELEM = [AGELEM; ELE(jt,     :)];
            AGELEM_INDEX = [AGELEM_INDEX; jt];
            break;
        end
    end
end