function [KPTS_STA,KELE_STA,PTS_STA,ELE_STA,KDIVS]=getNEsta_24slots_EqA_test1(PTS_ROT)

% --- Stator_Bay_KPs ---
% This script generates the KeyPoints array <KeyPts> for the model of one
% bay of the stator from the machine called <RV_6th>. 
% ---------------------------------------------------------------------

clf
clf
% addpath('D:\Matlab\SRK_PM\Prepox')

PM_Params = getparams() ; % Get the parameters of stator and rotor.

% --- Set up the different radii for "corner KeyPoints".
% R01 = 61E-3;
% R03 = 73E-3;
% R05 = 75.5E-3;
% R07 = 125E-3;
% R09 = 161E-3;
R0     =   0.5*(PM_Params.ID_STA)-(1/3)*(PM_Params.agap);
% R0     =   0.5*(PM_Params.ID_STA-PM_Params.agap);
R01    =   0.5*PM_Params.ID_STA;
R030   =       49.250E-3;
R03    =       49.604E-3;
R031   =  0.5*(R030+R03);
R05    =       51.255E-3;
R07    =       62.386E-3;
R09    =       72.470E-3; % $ We can include the length of the teeth as a variable
R11    =       74.602E-3;
R11_1  =       74.568E-3;
R11_2  =       74.591E-3;
R11_3  =       73.985E-3;
R11_4  =       74.591E-3;
R13    =  0.5*PM_Params.OD_STA;
SLOT_STA     = 24;
ANG_SECT_STA = (2.0*pi)/SLOT_STA;

% --- Set up the other lengths.
% FW  = 56E-3;    % Complete "tooth face" width
% TW  = 32E-3;    % Tooth body width
% CWi = 14E-3;    % Coil-side width close to stator bore
% CWo = 22.5E-3;  % Coil-side width at stator back-of-core ID

% --- Now create the "corner KeyPoints".

nkpt = 199 ; % NUMBER OF KEY POINTS IN THE MODEL
nele = 56 ;  % NUMBER OF KEY ELEMENTS IN THE MODEL

KPTS_STA = zeros(nkpt,  3); 
KPTS_STA(:, 1) = (1:nkpt)';
KELE_STA = zeros(nele, 12);

% CORNER KEYPOINTS
KPTS_STA( 1,2:3) = [R0*cos(pi/24),                 -R0*sin(pi/24)];
KPTS_STA(17,2:3) = [R0*cos(pi/24),                  R0*sin(pi/24)];
KPTS_STA( 3,2:3) = [R0*cos(deg2rad(6)),       -R0*sin(deg2rad(6))];
KPTS_STA(15,2:3) = [R0*cos(deg2rad(6)),        R0*sin(deg2rad(6))];
KPTS_STA( 5,2:3) = [R0*cos(deg2rad(4.9)),   -R0*sin(deg2rad(4.9))];
KPTS_STA(13,2:3) = [R0*cos(deg2rad(4.9)),    R0*sin(deg2rad(4.9))];
KPTS_STA( 7,2:3) = [R0*cos(deg2rad(4.1)),   -R0*sin(deg2rad(4.1))];
KPTS_STA(11,2:3) = [R0*cos(deg2rad(4.1)),    R0*sin(deg2rad(4.1))];
KPTS_STA( 9,2:3) = [R0,                                       0.0];

KPTS_STA(27, 2:3) = [R01*cos(pi/24),               -R01*sin(pi/24)];
KPTS_STA(43, 2:3) = [R01*cos(pi/24),                R01*sin(pi/24)];
KPTS_STA(29, 2:3) = [R01*cos(deg2rad(6)),     -R01*sin(deg2rad(6))];
KPTS_STA(41, 2:3) = [R01*cos(deg2rad(6)),      R01*sin(deg2rad(6))];
KPTS_STA(31, 2:3) = [R01*cos(deg2rad(4.9)), -R01*sin(deg2rad(4.9))];
KPTS_STA(39, 2:3) = [R01*cos(deg2rad(4.9)),  R01*sin(deg2rad(4.9))];
KPTS_STA(33, 2:3) = [R01*cos(deg2rad(4.1)), -R01*sin(deg2rad(4.1))];
KPTS_STA(37, 2:3) = [R01*cos(deg2rad(4.1)),  R01*sin(deg2rad(4.1))];
KPTS_STA(35, 2:3) = [R01,                                      0.0];

