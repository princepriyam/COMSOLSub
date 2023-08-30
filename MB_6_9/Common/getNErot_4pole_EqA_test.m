 function [KPTS_ROT,KELE_ROT,PTS_ROT,ELE_ROT,KDIVR] = getNErot_4pole_EqA_test()

% --- Rotor_Bay_KPs ---
% This script generates the KeyPoints array <KeyPts> for the model of one
% bay of the rotor from the machine called <AM_24th>. 
% The rotor bay is relatively simple - comprising only 8 SMR4s in 2 layers
% The innermost layer is all iron.
% The middle layer is part PM material and part spacer material (low mu)
% Note that although this rotor does have a banding layer, we do not 
% represent that here because the properties are identical to airgap.
% We must simply ensure that the eccentricity never becomes large!
% The magnet OD here is 91.5mm. The banding OD on the drawing is probably
% 92mm.  The stator bore diameter is 95.5mm anyway.
% ---------------------------------------------------------------------

clf
addpath('D:\Matlab\SRK_PM\Prepox')

PM_Params = getparams() ; % Get the parameters of stator and rotor.

% --- Set up the different radii for "corner KeyPoints".
R21 = 0.5*PM_Params.ID_ROT;  % Radius to bore of the rotor core pack
R23 = 84.5E-3/2;  % Radius to the inner edges of the PM pieces
R25 = 0.5*PM_Params.OD_ROT;  % Radius to the outer surface of the PM pieces
% R27 = R25+0.5*PM_Params.agap;  % Radius to the Airgap on rotor side
R27 = R25+(1/3)*PM_Params.agap;  % Radius to the Airgap on rotor side
% --- Set up the other dimensions.
PMX = 0.90;       % 90s% of the rotor surface comprises PM pieces
                  % (and the edges of these pieces lie on radial lines).

% --- Now create the "corner KeyPoints".
po4 = pi/4;     % Angle to the extremes of one bay. 
tag = po4*PMX;  % Angle to edge of the PM material from middle of pole.

SLOT_ROT     = 4;
ANG_SECT_ROT = (2.0*pi)/SLOT_ROT;

% --- Now create the "corner KeyPoints".

nkpt = 51 ; % NUMBER OF KEY POINTS IN THE MODEL
nele = 12 ;  % NUMBER OF KEY ELEMENTS IN THE MODEL

KPTS_ROT = zeros(nkpt,  3); 
KPTS_ROT(:, 1) = (1:nkpt)';
KELE_ROT = zeros(nele, 12);

% CORNER KEYPOINTS
% KPTS_ROT( 1, 2:3) = [R21,   -po4];
% KPTS_ROT( 9, 2:3) = [R21,    po4];
% KPTS_ROT( 3, 2:3) = [R21,   -tag];
% KPTS_ROT( 7, 2:3) = [R21,    tag];
% KPTS_ROT( 5, 2:3) = [R21,    0.0];
% 
% KPTS_ROT(15, 2:3) = [R23,   -po4];
% KPTS_ROT(23, 2:3) = [R23,    po4];
% KPTS_ROT(17, 2:3) = [R23,   -tag];
% KPTS_ROT(21, 2:3) = [R23,    tag];
% KPTS_ROT(19, 2:3) = [R23,    0.0];
% 
% KPTS_ROT(29, 2:3) = [R25,   -po4];
% KPTS_ROT(37, 2:3) = [R25,    po4];
% KPTS_ROT(31, 2:3) = [R25,   -tag];
% KPTS_ROT(35, 2:3) = [R25,    tag];
% KPTS_ROT(33, 2:3) = [R25,    0.0];
% 
% KPTS_ROT(43, 2:3) = [R27,   -po4];
% KPTS_ROT(51, 2:3) = [R27,    po4];
% KPTS_ROT(45, 2:3) = [R27,   -tag];
% KPTS_ROT(49, 2:3) = [R27,    tag];
% KPTS_ROT(47, 2:3) = [R27,    0.0];

