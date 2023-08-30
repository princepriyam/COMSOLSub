% --- Rotor_Bay_KPs ---
% This script generates the KeyPoints array <KeyPts> for the model of one
% bay of the rotor from the machine called <MB_6_9>. 
% A single rotor bay comprises 12 SMR4s of which 2 are PM material.
% The complete rotor model comprises 6 rotor bays
% The PM material is parallel-magnetised. Banding on the outside! 
% Non-magnetic material between the magnets. 
% ---------------------------------------------------------------------

clf

% --- Set up the different radii for "corner KeyPoints".
R11 = 31.0E-3;     % Radius to bore of the rotor core pack
R13 = 37.0E-3;     % Radius to the inner corners of the PM pieces
R15 = 44.0E-3;     % Radius to the outer surface of the PM pieces
R17 = 45.5E-3;     % Radius to the outer surface of the banding
SLOT_ROT     =  6;
ANG_SECT_ROT = (2.0*pi)/SLOT_ROT;
% --- Set up the other dimensions.
WPM = 30E-3;       % Width of the PM sections.

% --- Now create the "corner KeyPoints".
pio6 = pi/6;       % Angle to the extremes of one bay. 

PDirs =  [7001,  0,  1,  0  ;     % 7001, result is in REF space  ... (1,0)
%           7001,  0,  0,  1  ;     % 7001, result is in REF space  ... (0,1)
          7002,  1,  1,  0  ;     % 7002, result is in PHYS space ... (1,0)
          7003,  1,  0,  1  ];    % 7003, result is in PHYS space ... (0,1)


% Now create the "corner KeyPoints".
nkpt = 51 ; % NUMBER OF KEY POINTS IN THE MODEL
nele = 12 ;  % NUMBER OF KEY ELEMENTS IN THE MODEL

KPTS_ROT = zeros(nkpt,  3); 
KPTS_ROT(:, 1) = (1:nkpt)';
KELE_ROT = zeros(nele, 13);


% Corner KeyPoints
q_tmp            = asin((WPM/2)/R13);
KPTS_ROT( 1,2:3) = [R11*cos(pio6),               -R11*sin(pio6)];
KPTS_ROT( 9,2:3) = [R11*cos(pio6),                R11*sin(pio6)];
KPTS_ROT( 3,2:3) = [R11*cos(q_tmp),             -R11*sin(q_tmp)];
KPTS_ROT( 7,2:3) = [R11*cos(q_tmp),              R11*sin(q_tmp)];
KPTS_ROT( 5,2:3) = [R11,                                    0.0];

tx               = sqrt(R13^2 - (WPM/2)^2);
KPTS_ROT(15,2:3) = [R13*cos(pio6),               -R13*sin(pio6)];
KPTS_ROT(23,2:3) = [R13*cos(pio6),                R13*sin(pio6)];
KPTS_ROT(17,2:3) = [tx                                 -(WPM/2)];
KPTS_ROT(21,2:3) = [tx                                  (WPM/2)];
KPTS_ROT(19,2:3) = [R13,                                    0.0];

tx               = sqrt(R15^2 - (WPM/2)^2);
KPTS_ROT(29,2:3) = [R15*cos(pio6),               -R15*sin(pio6)];
KPTS_ROT(37,2:3) = [R15*cos(pio6),                R15*sin(pio6)];
KPTS_ROT(31,2:3) = [tx                                 -(WPM/2)];
KPTS_ROT(35,2:3) = [tx                                  (WPM/2)];
KPTS_ROT(33,2:3) = [R15,                                    0.0];

tx               = sqrt(R15^2 - (WPM/2)^2);
KPTS_ROT(43,2:3) = [R17*cos(pio6),               -R17*sin(pio6)];
KPTS_ROT(51,2:3) = [R17*cos(pio6),                R17*sin(pio6)];
KPTS_ROT(45,2:3) = [tx*(R17/R15)             -(WPM/2)*(R17/R15)];
KPTS_ROT(49,2:3) = [tx*(R17/R15)              (WPM/2)*(R17/R15)];
KPTS_ROT(47,2:3) = [R17,                                    0.0];


% --- Assemble the array of "Corner KeyPoints". ---
KPTS_CRNR =   [901  [0.0        0.0];
                 1  KPTS_ROT( 1,2:3);
                 3  KPTS_ROT( 3,2:3);
                 5  KPTS_ROT( 5,2:3);
                 7  KPTS_ROT( 7,2:3);
                 9  KPTS_ROT( 9,2:3);
                15  KPTS_ROT(15,2:3);
                17  KPTS_ROT(17,2:3);
                19  KPTS_ROT(19,2:3);
                21  KPTS_ROT(21,2:3);
                23  KPTS_ROT(23,2:3);
                29  KPTS_ROT(29,2:3);
                31  KPTS_ROT(31,2:3);
                33  KPTS_ROT(33,2:3);
                35  KPTS_ROT(35,2:3);
                37  KPTS_ROT(37,2:3);
                43  KPTS_ROT(43,2:3);
                45  KPTS_ROT(45,2:3);
                47  KPTS_ROT(47,2:3);
                49  KPTS_ROT(49,2:3);
                51  KPTS_ROT(51,2:3)];
            
            