KPTS_STA(53, 2:3) = [R030*cos(pi/24),               -R030*sin(pi/24)];
KPTS_STA(69, 2:3) = [R030*cos(pi/24),                R030*sin(pi/24)];
KPTS_STA(55, 2:3) = [R030*cos(deg2rad(6)),     -R030*sin(deg2rad(6))];
KPTS_STA(67, 2:3) = [R030*cos(deg2rad(6)),      R030*sin(deg2rad(6))];
KPTS_STA(57, 2:3) = [R031*cos(deg2rad(5.5)), -R031*sin(deg2rad(5.5))];
KPTS_STA(65, 2:3) = [R031*cos(deg2rad(5.5)),  R031*sin(deg2rad(5.5))];
KPTS_STA(59, 2:3) = [R03*cos(deg2rad(5.09)), -R03*sin(deg2rad(5.09))];
KPTS_STA(63, 2:3) = [R03*cos(deg2rad(5.09)),  R03*sin(deg2rad(5.09))];
KPTS_STA(61, 2:3) = [R03,                                        0.0];

KPTS_STA(79, 2:3) = [R05*cos(pi/24),                 -R05*sin(pi/24)];
KPTS_STA(95, 2:3) = [R05*cos(pi/24),                  R05*sin(pi/24)];
KPTS_STA(81, 2:3) = [R05*cos(deg2rad(6)),       -R05*sin(deg2rad(6))];
KPTS_STA(93, 2:3) = [R05*cos(deg2rad(6)),        R05*sin(deg2rad(6))];
KPTS_STA(83, 2:3) = [R05*cos(deg2rad(5)),       -R05*sin(deg2rad(5))];
KPTS_STA(91, 2:3) = [R05*cos(deg2rad(5)),        R05*sin(deg2rad(5))];
KPTS_STA(85, 2:3) = [R05*cos(deg2rad(3.80)), -R05*sin(deg2rad(3.80))];
KPTS_STA(89, 2:3) = [R05*cos(deg2rad(3.80)),  R05*sin(deg2rad(3.80))];
KPTS_STA(87, 2:3) = [R05,                                        0.0];

KPTS_STA(105, 2:3) = [R07*cos(pi/24),                 -R07*sin(pi/24)];
KPTS_STA(121, 2:3) = [R07*cos(pi/24),                  R07*sin(pi/24)];
KPTS_STA(107, 2:3) = [R07*cos(deg2rad(6)),       -R07*sin(deg2rad(6))];
KPTS_STA(119, 2:3) = [R07*cos(deg2rad(6)),        R07*sin(deg2rad(6))];
KPTS_STA(109, 2:3) = [R07*cos(deg2rad(4.6)),   -R07*sin(deg2rad(4.6))];
KPTS_STA(117, 2:3) = [R07*cos(deg2rad(4.6)),    R07*sin(deg2rad(4.6))];
KPTS_STA(111, 2:3) = [R07*cos(deg2rad(3.12)), -R07*sin(deg2rad(3.12))];
KPTS_STA(115, 2:3) = [R07*cos(deg2rad(3.12)),  R07*sin(deg2rad(3.12))];
KPTS_STA(113, 2:3) = [R07,                                        0.0];

KPTS_STA(131,2:3) = [R09*cos(pi/24),                 -R09*sin(pi/24)];
KPTS_STA(147,2:3) = [R09*cos(pi/24),                  R09*sin(pi/24)];
KPTS_STA(133,2:3) = [R09*cos(deg2rad(6)),       -R09*sin(deg2rad(6))];
KPTS_STA(145,2:3) = [R09*cos(deg2rad(6)),        R09*sin(deg2rad(6))];
KPTS_STA(135,2:3) = [R09*cos(deg2rad(4.26)), -R09*sin(deg2rad(4.26))];
KPTS_STA(143,2:3) = [R09*cos(deg2rad(4.26)),  R09*sin(deg2rad(4.26))];
KPTS_STA(137,2:3) = [R09*cos(deg2rad(2.69)), -R09*sin(deg2rad(2.69))];
KPTS_STA(141,2:3) = [R09*cos(deg2rad(2.69)),  R09*sin(deg2rad(2.69))];
KPTS_STA(139,2:3) = [R09,                                        0.0];

KPTS_STA(157,2:3) = [R11*cos(pi/24),                     -R11*sin(pi/24)];
KPTS_STA(173,2:3) = [R11*cos(pi/24),                      R11*sin(pi/24)];
KPTS_STA(159,2:3) = [R11_1*cos(deg2rad(5.90)), -R11_1*sin(deg2rad(5.90))];
KPTS_STA(171,2:3) = [R11_1*cos(deg2rad(5.90)),  R11_1*sin(deg2rad(5.90))];
KPTS_STA(161,2:3) = [R11_2*cos(deg2rad(4.31)), -R11_2*sin(deg2rad(4.31))];
KPTS_STA(169,2:3) = [R11_2*cos(deg2rad(4.31)),  R11_2*sin(deg2rad(4.31))];
KPTS_STA(163,2:3) = [R11_3*cos(deg2rad(3.14)), -R11_3*sin(deg2rad(3.14))];
KPTS_STA(167,2:3) = [R11_3*cos(deg2rad(3.14)),  R11_3*sin(deg2rad(3.14))];
KPTS_STA(165,2:3) = [R11_4,                                          0.0];