KPTS_ROT( 1, 2:3) = [R21*cos(po4),   -R21*sin(po4)];
KPTS_ROT( 9, 2:3) = [R21*cos(po4),    R21*sin(po4)];
KPTS_ROT( 3, 2:3) = [R21*cos(tag),   -R21*sin(tag)];
KPTS_ROT( 7, 2:3) = [R21*cos(tag),    R21*sin(tag)];
KPTS_ROT( 5, 2:3) = [R21,                      0.0];
% 

KPTS_ROT(15, 2:3) = [R23*cos(po4),   -R23*sin(po4)];
KPTS_ROT(23, 2:3) = [R23*cos(po4),    R23*sin(po4)];
KPTS_ROT(17, 2:3) = [R23*cos(tag),   -R23*sin(tag)];
KPTS_ROT(21, 2:3) = [R23*cos(tag),    R23*sin(tag)];
KPTS_ROT(19, 2:3) = [R23,                      0.0];


KPTS_ROT(29, 2:3) = [R25*cos(po4),   -R25*sin(po4)];
KPTS_ROT(37, 2:3) = [R25*cos(po4),    R25*sin(po4)]; 
KPTS_ROT(31, 2:3) = [R25*cos(tag),   -R25*sin(tag)];
KPTS_ROT(35, 2:3) = [R25*cos(tag),    R25*sin(tag)];
KPTS_ROT(33, 2:3) = [R25,                      0.0];


KPTS_ROT(43, 2:3) = [R27*cos(po4),   -R27*sin(po4)];
KPTS_ROT(51, 2:3) = [R27*cos(po4),    R27*sin(po4)]; 
KPTS_ROT(45, 2:3) = [R27*cos(tag),   -R27*sin(tag)];
KPTS_ROT(49, 2:3) = [R27*cos(tag),    R27*sin(tag)];
KPTS_ROT(47, 2:3) = [R27,                      0.0];

X_DIV = 3;
Y_DIV = 4;
NKPTS_CRNR = (X_DIV+1)*(Y_DIV+1)+1;
KPTS_CRNR = zeros(NKPTS_CRNR,3);

jt = 0;
nt = 0;
for iX = 1:X_DIV+1
    for jY = 1:Y_DIV+1
        mt = jY+(Y_DIV+1)*nt;
        KPTS_CRNR(mt,:) = KPTS_ROT(1+2*jt+Y_DIV*nt,:);
        jt = jt+1;
    end
     nt = nt+1;
end

KPTS_CRNR(2:end,:) = KPTS_CRNR(1:end-1,:);
KPTS_CRNR(1,:) = [907 0 0];


% MID-SIDE KEYPOINTS IN CIRCUMFERENTIAL DIRECTION
% KPTS_ROT( 2, 2:3) = [R21,  -0.5*(po4+tag)];
% KPTS_ROT( 4, 2:3) = [R21,        -0.5*tag];
% KPTS_ROT( 6, 2:3) = [R21,         0.5*tag];
% KPTS_ROT( 8, 2:3) = [R21,   0.5*(po4+tag)];
% 
% KPTS_ROT(16, 2:3) = [R23,  -0.5*(po4+tag)];
% KPTS_ROT(18, 2:3) = [R23,        -0.5*tag];
% KPTS_ROT(20, 2:3) = [R23,         0.5*tag];
% KPTS_ROT(22, 2:3) = [R23,   0.5*(po4+tag)];
% 
% KPTS_ROT(30, 2:3) = [R25,  -0.5*(po4+tag)];
% KPTS_ROT(32, 2:3) = [R25,        -0.5*tag];
% KPTS_ROT(34, 2:3) = [R25,         0.5*tag];
% KPTS_ROT(36, 2:3) = [R25,   0.5*(po4+tag)];
% 
% KPTS_ROT(44, 2:3) = [R27,  -0.5*(po4+tag)];
% KPTS_ROT(46, 2:3) = [R27,        -0.5*tag];
% KPTS_ROT(48, 2:3) = [R27,         0.5*tag];
% KPTS_ROT(50, 2:3) = [R27,   0.5*(po4+tag)];

