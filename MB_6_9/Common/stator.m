% --- Stator_Bay ---
% This script generates a single bay of the 12-tooth stator for "MB_6_9"
% machine - a "6-9" machine design.
% There are no unique "principal directions" in the stator model.
% The number 7001 is given here arbitrarily. This number is associated
% with a principal directions set aligned to ref coordinate axis, eta. 
% ---------------------------------------------------------------------


% --- Set up the different radii for "corner KeyPoints".
R00  = 46.5E-3;              % Radius to the air gap layer with stator
R01  = 49.5E-3;              % Innermost radius of the stator.
R03  = 51.5E-3;              % Radius to the tooth tip inner corner
R05  = 56.0E-3;              % Radius to convex corner on tooth
R07  = 75.0E-3;              % Radius to back of core. (72 + 16.6)
R09  = 93.0E-3;              % Radius to back of core OD.
pio6 = pi/6;
SLOT_STA     = 6;
ANG_SECT_STA = (2.0*pi)/SLOT_STA;

% --- Set up the other lengths.
SO  = 3E-3;                  % Slot Opening. 
TW  = 18.0E-3;               % Tooth body width

PDirs =  [7001,  0,  1,  0  ;     % 7001, result is in REF space  ... (1,0)
%           7001,  0,  0,  1  ;     % 7001, result is in REF space  ... (0,1)
          7002,  1,  1,  0  ;     % 7002, result is in PHYS space ... (1,0)
          7003,  1,  0,  1  ];    % 7003, result is in PHYS space ... (0,1)


% Now create the "corner KeyPoints".
nkpt = 93 ; % NUMBER OF KEY POINTS IN THE MODEL
nele = 24 ;  % NUMBER OF KEY ELEMENTS IN THE MODEL

KPTS_STA = zeros(nkpt,  3); 
KPTS_STA(:, 1) = (1:nkpt)';
KELE_STA = zeros(nele, 13);

% Corner KeyPoints
del_q            = asin(SO*0.5/R00);       % Angle of half slot opening.
qt_ttp           = (pio6)- del_q;          % Angle to tooth tip 
tx               = sqrt(R00^2 - (TW/2)^2);
KPTS_STA( 1,2:3) = [R00*cos(pio6),                 -R00*sin(pio6)];
KPTS_STA(13,2:3) = [R00*cos(pio6),                  R00*sin(pio6)];
KPTS_STA( 3,2:3) = [R00*cos(qt_ttp),             -R00*sin(qt_ttp)];
KPTS_STA(11,2:3) = [R00*cos(qt_ttp),              R00*sin(qt_ttp)];
KPTS_STA( 5,2:3) = [tx,                                   -(TW/2)];
KPTS_STA( 9,2:3) = [tx,                                    (TW/2)];
KPTS_STA( 7,2:3) = [R00,                                      0.0];


del_q            = asin(SO*0.5/R01);       % Angle of half slot opening.
qt_ttp           = (pio6)- del_q;          % Angle to tooth tip 
tx               = sqrt(R01^2 - (TW/2)^2);
KPTS_STA(21,2:3) = [R01*cos(pio6),                 -R01*sin(pio6)];
KPTS_STA(33,2:3) = [R01*cos(pio6),                  R01*sin(pio6)];
KPTS_STA(23,2:3) = [R01*cos(qt_ttp),             -R01*sin(qt_ttp)];
KPTS_STA(31,2:3) = [R01*cos(qt_ttp),              R01*sin(qt_ttp)];
KPTS_STA(25,2:3) = [tx,                                   -(TW/2)];
KPTS_STA(29,2:3) = [tx,                                    (TW/2)];
KPTS_STA(27,2:3) = [R01,                                      0.0];