KPTS_STA(183,2:3) = [R13*cos(pi/24),                 -R13*sin(pi/24)];
KPTS_STA(199,2:3) = [R13*cos(pi/24),                  R13*sin(pi/24)];
KPTS_STA(185,2:3) = [R13*cos(deg2rad(5.90)), -R13*sin(deg2rad(5.90))];
KPTS_STA(197,2:3) = [R13*cos(deg2rad(5.90)),  R13*sin(deg2rad(5.90))];
KPTS_STA(187,2:3) = [R13*cos(deg2rad(4.31)), -R13*sin(deg2rad(4.31))];
KPTS_STA(195,2:3) = [R13*cos(deg2rad(4.31)),  R13*sin(deg2rad(4.31))];
KPTS_STA(189,2:3) = [R13*cos(deg2rad(3.14)), -R13*sin(deg2rad(3.14))];
KPTS_STA(193,2:3) = [R13*cos(deg2rad(3.14)),  R13*sin(deg2rad(3.14))];
KPTS_STA(191,2:3) = [R13,                                        0.0];


X_DIV = 7;
Y_DIV = 8;
NKPTS_CRNR = (X_DIV+1)*(Y_DIV+1)+1;
KPTS_CRNR = zeros(NKPTS_CRNR,3);
% KPTS_CRNR( 2:10,:) = KPTS_STA(1:2:17,:);
% KPTS_CRNR(11:19,:) = KPTS_STA(27:2:43,:);
% KPTS_CRNR(20:28,:) = KPTS_STA(53:2:69,:);
% KPTS_CRNR(29:37,:) = KPTS_STA(79:2:95,:);
% KPTS_CRNR(38:46,:) = KPTS_STA(105:2:121,:);
% KPTS_CRNR(47:55,:) = KPTS_STA(131:2:147,:);
% KPTS_CRNR(56:64,:) = KPTS_STA(157:2:173,:);

jt = 0;
nt = 0;
for iX = 1:X_DIV+1
    for jY = 1:Y_DIV+1
        mt = jY+(Y_DIV+1)*nt;
        KPTS_CRNR(mt,:) = KPTS_STA(1+2*jt+Y_DIV*nt,:);
        jt = jt+1;
    end
     nt = nt+1;
end

KPTS_CRNR(2:end,:) = KPTS_CRNR(1:end-1,:);
KPTS_CRNR(1,:) = [901 0 0];