KPTS_ROT( 2, 2:3) = bisect_KPs(KPTS_CRNR,   1,   3, 907);
KPTS_ROT( 4, 2:3) = bisect_KPs(KPTS_CRNR,   3,   5, 907);
KPTS_ROT( 6, 2:3) = bisect_KPs(KPTS_CRNR,   5,   7, 907);
KPTS_ROT( 8, 2:3) = bisect_KPs(KPTS_CRNR,   7,   9, 907);
% 
% 
KPTS_ROT(16, 2:3) = bisect_KPs(KPTS_CRNR,  15,  17, 907);
KPTS_ROT(18, 2:3) = bisect_KPs(KPTS_CRNR,  17,  19, 907);
KPTS_ROT(20, 2:3) = bisect_KPs(KPTS_CRNR,  19,  21, 907);
KPTS_ROT(22, 2:3) = bisect_KPs(KPTS_CRNR,  21,  23, 907);


KPTS_ROT(30, 2:3) = bisect_KPs(KPTS_CRNR,  29,  31, 907);
KPTS_ROT(32, 2:3) = bisect_KPs(KPTS_CRNR,  31,  33, 907);
KPTS_ROT(34, 2:3) = bisect_KPs(KPTS_CRNR,  33,  35, 907);
KPTS_ROT(36, 2:3) = bisect_KPs(KPTS_CRNR,  35,  37, 907);


KPTS_ROT(44, 2:3) = bisect_KPs(KPTS_CRNR,  43,  45, 907);
KPTS_ROT(46, 2:3) = bisect_KPs(KPTS_CRNR,  45,  47, 907);
KPTS_ROT(48, 2:3) = bisect_KPs(KPTS_CRNR,  47,  49, 907);
KPTS_ROT(50, 2:3) = bisect_KPs(KPTS_CRNR,  49,  51, 907);


% MID-SIDE KEYPOINTS IN RADIAL DIRECTION
% KPTS_ROT( 10, 2:3) = [0.5*(R21+R23),   -po4];
% KPTS_ROT( 11, 2:3) = [0.5*(R21+R23),   -tag];
% KPTS_ROT( 12, 2:3) = [0.5*(R21+R23),    0.0];
% KPTS_ROT( 13, 2:3) = [0.5*(R21+R23),    tag];
% KPTS_ROT( 14, 2:3) = [0.5*(R21+R23),    po4];
% 
% KPTS_ROT( 24, 2:3) = [0.5*(R23+R25),   -po4];
% KPTS_ROT( 25, 2:3) = [0.5*(R23+R25),   -tag];
% KPTS_ROT( 26, 2:3) = [0.5*(R23+R25),    0.0];
% KPTS_ROT( 27, 2:3) = [0.5*(R23+R25),    tag];
% KPTS_ROT( 28, 2:3) = [0.5*(R23+R25),    po4];
% 
% KPTS_ROT( 38, 2:3) = [0.5*(R25+R27),   -po4];
% KPTS_ROT( 39, 2:3) = [0.5*(R25+R27),   -tag];
% KPTS_ROT( 40, 2:3) = [0.5*(R25+R27),    0.0];
% KPTS_ROT( 41, 2:3) = [0.5*(R25+R27),    tag];
% KPTS_ROT( 42, 2:3) = [0.5*(R25+R27),    po4];

KPTS_ROT( 10, 2:3) = bisect_KPs(KPTS_CRNR,   1,  15, 0);
KPTS_ROT( 11, 2:3) = bisect_KPs(KPTS_CRNR,   3,  17, 0);
KPTS_ROT( 12, 2:3) = bisect_KPs(KPTS_CRNR,   5,  19, 0);
KPTS_ROT( 13, 2:3) = bisect_KPs(KPTS_CRNR,   7,  21, 0);
KPTS_ROT( 14, 2:3) = bisect_KPs(KPTS_CRNR,   9,  23, 0);

KPTS_ROT( 24, 2:3) = bisect_KPs(KPTS_CRNR,  15,  29, 0);
KPTS_ROT( 25, 2:3) = bisect_KPs(KPTS_CRNR,  17,  31, 0);
KPTS_ROT( 26, 2:3) = bisect_KPs(KPTS_CRNR,  19,  33, 0);
KPTS_ROT( 27, 2:3) = bisect_KPs(KPTS_CRNR,  21,  35, 0);
KPTS_ROT( 28, 2:3) = bisect_KPs(KPTS_CRNR,  23,  37, 0);