% Mid-side keyPoints in circumferential direction
KPTS_ROT(  2, 2:3) = bisect_KPs(KPTS_CRNR,   1,   3, 901);
KPTS_ROT(  4, 2:3) = bisect_KPs(KPTS_CRNR,   3,   5, 901);
KPTS_ROT(  6, 2:3) = bisect_KPs(KPTS_CRNR,   5,   7, 901);
KPTS_ROT(  8, 2:3) = bisect_KPs(KPTS_CRNR,   7,   9, 901);
KPTS_ROT( 16, 2:3) = bisect_KPs(KPTS_CRNR,  15,  17, 901);
KPTS_ROT( 18, 2:3) = bisect_KPs(KPTS_CRNR,  17,  19, 901);
KPTS_ROT( 20, 2:3) = bisect_KPs(KPTS_CRNR,  19,  21, 901);
KPTS_ROT( 22, 2:3) = bisect_KPs(KPTS_CRNR,  21,  23, 901);
KPTS_ROT( 30, 2:3) = bisect_KPs(KPTS_CRNR,  29,  31, 901);
KPTS_ROT( 32, 2:3) = bisect_KPs(KPTS_CRNR,  31,  33, 901);
KPTS_ROT( 34, 2:3) = bisect_KPs(KPTS_CRNR,  33,  35, 901);
KPTS_ROT( 36, 2:3) = bisect_KPs(KPTS_CRNR,  35,  37, 901);
KPTS_ROT( 44, 2:3) = bisect_KPs(KPTS_CRNR,  43,  45, 901);
KPTS_ROT( 46, 2:3) = bisect_KPs(KPTS_CRNR,  45,  47, 901);
KPTS_ROT( 48, 2:3) = bisect_KPs(KPTS_CRNR,  47,  49, 901);
KPTS_ROT( 50, 2:3) = bisect_KPs(KPTS_CRNR,  49,  51, 901);


% Mid-side Keypoints in radial direction
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


% Key Elements
KELE_ROT( 1,:) = [  1   3  17  15   2  11  16  10 2 1000  64 7001 0];
KELE_ROT( 2,:) = [  3   5  19  17   4  12  18  11 2 1000  64 7001 0];
KELE_ROT( 3,:) = [  5   7  21  19   6  13  20  12 2 1000  64 7001 0];
KELE_ROT( 4,:) = [  7   9  23  21   8  14  22  13 2 1000  64 7001 0];

KELE_ROT( 5,:) = [ 15  17  31  29  16  25  30  24 3    1  64 7001 0];
KELE_ROT( 6,:) = [ 17  19  33  31  18  26  32  25 4    1  64 7001 0];
KELE_ROT( 7,:) = [ 19  21  35  33  20  27  34  26 4    1  64 7001 0];
KELE_ROT( 8,:) = [ 21  23  37  35  22  28  36  27 3    1  64 7001 0];

KELE_ROT( 9,:) = [ 29  31  45  43  30  39  44  38 3    1  64 7001 0];
KELE_ROT(10,:) = [ 31  33  47  45  32  40  46  39 3    1  64 7001 0];
KELE_ROT(11,:) = [ 33  35  49  47  34  41  48  40 3    1  64 7001 0];
KELE_ROT(12,:) = [ 35  37  51  49  36  42  50  41 3    1  64 7001 0];


[KPTS_ROT(:,3),KPTS_ROT(:,2)] = cart2pol(KPTS_ROT(:,2),KPTS_ROT(:,3));
KPTS_ROT(:,3) = KPTS_ROT(:,3) + 0.5*ANG_SECT_ROT ;
[KPTS_ROT(:,2),KPTS_ROT(:,3)] = pol2cart(KPTS_ROT(:,3),KPTS_ROT(:,2));


% Divisions of the Key Elements 
nkeles = size(KELE_ROT,1);
KDIVR = zeros(nkeles,2);

KDIVR(1:4,1) = 5;
KDIVR(5:8,1) = 7;
KDIVR(9:12,1) = 3;
KDIVR([1 4 5 8  9 12],2) =  4;
KDIVR([2 3 6 7 10 11],2) = 10;

[PTSx, ELEMx] = getMesh_Q8(KPTS_ROT, KELE_ROT, KDIVR);
[PTS_ROT1, ELE_ROT1] = rmDupl(PTSx, ELEMx);

[PTS_ROT1(:,3), PTS_ROT1(:,2)] = cart2pol(PTS_ROT1(:,2),PTS_ROT1(:,3));


% pts_si_index = find(abs(PTS_STA1(:,2)-R01)<1E-06);
% pts_so_index = find(abs(PTS_STA1(:,2)-R13)<1E-06);

% Generate the mesh for the other sector also 
PTS_ROT2 = []; ELE_ROT2 = []; node_offset = 0;
tic; 
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

% Replacing the nodelables with their position in the nodal coordinates
[PTS_ROT, ELE_ROT] = label2pos(PTS_ROT3, ELE_ROT3);
time_taken = toc;

% PTS_STA(:,1) = PTS_STA(:,1) + max(PTS_ROT(:,1));
% ELE_STA(:,1:8) = ELE_STA(:,1:8) + max(PTS_ROT(:,1));

clear ELE_ROT2
clear ELE_ROT3

mnlb = min(PTS_ROT(:,1));
mxlb = max(PTS_ROT(:,1));

fprintf(' \n\n Script Stator is complete \n ');
fprintf(' Time taken to complete the rotor = %8.5f(s) \n ',time_taken);
fprintf(' %4d nodes have been created \n ',size(PTS_ROT,1));
fprintf(' %4d elements have been created \n ',size(ELE_ROT,1));
fprintf(' Min. node label = %5d \n ',mnlb);
fprintf(' Max. node label = %5d \n ',mxlb);

figure(1)
iopt = 0;
% iok = drawnodes(KPTS_ROT, KELE_ROT, iopt);
title('Mesh only with the stator key elements')
iopt = 0;
iok = Drawplt_4(KPTS_ROT, KELE_ROT, iopt);


figure(2)
iopt = 0;
iok = Drawplt_4(PTS_ROT, ELE_ROT, iopt);
title('Mesh of the complete rotor')