% MID-SIDE KEYPOINTS IN CIRCUMFERENTIAL DIRECTION
KPTS_STA(  2, 2:3) = bisect_KPs(KPTS_CRNR,   1,   3, 901);
KPTS_STA(  4, 2:3) = bisect_KPs(KPTS_CRNR,   3,   5, 901);
KPTS_STA(  6, 2:3) = bisect_KPs(KPTS_CRNR,   5,   7, 901);
KPTS_STA(  8, 2:3) = bisect_KPs(KPTS_CRNR,   7,   9, 901);
KPTS_STA( 10, 2:3) = bisect_KPs(KPTS_CRNR,   9,  11, 901);
KPTS_STA( 12, 2:3) = bisect_KPs(KPTS_CRNR,  11,  13, 901);
KPTS_STA( 14, 2:3) = bisect_KPs(KPTS_CRNR,  13,  15, 901);
KPTS_STA( 16, 2:3) = bisect_KPs(KPTS_CRNR,  15,  17, 901);
KPTS_STA( 28, 2:3) = bisect_KPs(KPTS_CRNR,  27,  29, 901);
KPTS_STA( 30, 2:3) = bisect_KPs(KPTS_CRNR,  29,  31, 901);
KPTS_STA( 32, 2:3) = bisect_KPs(KPTS_CRNR,  31,  33, 901);
KPTS_STA( 34, 2:3) = bisect_KPs(KPTS_CRNR,  33,  35, 901);
KPTS_STA( 36, 2:3) = bisect_KPs(KPTS_CRNR,  35,  37, 901);
KPTS_STA( 38, 2:3) = bisect_KPs(KPTS_CRNR,  37,  39, 901);
KPTS_STA( 40, 2:3) = bisect_KPs(KPTS_CRNR,  39,  41, 901);
KPTS_STA( 42, 2:3) = bisect_KPs(KPTS_CRNR,  41,  43, 901);
KPTS_STA( 54, 2:3) = bisect_KPs(KPTS_CRNR,  53,  55, 901);
KPTS_STA( 56, 2:3) = bisect_KPs(KPTS_CRNR,  55,  57, 901);
KPTS_STA( 58, 2:3) = bisect_KPs(KPTS_CRNR,  57,  59, 901);
KPTS_STA( 60, 2:3) = bisect_KPs(KPTS_CRNR,  59,  61, 901);
KPTS_STA( 62, 2:3) = bisect_KPs(KPTS_CRNR,  61,  63, 901);
KPTS_STA( 64, 2:3) = bisect_KPs(KPTS_CRNR,  63,  65, 901);
KPTS_STA( 66, 2:3) = bisect_KPs(KPTS_CRNR,  65,  67, 901);
KPTS_STA( 68, 2:3) = bisect_KPs(KPTS_CRNR,  67,  69, 901);
KPTS_STA( 80, 2:3) = bisect_KPs(KPTS_CRNR,  79,  81, 901);
KPTS_STA( 82, 2:3) = bisect_KPs(KPTS_CRNR,  81,  83, 901);
KPTS_STA( 84, 2:3) = bisect_KPs(KPTS_CRNR,  83,  85, 901);
KPTS_STA( 86, 2:3) = bisect_KPs(KPTS_CRNR,  85,  87, 901);
KPTS_STA( 88, 2:3) = bisect_KPs(KPTS_CRNR,  87,  89, 901);
KPTS_STA( 90, 2:3) = bisect_KPs(KPTS_CRNR,  89,  91, 901);
KPTS_STA( 92, 2:3) = bisect_KPs(KPTS_CRNR,  91,  93, 901);
KPTS_STA( 94, 2:3) = bisect_KPs(KPTS_CRNR,  93,  95, 901);
KPTS_STA(106, 2:3) = bisect_KPs(KPTS_CRNR, 105, 107, 901);
KPTS_STA(108, 2:3) = bisect_KPs(KPTS_CRNR, 107, 109, 901);
KPTS_STA(110, 2:3) = bisect_KPs(KPTS_CRNR, 109, 111, 901);
KPTS_STA(112, 2:3) = bisect_KPs(KPTS_CRNR, 111, 113, 901);
KPTS_STA(114, 2:3) = bisect_KPs(KPTS_CRNR, 113, 115, 901);
KPTS_STA(116, 2:3) = bisect_KPs(KPTS_CRNR, 115, 117, 901);
KPTS_STA(118, 2:3) = bisect_KPs(KPTS_CRNR, 117, 119, 901);
KPTS_STA(120, 2:3) = bisect_KPs(KPTS_CRNR, 119, 121, 901);
KPTS_STA(132, 2:3) = bisect_KPs(KPTS_CRNR, 131, 133, 901);
KPTS_STA(134, 2:3) = bisect_KPs(KPTS_CRNR, 133, 135, 901);
KPTS_STA(136, 2:3) = bisect_KPs(KPTS_CRNR, 135, 137, 901);
KPTS_STA(138, 2:3) = bisect_KPs(KPTS_CRNR, 137, 139, 901);
KPTS_STA(140, 2:3) = bisect_KPs(KPTS_CRNR, 139, 141, 901);
KPTS_STA(142, 2:3) = bisect_KPs(KPTS_CRNR, 141, 143, 901);
KPTS_STA(144, 2:3) = bisect_KPs(KPTS_CRNR, 143, 145, 901);
KPTS_STA(146, 2:3) = bisect_KPs(KPTS_CRNR, 145, 147, 901);
KPTS_STA(158, 2:3) = bisect_KPs(KPTS_CRNR, 157, 159, 901);
KPTS_STA(160, 2:3) = bisect_KPs(KPTS_CRNR, 159, 161, 901);
KPTS_STA(162, 2:3) = bisect_KPs(KPTS_CRNR, 161, 163, 901); 
KPTS_STA(164, 2:3) = bisect_KPs(KPTS_CRNR, 163, 165, 901);
KPTS_STA(166, 2:3) = bisect_KPs(KPTS_CRNR, 165, 167, 901);
KPTS_STA(168, 2:3) = bisect_KPs(KPTS_CRNR, 167, 169, 901);
KPTS_STA(170, 2:3) = bisect_KPs(KPTS_CRNR, 169, 171, 901);
KPTS_STA(172, 2:3) = bisect_KPs(KPTS_CRNR, 171, 173, 901);
KPTS_STA(184, 2:3) = bisect_KPs(KPTS_CRNR, 183, 185, 901);
KPTS_STA(186, 2:3) = bisect_KPs(KPTS_CRNR, 185, 187, 901);
KPTS_STA(188, 2:3) = bisect_KPs(KPTS_CRNR, 187, 189, 901);
KPTS_STA(190, 2:3) = bisect_KPs(KPTS_CRNR, 189, 191, 901);
KPTS_STA(192, 2:3) = bisect_KPs(KPTS_CRNR, 191, 193, 901);
KPTS_STA(194, 2:3) = bisect_KPs(KPTS_CRNR, 193, 195, 901);
KPTS_STA(196, 2:3) = bisect_KPs(KPTS_CRNR, 195, 197, 901);
KPTS_STA(198, 2:3) = bisect_KPs(KPTS_CRNR, 197, 199, 901);