KPTS_ROT( 38, 2:3) = bisect_KPs(KPTS_CRNR,  29,  43, 0);
KPTS_ROT( 39, 2:3) = bisect_KPs(KPTS_CRNR,  31,  45, 0);
KPTS_ROT( 40, 2:3) = bisect_KPs(KPTS_CRNR,  33,  47, 0);
KPTS_ROT( 41, 2:3) = bisect_KPs(KPTS_CRNR,  35,  49, 0);
KPTS_ROT( 42, 2:3) = bisect_KPs(KPTS_CRNR,  37,  51, 0);

% KEY ELEMENTS
KELE_ROT( 1,:) = [ 1  3 17 15  2 11 16 10 2 0 64 0];
KELE_ROT( 2,:) = [ 3  5 19 17  4 12 18 11 2 0 64 0];
KELE_ROT( 3,:) = [ 5  7 21 19  6 13 20 12 2 0 64 0];
KELE_ROT( 4,:) = [ 7  9 23 21  8 14 22 13 2 0 64 0];

KELE_ROT( 5,:) = [15 17 31 29 16 25 30 24 3 0 64 0];
KELE_ROT( 6,:) = [17 19 33 31 18 26 32 25 4 1 64 0];
KELE_ROT( 7,:) = [19 21 35 33 20 27 34 26 4 1 64 0];
KELE_ROT( 8,:) = [21 23 37 35 22 28 36 27 3 0 64 0];

KELE_ROT( 9,:) = [29 31 45 43 30 39 44 38 3 0 64 0];
KELE_ROT(10,:) = [31 33 47 45 32 40 46 39 3 0 64 0];
KELE_ROT(11,:) = [33 35 49 47 34 41 48 40 3 0 64 0];
KELE_ROT(12,:) = [35 37 51 49 36 42 50 41 3 0 64 0];

[KPTS_ROT(:,3),KPTS_ROT(:,2)] = cart2pol(KPTS_ROT(:,2),KPTS_ROT(:,3));

% REDEFINING THE KEYPOINTS AT INNER AND OUTER DIA OF THE ROTOR IN POLAR
% COORDINATE
% AT INNER DIA OF THE ROTOR
KPTS_ROT( 1, 2:3) = [R21,            -po4];
KPTS_ROT( 9, 2:3) = [R21,             po4];
KPTS_ROT( 3, 2:3) = [R21,            -tag];
KPTS_ROT( 7, 2:3) = [R21,             tag];
KPTS_ROT( 5, 2:3) = [R21,             0.0];

KPTS_ROT( 2, 2:3) = [R21,  -0.5*(po4+tag)];
KPTS_ROT( 4, 2:3) = [R21,        -0.5*tag];
KPTS_ROT( 6, 2:3) = [R21,         0.5*tag];
KPTS_ROT( 8, 2:3) = [R21,   0.5*(po4+tag)];

% AT OUTER DIA OF THE ROTOR
KPTS_ROT(29, 2:3) = [R25,            -po4];
KPTS_ROT(37, 2:3) = [R25,             po4];
KPTS_ROT(31, 2:3) = [R25,            -tag];
KPTS_ROT(35, 2:3) = [R25,             tag];
KPTS_ROT(33, 2:3) = [R25,             0.0];

KPTS_ROT(30, 2:3) = [R25,  -0.5*(po4+tag)];
KPTS_ROT(32, 2:3) = [R25,        -0.5*tag];
KPTS_ROT(34, 2:3) = [R25,         0.5*tag];
KPTS_ROT(36, 2:3) = [R25,   0.5*(po4+tag)];

KPTS_ROT(:,3) = KPTS_ROT(:,3) + 0.5*ANG_SECT_ROT ;

[KPTS_ROT(:,2),KPTS_ROT(:,3)] = pol2cart(KPTS_ROT(:,3),KPTS_ROT(:,2));


