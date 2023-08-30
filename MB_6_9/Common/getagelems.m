function [AGELEM,AGELEM_INDEX] = getagelems(ag_X,ag_Y,Big_ptsN,Big_connN)

% ---------------------------- getagelems.m ------------------------------
% THIS MATLAB FUNCTION CALCULATES THE ELEMENTS IN THE AIRGAP AND ITS INDEX
% IN THE BIG COORDINATE MATRIX

ne  = size(Big_connN,1); 
np  = size(Big_ptsN, 1);
ng  = size(ag_X,     1); 

myX = zeros(5, 1); 
myY = zeros(5, 1);


AGELEM       = []; 
AGELEM_INDEX = [];

incr = 0;
for it = 1:ng
    for jt = 1:ne
        irange = [Big_connN(jt,1:4) Big_connN(jt,1)]';
        myX = Big_ptsN(irange,2); myY = Big_ptsN(irange,3);
        myTH = 0.0;
        for kt = 1:4
            MYA = [myX(kt)-ag_X(it)    myY(kt)-ag_Y(it)]; 
            MYB = [myX(kt+1)-ag_X(it)  myY(kt+1)-ag_Y(it)]; 
            myTH = myTH + acos((MYA*MYB')/(sqrt(MYA*MYA')*sqrt(MYB*MYB')));
        end
        if(abs(myTH-2*pi)<1E-6)
            AGELEM = [AGELEM; Big_connN(jt,:)];
            AGELEM_INDEX = [AGELEM_INDEX; jt];
            break;
        end
    end
end