% MID-SIDE KEYPOINTS IN RADIAL DIRECTION
KPTS_STA( 18, 2:3) = bisect_KPs(KPTS_CRNR,   1,  27, 0);
KPTS_STA( 19, 2:3) = bisect_KPs(KPTS_CRNR,   3,  29, 0);
KPTS_STA( 20, 2:3) = bisect_KPs(KPTS_CRNR,   5,  31, 0);
KPTS_STA( 21, 2:3) = bisect_KPs(KPTS_CRNR,   7,  33, 0);
KPTS_STA( 22, 2:3) = bisect_KPs(KPTS_CRNR,   9,  35, 0);
KPTS_STA( 23, 2:3) = bisect_KPs(KPTS_CRNR,  11,  37, 0);
KPTS_STA( 24, 2:3) = bisect_KPs(KPTS_CRNR,  13,  39, 0);
KPTS_STA( 25, 2:3) = bisect_KPs(KPTS_CRNR,  15,  41, 0);
KPTS_STA( 26, 2:3) = bisect_KPs(KPTS_CRNR,  17,  43, 0);
KPTS_STA( 44, 2:3) = bisect_KPs(KPTS_CRNR,  27,  53, 0);
KPTS_STA( 45, 2:3) = bisect_KPs(KPTS_CRNR,  29,  55, 0);
KPTS_STA( 46, 2:3) = bisect_KPs(KPTS_CRNR,  31,  57, 0);
KPTS_STA( 47, 2:3) = bisect_KPs(KPTS_CRNR,  33,  59, 0);
KPTS_STA( 48, 2:3) = bisect_KPs(KPTS_CRNR,  35,  61, 0);
KPTS_STA( 49, 2:3) = bisect_KPs(KPTS_CRNR,  37,  63, 0);
KPTS_STA( 50, 2:3) = bisect_KPs(KPTS_CRNR,  39,  65, 0);
KPTS_STA( 51, 2:3) = bisect_KPs(KPTS_CRNR,  41,  67, 0);
KPTS_STA( 52, 2:3) = bisect_KPs(KPTS_CRNR,  43,  69, 0);
KPTS_STA( 70, 2:3) = bisect_KPs(KPTS_CRNR,  53,  79, 0);
KPTS_STA( 71, 2:3) = bisect_KPs(KPTS_CRNR,  55,  81, 0);
KPTS_STA( 72, 2:3) = bisect_KPs(KPTS_CRNR,  57,  83, 0);
KPTS_STA( 73, 2:3) = bisect_KPs(KPTS_CRNR,  59,  85, 0);
KPTS_STA( 74, 2:3) = bisect_KPs(KPTS_CRNR,  61,  87, 0);
KPTS_STA( 75, 2:3) = bisect_KPs(KPTS_CRNR,  63,  89, 0);
KPTS_STA( 76, 2:3) = bisect_KPs(KPTS_CRNR,  65,  91, 0);
KPTS_STA( 77, 2:3) = bisect_KPs(KPTS_CRNR,  67,  93, 0);
KPTS_STA( 78, 2:3) = bisect_KPs(KPTS_CRNR,  69,  95, 0);
KPTS_STA( 96, 2:3) = bisect_KPs(KPTS_CRNR,  79, 105, 0);
KPTS_STA( 97, 2:3) = bisect_KPs(KPTS_CRNR,  81, 107, 0);
KPTS_STA( 98, 2:3) = bisect_KPs(KPTS_CRNR,  83, 109, 0);
KPTS_STA( 99, 2:3) = bisect_KPs(KPTS_CRNR,  85, 111, 0);
KPTS_STA(100, 2:3) = bisect_KPs(KPTS_CRNR,  87, 113, 0);
KPTS_STA(101, 2:3) = bisect_KPs(KPTS_CRNR,  89, 115, 0);
KPTS_STA(102, 2:3) = bisect_KPs(KPTS_CRNR,  91, 117, 0);
KPTS_STA(103, 2:3) = bisect_KPs(KPTS_CRNR,  93, 119, 0);
KPTS_STA(104, 2:3) = bisect_KPs(KPTS_CRNR,  95, 121, 0);
KPTS_STA(122, 2:3) = bisect_KPs(KPTS_CRNR, 105, 131, 0);
KPTS_STA(123, 2:3) = bisect_KPs(KPTS_CRNR, 107, 133, 0);
KPTS_STA(124, 2:3) = bisect_KPs(KPTS_CRNR, 109, 135, 0);
KPTS_STA(125, 2:3) = bisect_KPs(KPTS_CRNR, 111, 137, 0);
KPTS_STA(126, 2:3) = bisect_KPs(KPTS_CRNR, 113, 139, 0);
KPTS_STA(127, 2:3) = bisect_KPs(KPTS_CRNR, 115, 141, 0);
KPTS_STA(128, 2:3) = bisect_KPs(KPTS_CRNR, 117, 143, 0);
KPTS_STA(129, 2:3) = bisect_KPs(KPTS_CRNR, 119, 145, 0);
KPTS_STA(130, 2:3) = bisect_KPs(KPTS_CRNR, 121, 147, 0);
KPTS_STA(148, 2:3) = bisect_KPs(KPTS_CRNR, 131, 157, 0);
KPTS_STA(149, 2:3) = bisect_KPs(KPTS_CRNR, 133, 159, 0);
KPTS_STA(150, 2:3) = bisect_KPs(KPTS_CRNR, 135, 161, 0);
KPTS_STA(151, 2:3) = bisect_KPs(KPTS_CRNR, 137, 163, 0);
KPTS_STA(152, 2:3) = bisect_KPs(KPTS_CRNR, 139, 165, 0);
KPTS_STA(153, 2:3) = bisect_KPs(KPTS_CRNR, 141, 167, 0);
KPTS_STA(154, 2:3) = bisect_KPs(KPTS_CRNR, 143, 169, 0);
KPTS_STA(155, 2:3) = bisect_KPs(KPTS_CRNR, 145, 171, 0);
KPTS_STA(156, 2:3) = bisect_KPs(KPTS_CRNR, 147, 173, 0);
KPTS_STA(174, 2:3) = bisect_KPs(KPTS_CRNR, 157, 183, 0);
KPTS_STA(175, 2:3) = bisect_KPs(KPTS_CRNR, 159, 185, 0);
KPTS_STA(176, 2:3) = bisect_KPs(KPTS_CRNR, 161, 187, 0);
KPTS_STA(177, 2:3) = bisect_KPs(KPTS_CRNR, 163, 189, 0);
KPTS_STA(178, 2:3) = bisect_KPs(KPTS_CRNR, 165, 191, 0);
KPTS_STA(179, 2:3) = bisect_KPs(KPTS_CRNR, 167, 193, 0);
KPTS_STA(180, 2:3) = bisect_KPs(KPTS_CRNR, 169, 195, 0);
KPTS_STA(181, 2:3) = bisect_KPs(KPTS_CRNR, 171, 197, 0);
KPTS_STA(182, 2:3) = bisect_KPs(KPTS_CRNR, 173, 199, 0);