del_q            = asin(SO*0.5/R03);      % Angle of half slot opening.
qt_ttp           = (pi/8)- del_q;         % Angle to tooth tip 
tx               = sqrt(R05^2 - (TW/2)^2);
KPTS_STA(41,2:3) = [R03*cos(pio6),                 -R03*sin(pio6)];
KPTS_STA(53,2:3) = [R03*cos(pio6),                  R03*sin(pio6)];
KPTS_STA(43,2:3) = [R03*cos(qt_ttp),             -R03*sin(qt_ttp)];
KPTS_STA(51,2:3) = [R03*cos(qt_ttp),              R03*sin(qt_ttp)];
KPTS_STA(45,2:3) = [tx,                                   -(TW/2)];
KPTS_STA(49,2:3) = [tx,                                    (TW/2)];
KPTS_STA(47,2:3) = [R05,                                      0.0];


del_q            = asin(SO*0.5/R07);   % Angle of half slot opening.
qt_ttp           = (pio6)- del_q;      % Angle to tooth tip 
tx               = sqrt(R07^2 - (TW/2)^2);
KPTS_STA(61,2:3) = [R07*cos(pio6),                 -R07*sin(pio6)];
KPTS_STA(73,2:3) = [R07*cos(pio6),                  R07*sin(pio6)];
KPTS_STA(63,2:3) = [R07*cos(qt_ttp),             -R07*sin(qt_ttp)];
KPTS_STA(71,2:3) = [R07*cos(qt_ttp),              R07*sin(qt_ttp)];
KPTS_STA(65,2:3) = [tx,                                   -(TW/2)];
KPTS_STA(69,2:3) = [tx,                                    (TW/2)];
KPTS_STA(67,2:3) = [R07,                                      0.0];

del_q            = asin(SO*0.5/R09);   % Angle of half slot opening.
qt_ttp           = (pio6)- del_q;      % Angle to tooth tip 
tx               = sqrt(R09^2 - (TW/2)^2);
KPTS_STA(81,2:3) = [R09*cos(pio6),                 -R09*sin(pio6)];
KPTS_STA(93,2:3) = [R09*cos(pio6),                  R09*sin(pio6)];
KPTS_STA(83,2:3) = [R09*cos(qt_ttp),             -R09*sin(qt_ttp)];
KPTS_STA(91,2:3) = [R09*cos(qt_ttp),              R09*sin(qt_ttp)];
KPTS_STA(85,2:3) = [tx,                                   -(TW/2)];
KPTS_STA(89,2:3) = [tx,                                    (TW/2)];
KPTS_STA(87,2:3) = [R09,                                      0.0];


% --- Assemble the array of "Corner KeyPoints". ---
KPTS_CRNR =   [901  [0.0        0.0];
                 1  KPTS_STA( 1,2:3);
                 3  KPTS_STA( 3,2:3);
                 5  KPTS_STA( 5,2:3);
                 7  KPTS_STA( 7,2:3);
                 9  KPTS_STA( 9,2:3);
                11  KPTS_STA(11,2:3);
                13  KPTS_STA(13,2:3);
                21  KPTS_STA(21,2:3);
                23  KPTS_STA(23,2:3);
                25  KPTS_STA(25,2:3);
                27  KPTS_STA(27,2:3);
                29  KPTS_STA(29,2:3);
                31  KPTS_STA(31,2:3);
                33  KPTS_STA(33,2:3);
                41  KPTS_STA(41,2:3);
                43  KPTS_STA(43,2:3);
                45  KPTS_STA(45,2:3);
                47  KPTS_STA(47,2:3);
                49  KPTS_STA(49,2:3);
                51  KPTS_STA(51,2:3);
                53  KPTS_STA(53,2:3);
                61  KPTS_STA(61,2:3);
                63  KPTS_STA(63,2:3);
                65  KPTS_STA(65,2:3);
                67  KPTS_STA(67,2:3);
                69  KPTS_STA(69,2:3);
                71  KPTS_STA(71,2:3);
                73  KPTS_STA(73,2:3);
                81  KPTS_STA(81,2:3);
                83  KPTS_STA(83,2:3);
                85  KPTS_STA(85,2:3);
                87  KPTS_STA(87,2:3);
                89  KPTS_STA(89,2:3);
                91  KPTS_STA(91,2:3);
                93  KPTS_STA(93,2:3)];
            
            
