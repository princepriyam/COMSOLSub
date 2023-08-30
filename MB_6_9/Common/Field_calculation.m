function [BN, BT] = Field_calculation(Az,PTS_MESH,del_t,AGELEM,ag_X,ag_Y,ag_T)


NUM = 1/del_t;


BN = zeros(1025, round(NUM));
BT = zeros(1025, round(NUM));

% BN = zeros(1025, 11);
% BT = zeros(1025, 11);

for jiter = 1:NUM
% for jiter = 1:10
[Bx, By, BM]  = getBxByQ8(AGELEM,PTS_MESH,Az(:,end-jiter),ag_X,ag_Y);

BN(:, jiter) =      Bx.*cos(ag_T) + By.*sin(ag_T) ;
BT(:, jiter) = (-1)*Bx.*sin(ag_T) + By.*cos(ag_T) ;

% if rem(jiter,2) == 1
%    plot(BN(:,jiter))
%    pause(1)
% end
end