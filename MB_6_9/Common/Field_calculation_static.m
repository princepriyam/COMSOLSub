function [BN, BT] = Field_calculation_static(Az,theta,PTS_MESH,AGELEM,ag_X,ag_Y,ag_T)


NUM =  size(theta,2);

BN = zeros(1025, NUM);
BT = zeros(1025, NUM);

% BN = zeros(1025, 11);
% BT = zeros(1025, 11);

for jiter = 1:NUM
% for jiter = 1:10
[Bx, By, BM]  = getBxByQ8(AGELEM,PTS_MESH,Az(:,jiter),ag_X,ag_Y);

BN(:, jiter) =      Bx.*cos(ag_T) + By.*sin(ag_T) ;
BT(:, jiter) = (-1)*Bx.*sin(ag_T) + By.*cos(ag_T) ;


plot(BN(:,jiter))
pause(0.5)

end