% Mid-side keyPoints in circumferential direction
KPTS_STA(  2, 2:3) = bisect_KPs(KPTS_CRNR,   1,   3, 901);
KPTS_STA(  4, 2:3) = bisect_KPs(KPTS_CRNR,   3,   5, 901);
KPTS_STA(  6, 2:3) = bisect_KPs(KPTS_CRNR,   5,   7, 901);
KPTS_STA(  8, 2:3) = bisect_KPs(KPTS_CRNR,   7,   9, 901);
KPTS_STA( 10, 2:3) = bisect_KPs(KPTS_CRNR,   9,  11, 901);
KPTS_STA( 12, 2:3) = bisect_KPs(KPTS_CRNR,  11,  13, 901);
KPTS_STA( 22, 2:3) = bisect_KPs(KPTS_CRNR,  21,  23, 901);
KPTS_STA( 24, 2:3) = bisect_KPs(KPTS_CRNR,  23,  25, 901);
KPTS_STA( 26, 2:3) = bisect_KPs(KPTS_CRNR,  25,  27, 901);
KPTS_STA( 28, 2:3) = bisect_KPs(KPTS_CRNR,  27,  29, 901);
KPTS_STA( 30, 2:3) = bisect_KPs(KPTS_CRNR,  29,  31, 901);
KPTS_STA( 32, 2:3) = bisect_KPs(KPTS_CRNR,  31,  33, 901);
KPTS_STA( 42, 2:3) = bisect_KPs(KPTS_CRNR,  41,  43, 901);
KPTS_STA( 44, 2:3) = bisect_KPs(KPTS_CRNR,  43,  45, 901);
KPTS_STA( 46, 2:3) = bisect_KPs(KPTS_CRNR,  45,  47, 901);
KPTS_STA( 48, 2:3) = bisect_KPs(KPTS_CRNR,  47,  49, 901);
KPTS_STA( 50, 2:3) = bisect_KPs(KPTS_CRNR,  49,  51, 901);
KPTS_STA( 52, 2:3) = bisect_KPs(KPTS_CRNR,  51,  53, 901);
KPTS_STA( 62, 2:3) = bisect_KPs(KPTS_CRNR,  61,  63, 901);
KPTS_STA( 64, 2:3) = bisect_KPs(KPTS_CRNR,  63,  65, 901);
KPTS_STA( 66, 2:3) = bisect_KPs(KPTS_CRNR,  65,  67, 901);
KPTS_STA( 68, 2:3) = bisect_KPs(KPTS_CRNR,  67,  69, 901);
KPTS_STA( 70, 2:3) = bisect_KPs(KPTS_CRNR,  69,  71, 901);
KPTS_STA( 72, 2:3) = bisect_KPs(KPTS_CRNR,  71,  73, 901);
KPTS_STA( 82, 2:3) = bisect_KPs(KPTS_CRNR,  81,  83, 901);
KPTS_STA( 84, 2:3) = bisect_KPs(KPTS_CRNR,  83,  85, 901);
KPTS_STA( 86, 2:3) = bisect_KPs(KPTS_CRNR,  85,  87, 901);
KPTS_STA( 88, 2:3) = bisect_KPs(KPTS_CRNR,  87,  89, 901);
KPTS_STA( 90, 2:3) = bisect_KPs(KPTS_CRNR,  89,  91, 901);
KPTS_STA( 92, 2:3) = bisect_KPs(KPTS_CRNR,  91,  93, 901);