% % DIVISIONS OF THE KEY ELEMENTS 
nkeles = size(KELE_ROT,1);
KDIVR  = zeros(nkeles,2); 
% 
KDIVR(1:8, 1)             =  5;
KDIVR(9:12,1)             =  1;
KDIVR([1 4 5 8 9 12], 2)  =  4;
KDIVR(2:3, 2)             = 30;
KDIVR(6:7, 2)             = 30;
KDIVR(10:11, 2)           = 30;
%  
% KDIVR(1:8, 1)             =   2;
% KDIVR(9:12,1)             =   1;
% KDIVR([1 4 5 8 9 12], 2)  =   4;
% KDIVR(2:3, 2)             =  22;
% KDIVR(6:7, 2)             =  22;
% KDIVR(10:11, 2)           =  22;
% 

% KDIVR(1:8, 1)             =   1;
% KDIVR(9:12,1)             =   1;
% KDIVR([1 4 5 8 9 12], 2)  =   1;
% KDIVR(2:3, 2)             =   1;
% KDIVR(6:7, 2)             =   1;
% KDIVR(10:11, 2)           =   1;

% 
[PTSx, ELEMx] = getMesh_Q8(KPTS_ROT, KELE_ROT, KDIVR);
[PTS_ROT1, ELE_ROT1] = rmDupl(PTSx, ELEMx);


% figure(2)
% clf
% iopt = 0;
% iok = Drawplt_4(PTS_ROT1, ELE_ROT1, iopt);

 
[PTS_ROT1(:,3), PTS_ROT1(:,2)] = cart2pol(PTS_ROT1(:,2),PTS_ROT1(:,3));

% pts_ri_index = find(abs(PTS_ROT1(:,2)-R21)<1E-04);
% pts_ro_index = find(abs(PTS_ROT1(:,2)-R25)<1E-04);
  
% % % ---------GENERATE THE MESH FOR THE OTHER SECTOR ALSO -----------------
PTS_ROT2 = []; ELE_ROT2 = []; node_offset = 0;
  
for islot = 1:SLOT_ROT
%  for islot = 1:1
     TEMP1 = PTS_ROT1;
     TEMP1(:,1) = TEMP1(:,1) + node_offset;
     TEMP1(:,3) = TEMP1(:,3) + ANG_SECT_ROT*(islot-1);
     PTS_ROT2 = [PTS_ROT2;TEMP1];   
     TEMP2 = ELE_ROT1;    
     TEMP2(:,1:8) = TEMP2(:,1:8)+node_offset; 
     index = find(TEMP2(:,9) == 4);
     if rem(islot,2) == 0
         TEMP2(index,9) = 6;
     else
         TEMP2(index,9) = 8;
     end
     TEMP2(:,10) = ELE_ROT1(:, 10)*islot;
     TEMP2(:,11) = ELE_ROT1(:,11);
     ELE_ROT2 = [ELE_ROT2;TEMP2];    
     node_offset = max(PTS_ROT2(:,1));
end
 
clear ELE_ROT1

[PTS_ROT2(:,2),PTS_ROT2(:,3)] = pol2cart(PTS_ROT2(:,3),PTS_ROT2(:,2));
[PTS_ROT3, ELE_ROT3] = rmDupl(PTS_ROT2, ELE_ROT2);

% REPLACING THE NODELABELS WITH THEIR POSITION IN THE NODAL COORDINATES 
[PTS_ROT, ELE_ROT] = label2pos(PTS_ROT3, ELE_ROT3);
% PTS_ROT(:,1) = PTS_ROT(:,1) + max(PTS_ROT(:,1));
% ELE_ROT(:,1:8) = ELE_ROT(:,1:8) + max(PTS_ROT(:,1));

clear ELE_ROT2
clear ELE_ROT3


% figure(1)
% clf
% hold on;
% % iok = drawnodes(KPTS_ROT, KELE_ROT, iopt);
% title('MESH ONLY WITH THE KEY ELEMENTS')% iopt = 0;
% iok = Drawplt_4(PTS_ROT, ELE_ROT, iopt);

% 
% 
% figure(2)
% clf
% iopt = 0;
% iok = Drawplt_4(KPTS_ROT, KELE_ROT, iopt);
end
 