% KEY ELEMENTS
KELE_STA( 1,:) = [  1   3  29  27  2   19  28  18 3 1000 64 0];
KELE_STA( 2,:) = [  3   5  31  29  4   20  30  19 3 1000 64 0];
KELE_STA( 3,:) = [  5   7  33  31  6   21  32  20 3 1000 64 0];
KELE_STA( 4,:) = [  7   9  35  33  8   22  34  21 3 1000 64 0];
KELE_STA( 5,:) = [  9  11  37  35 10   23  36  22 3 1000 64 0];
KELE_STA( 6,:) = [ 11  13  39  37 12   24  38  23 3 1000 64 0];
KELE_STA( 7,:) = [ 13  15  41  39 14   25  40  24 3 1000 64 0];
KELE_STA( 8,:) = [ 15  17  43  41 16   26  42  25 3 1000 64 0];

KELE_STA( 9,:) = [ 27  29  55  53  28  45  54  44 3 1000 64 0];
KELE_STA(10,:) = [ 29  31  57  55  30  46  56  45 2 1000 64 0];
KELE_STA(11,:) = [ 31  33  59  57  32  47  58  46 2 1000 64 0];
KELE_STA(12,:) = [ 33  35  61  59  34  48  60  47 2 1000 64 0];
KELE_STA(13,:) = [ 35  37  63  61  36  49  62  48 2 1000 64 0];
KELE_STA(14,:) = [ 37  39  65  63  38  50  64  49 2 1000 64 0];
KELE_STA(15,:) = [ 39  41  67  65  40  51  66  50 2 1000 64 0];
KELE_STA(16,:) = [ 41  43  69  67  42  52  68  51 3 1000 64 0];