% Mid-side Keypoints in radial direction
KPTS_STA( 14, 2:3) = bisect_KPs(KPTS_CRNR,   1,  21, 0);
KPTS_STA( 15, 2:3) = bisect_KPs(KPTS_CRNR,   3,  23, 0);
KPTS_STA( 16, 2:3) = bisect_KPs(KPTS_CRNR,   5,  25, 0);
KPTS_STA( 17, 2:3) = bisect_KPs(KPTS_CRNR,   7,  27, 0);
KPTS_STA( 18, 2:3) = bisect_KPs(KPTS_CRNR,   9,  29, 0);
KPTS_STA( 19, 2:3) = bisect_KPs(KPTS_CRNR,  11,  31, 0);
KPTS_STA( 20, 2:3) = bisect_KPs(KPTS_CRNR,  13,  33, 0);
KPTS_STA( 34, 2:3) = bisect_KPs(KPTS_CRNR,  21,  41, 0);
KPTS_STA( 35, 2:3) = bisect_KPs(KPTS_CRNR,  23,  43, 0);
KPTS_STA( 36, 2:3) = bisect_KPs(KPTS_CRNR,  25,  45, 0);
KPTS_STA( 37, 2:3) = bisect_KPs(KPTS_CRNR,  27,  47, 0);
KPTS_STA( 38, 2:3) = bisect_KPs(KPTS_CRNR,  29,  49, 0);
KPTS_STA( 39, 2:3) = bisect_KPs(KPTS_CRNR,  31,  51, 0);
KPTS_STA( 40, 2:3) = bisect_KPs(KPTS_CRNR,  33,  53, 0);
KPTS_STA( 54, 2:3) = bisect_KPs(KPTS_CRNR,  41,  61, 0);
KPTS_STA( 55, 2:3) = bisect_KPs(KPTS_CRNR,  43,  63, 0);
KPTS_STA( 56, 2:3) = bisect_KPs(KPTS_CRNR,  45,  65, 0);
KPTS_STA( 57, 2:3) = bisect_KPs(KPTS_CRNR,  47,  67, 0);
KPTS_STA( 58, 2:3) = bisect_KPs(KPTS_CRNR,  49,  69, 0);
KPTS_STA( 59, 2:3) = bisect_KPs(KPTS_CRNR,  51,  71, 0);
KPTS_STA( 60, 2:3) = bisect_KPs(KPTS_CRNR,  53,  73, 0);
KPTS_STA( 74, 2:3) = bisect_KPs(KPTS_CRNR,  61,  81, 0);
KPTS_STA( 75, 2:3) = bisect_KPs(KPTS_CRNR,  63,  83, 0);
KPTS_STA( 76, 2:3) = bisect_KPs(KPTS_CRNR,  65,  85, 0);
KPTS_STA( 77, 2:3) = bisect_KPs(KPTS_CRNR,  67,  87, 0);
KPTS_STA( 78, 2:3) = bisect_KPs(KPTS_CRNR,  69,  89, 0);
KPTS_STA( 79, 2:3) = bisect_KPs(KPTS_CRNR,  71,  91, 0);
KPTS_STA( 80, 2:3) = bisect_KPs(KPTS_CRNR,  73,  93, 0);


% Key Elements
KELE_STA( 1,:) = [  1   3  23  21   2  15  22  14 3    1  64 7001 0];
KELE_STA( 2,:) = [  3   5  25  23   4  16  24  15 3    1  64 7001 0];
KELE_STA( 3,:) = [  5   7  27  25   6  17  26  16 3    1  64 7001 0];
KELE_STA( 4,:) = [  7   9  29  27   8  18  28  17 3    1  64 7001 0];
KELE_STA( 5,:) = [  9  11  31  29  10  19  30  18 3    1  64 7001 0];
KELE_STA( 6,:) = [ 11  13  33  31  12  20  32  19 3    1  64 7001 0];

KELE_STA( 7,:) = [ 21  23  43  41  22  35  42  34 3    1  64 7001 0];
KELE_STA( 8,:) = [ 23  25  45  43  24  36  44  35 2 1000  64 7001 0];
KELE_STA( 9,:) = [ 25  27  47  45  26  37  46  36 2 1000  64 7001 0];
KELE_STA(10,:) = [ 27  29  49  47  28  38  48  37 2 1000  64 7001 0];
KELE_STA(11,:) = [ 29  31  51  49  30  39  50  38 2 1000  64 7001 0];
KELE_STA(12,:) = [ 31  33  53  51  32  40  52  39 3    1  64 7001 0];

KELE_STA(13,:) = [ 41  43  63  61  42  55  62  54 3    1  64 7001 0];
KELE_STA(14,:) = [ 43  45  65  63  44  56  64  55 4    1  64 7001 0];
KELE_STA(15,:) = [ 45  47  67  65  46  57  66  56 2 1000  64 7001 0];
KELE_STA(16,:) = [ 47  49  69  67  48  58  68  57 2 1000  64 7001 0];
KELE_STA(17,:) = [ 49  51  71  69  50  59  70  58 4    1  64 7001 0];
KELE_STA(18,:) = [ 51  53  73  71  52  60  72  59 3    1  64 7001 0];

KELE_STA(19,:) = [ 61  63  83  81  62  75  82  74 2 1000  64 7001 0];
KELE_STA(20,:) = [ 63  65  85  83  64  76  84  75 2 1000  64 7001 0];
KELE_STA(21,:) = [ 65  67  87  85  66  77  86  76 2 1000  64 7001 0];
KELE_STA(22,:) = [ 67  69  89  87  68  78  88  77 2 1000  64 7001 0];
KELE_STA(23,:) = [ 69  71  91  89  70  79  90  78 2 1000  64 7001 0];
KELE_STA(24,:) = [ 71  73  93  91  72  80  92  79 2 1000  64 7001 0];

[KPTS_STA(:,3),KPTS_STA(:,2)] = cart2pol(KPTS_STA(:,2),KPTS_STA(:,3));
KPTS_STA(:,3) = KPTS_STA(:,3) + 0.5*ANG_SECT_STA ;
[KPTS_STA(:,2),KPTS_STA(:,3)] = pol2cart(KPTS_STA(:,3),KPTS_STA(:,2));


% Divisions of the Key Elements 
nkeles = size(KELE_STA,1);
KDIVS = zeros(nkeles,2);

KDIVS([ 1  6], 1) = 2;
KDIVS([ 7 12], 1) = 2;
KDIVS(    2:5, 1) = 2;
KDIVS(   8:11, 1) = 3;
KDIVS(  13:18, 1) = 8;
KDIVS(  19:24, 1) = 6;
KDIVS([ 1  7 13 19], 2) = 1;
KDIVS([ 6 12 18 24], 2) = 1;
KDIVS( 2:3:23,       2) = 5;
KDIVS([3 4 9 10 15 16 21 22],2) = 4;


[PTSx, ELEMx] = getMesh_Q8(KPTS_STA, KELE_STA, KDIVS);
[PTS_STA1, ELE_STA1] = rmDupl(PTSx, ELEMx);

[PTS_STA1(:,3), PTS_STA1(:,2)] = cart2pol(PTS_STA1(:,2),PTS_STA1(:,3));


% pts_si_index = find(abs(PTS_STA1(:,2)-R01)<1E-06);
% pts_so_index = find(abs(PTS_STA1(:,2)-R13)<1E-06);

% Generate the mesh for the other sector also 
PTS_STA2 = []; ELE_STA2 = []; node_offset = 0;
tic; 
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

% Replacing the nodelables with their position in the nodal coordinates
[PTS_STA, ELE_STA] = label2pos(PTS_STA3, ELE_STA3);
time_taken = toc;

% PTS_STA(:,1) = PTS_STA(:,1) + max(PTS_ROT(:,1));
% ELE_STA(:,1:8) = ELE_STA(:,1:8) + max(PTS_ROT(:,1));

clear ELE_STA2
clear ELE_STA3

mnlb = min(PTS_STA(:,1));
mxlb = max(PTS_STA(:,1));

fprintf(' \n\n Script Stator is complete \n ');
fprintf(' Time taken to complete the stator = %8.5f(s) \n ',time_taken);
fprintf(' %4d nodes have been created \n ',size(PTS_STA,1));
fprintf(' %4d elements have been created \n ',size(ELE_STA,1));
fprintf(' Min. node label = %5d \n ',mnlb);
fprintf(' Max. node label = %5d \n ',mxlb);

figure(1)
iopt = 0;
% iok = drawnodes(KPTS_STA, KELE_STA, iopt);
title('Mesh only with the stator key elements')
iopt = 0;
iok = Drawplt_4(KPTS_STA, KELE_STA, iopt);


figure(2)
iopt = 0;
iok = Drawplt_4(PTS_STA, ELE_STA, iopt);
title('Mesh of the complete stator')