KELE_STA(17,:) = [ 53  55  81  79  54  71  80  70 4    1 64 0];
KELE_STA(18,:) = [ 55  57  83  81  56  72  82  71 4    1 64 0];
KELE_STA(19,:) = [ 57  59  85  83  58  73  84  72 4    1 64 0];
KELE_STA(20,:) = [ 59  61  87  85  60  74  86  73 2 1000 64 0];
KELE_STA(21,:) = [ 61  63  89  87  62  75  88  74 2 1000 64 0];
KELE_STA(22,:) = [ 63  65  91  89  64  76  90  75 4    1 64 0];
KELE_STA(23,:) = [ 65  67  93  91  66  77  92  76 4    1 64 0];
KELE_STA(24,:) = [ 67  69  95  93  68  78  94  77 4    1 64 0];

KELE_STA(25,:) = [ 79  81 107 105  80  97 106  96 4    1 64 0];
KELE_STA(26,:) = [ 81  83 109 107  82  98 108  97 4    1 64 0];
KELE_STA(27,:) = [ 83  85 111 109  84  99 110  98 4    1 64 0];
KELE_STA(28,:) = [ 85  87 113 111  86 100 112  99 2 1000 64 0];
KELE_STA(29,:) = [ 87  89 115 113  88 101 114 100 2 1000 64 0];
KELE_STA(30,:) = [ 89  91 117 115  90 102 116 101 4    1 64 0];
KELE_STA(31,:) = [ 91  93 119 117  92 103 118 102 4    1 64 0];
KELE_STA(32,:) = [ 93  95 121 119  94 104 120 103 4    1 64 0];

KELE_STA(33,:) = [105 107 133 131 106 123 132 122 4    2 64 0];
KELE_STA(34,:) = [107 109 135 133 108 124 134 123 4    2 64 0];
KELE_STA(35,:) = [109 111 137 135 110 125 136 124 4    2 64 0];
KELE_STA(36,:) = [111 113 139 137 112 126 138 125 2 1000 64 0];
KELE_STA(37,:) = [113 115 141 139 114 127 140 126 2 1000 64 0];
KELE_STA(38,:) = [115 117 143 141 116 128 142 127 4    2 64 0];
KELE_STA(39,:) = [117 119 145 143 118 129 144 128 4    2 64 0];
KELE_STA(40,:) = [119 121 147 145 120 130 146 129 4    2 64 0];

KELE_STA(41,:) = [131 133 159 157 132 149 158 148 4    2 64 0];
KELE_STA(42,:) = [133 135 161 159 134 150 160 149 4    2 64 0];
KELE_STA(43,:) = [135 137 163 161 136 151 162 150 4    2 64 0];
KELE_STA(44,:) = [137 139 165 163 138 152 164 151 2 1000 64 0];
KELE_STA(45,:) = [139 141 167 165 140 153 166 152 2 1000 64 0];
KELE_STA(46,:) = [141 143 169 167 142 154 168 153 4    2 64 0];
KELE_STA(47,:) = [143 145 171 169 144 155 170 154 4    2 64 0];
KELE_STA(48,:) = [145 147 173 171 146 156 172 155 4    2 64 0];

KELE_STA(49,:) = [157 159 185 183 158 175 184 174 2 1000 64 0];
KELE_STA(50,:) = [159 161 187 185 160 176 186 175 2 1000 64 0];
KELE_STA(51,:) = [161 163 189 187 162 177 188 176 2 1000 64 0];
KELE_STA(52,:) = [163 165 191 189 164 178 190 177 2 1000 64 0];
KELE_STA(53,:) = [165 167 193 191 166 179 192 178 2 1000 64 0];
KELE_STA(54,:) = [167 169 195 193 168 180 194 179 2 1000 64 0];
KELE_STA(55,:) = [169 171 197 195 170 181 196 180 2 1000 64 0];
KELE_STA(56,:) = [171 173 199 197 172 182 198 181 2 1000 64 0];





[KPTS_STA(:,3),KPTS_STA(:,2)] = cart2pol(KPTS_STA(:,2),KPTS_STA(:,3));
KPTS_STA(:,3) = KPTS_STA(:,3) + 0.5*ANG_SECT_STA ;
[KPTS_STA(:,2),KPTS_STA(:,3)] = pol2cart(KPTS_STA(:,3),KPTS_STA(:,2));



% DIVISIONS OF THE KEY ELEMENTS 
nkeles = size(KELE_STA,1);
KDIVS = zeros(nkeles,2); 

% KDIVS(   1:8,1) = 2;
% KDIVS(  9:24,1) = 3;
% KDIVS( 25:40,1) = 6;
% KDIVS( 41:48,1) = 2;
% KDIVS( 49:56,1) = 8;
% KDIVS(1:8:49,2) = 2;
% KDIVS(2:8:50,2) = 4;
% KDIVS(3:8:51,2) = 2;
% KDIVS(4:8:52,2) = 5;
% KDIVS(8:8:56,2) = 2;
% KDIVS(7:8:55,2) = 4;
% KDIVS(6:8:54,2) = 2;
% KDIVS(5:8:53,2) = 5;

KDIVS(   1:8,1) = 2;
KDIVS(  9:24,1) = 2;
KDIVS( 25:40,1) = 2;
KDIVS( 41:48,1) = 2;
KDIVS( 49:56,1) = 4;
KDIVS(1:8:49,2) = 2;
KDIVS(2:8:50,2) = 2;
KDIVS(3:8:51,2) = 2;
KDIVS(4:8:52,2) = 2;
KDIVS(8:8:56,2) = 2;
KDIVS(7:8:55,2) = 2;
KDIVS(6:8:54,2) = 2;
KDIVS(5:8:53,2) = 2;
% KDIVS = 2*KDIVS ;

% KDIVS(   1:8,1) = 1;
% KDIVS(  9:24,1) = 1;
% KDIVS( 25:40,1) = 1;
% KDIVS( 41:48,1) = 1;
% KDIVS( 49:56,1) = 1;
% KDIVS(1:8:49,2) = 1;
% KDIVS(2:8:50,2) = 1;
% KDIVS(3:8:51,2) = 1;
% KDIVS(4:8:52,2) = 1;
% KDIVS(8:8:56,2) = 1;
% KDIVS(7:8:55,2) = 1;
% KDIVS(6:8:54,2) = 1;
% KDIVS(5:8:53,2) = 1;

[PTSx, ELEMx] = getMesh_Q8(KPTS_STA, KELE_STA, KDIVS);
[PTS_STA1, ELE_STA1] = rmDupl(PTSx, ELEMx);

[PTS_STA1(:,3), PTS_STA1(:,2)] = cart2pol(PTS_STA1(:,2),PTS_STA1(:,3));


% pts_si_index = find(abs(PTS_STA1(:,2)-R01)<1E-06);
% pts_so_index = find(abs(PTS_STA1(:,2)-R13)<1E-06);
 
% ---------GENERATE THE MESH FOR THE OTHER SECTOR ALSO -----------------
PTS_STA2 = []; ELE_STA2 = []; node_offset = 0;
  
for islot = 1:SLOT_STA
%  for islot = 1:1
     TEMP1 = PTS_STA1;
     TEMP1(:,1) = TEMP1(:,1) + node_offset;
     TEMP1(:,3) = TEMP1(:,3) + ANG_SECT_STA*(islot-1);
     PTS_STA2 = [PTS_STA2;TEMP1];   
     TEMP2 = ELE_STA1;    
     TEMP2(:,1:8) = TEMP2(:,1:8)+node_offset; 
     TEMP2(:,10) = ELE_STA1(:, 10)+2*(islot-1);
     TEMP2(:,11) = ELE_STA1(:,11);
     ELE_STA2 = [ELE_STA2;TEMP2];    
     node_offset = max(PTS_STA2(:,1));
end
 
clear ELE_STA1

[PTS_STA2(:,2),PTS_STA2(:,3)] = pol2cart(PTS_STA2(:,3),PTS_STA2(:,2));
[PTS_STA3, ELE_STA3] = rmDupl(PTS_STA2, ELE_STA2);

% REPLACING THE NODELABELS WITH THEIR POSITION IN THE NODAL COORDINATES 
[PTS_STA, ELE_STA] = label2pos(PTS_STA3, ELE_STA3);
PTS_STA(:,1) = PTS_STA(:,1) + max(PTS_ROT(:,1));
ELE_STA(:,1:8) = ELE_STA(:,1:8) + max(PTS_ROT(:,1));

clear ELE_STA2
clear ELE_STA3

% 
% figure(1)
% clf
% iopt = 0;
% iok = Drawplt_4(PTS_STA, ELE_STA, iopt);
% % iok = drawnodes(KPTS_STA, KELE_STA, iopt);
% title('MESH ONLY WITH THE KEY ELEMENTS')
% 
% 
% figure(2)
% clf
% iopt = 0;
% iok = Drawplt_4(KPTS_STA, KELE_STA, iopt);
% iok = drawnodes(KPTS_STA, KELE_STA, iopt);

end

