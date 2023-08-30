 function [KPTS_ROT,KELE_ROT,PTS_ROT,ELE_ROT,KDIVR] = getrot48_trial() 

addpath ../PREPOX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IND1_Params = getparams() ; % Get the parameters of stator and rotor.

% % ----------------------------- ROTOR -----------------------------
SLOT_ROT = IND1_Params.SLOT_ROT      ; % NUMBER OF ROTOR SLOTS
OD_ROT   = IND1_Params.OD_ROT        ; % (in mm) OUTER DIAMTER OF THE ROTOR
ID_ROT   = IND1_Params.ID_ROT        ; % (in mm) INSIDE DIAMTER OF THE ROTOR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------------- MESH FOR THE ROTOR -----------------------
% --------- FOR REFERENCE OF THE POINTS REFER THE DOCUMENT -----------
% -------------- KEY POINTS AND KEY ELEMENTS FOR ROTOR ---------------
% COORDINATES ARE IN POLAR TO BE CONVERTED TO CARTESIAN COORDINATES LATER
nkpt = 137 ;                             % no. of key points taken in a rotor section
nele =  38 ;                             % no. of elements in a rotor section
KPTS_ROT = zeros(nkpt, 3) ;              % nkpt-no. of rows, 3-no. of columns. zeros(nkpt,3) indicated all elements in the matrix are given zero values
KPTS_ROT(:,1) = (1:nkpt)' ;              % column 1 is given value 1 to 76. column 2 and 3 elements are still zero. 
KELE_ROT = zeros(nele, 11)       ;
ANG_SECT_ROT = (2*pi)/SLOT_ROT ;       % Angle of a rotor section


KPTS_ROT(1, 2:3) = [ 0.5*ID_ROT         0.5*ANG_SECT_ROT ];   
KPTS_ROT(3, 2:3) = [ 0.5*ID_ROT         1.4046341*pi/180 ];
KPTS_ROT(2, 2:3) = [ 0.5*ID_ROT         0.5*(KPTS_ROT(1, 3)+KPTS_ROT(3, 3)) ];  
KPTS_ROT(4, 2:3) = [ 0.5*ID_ROT         0      ];
KPTS_ROT(5, 2:3) = [ 0.5*ID_ROT        -KPTS_ROT(3, 3) ];
KPTS_ROT(6, 2:3) = [ 0.5*ID_ROT        -KPTS_ROT(2, 3) ];
KPTS_ROT(7, 2:3) = [ 0.5*ID_ROT        -0.5*ANG_SECT_ROT   ];   



KPTS_ROT(12, 2:3) = [ 68.6469161E-03                           0.5*ANG_SECT_ROT ];   
KPTS_ROT(14, 2:3) = [ 68.6469161E-03                           0.7672607*pi/180 ];
KPTS_ROT(13, 2:3) = [ 0.5*(KPTS_ROT(12, 2)+KPTS_ROT(14, 2))    0.5*(KPTS_ROT(12, 3)+KPTS_ROT(14, 3)) ];
KPTS_ROT(15, 2:3) = [ 68.26E-03                                0   ];
KPTS_ROT(16, 2:3) = [ KPTS_ROT(14, 2)    -KPTS_ROT(14, 3) ];
KPTS_ROT(17, 2:3) = [ KPTS_ROT(13, 2)    -KPTS_ROT(13, 3) ];
KPTS_ROT(18, 2:3) = [ KPTS_ROT(12, 2)    -KPTS_ROT(12, 3) ];

KPTS_ROT( 8, 2:3) = [0.5*(KPTS_ROT(1, 2)+KPTS_ROT(12, 2))    0.5*(KPTS_ROT(1, 3)+KPTS_ROT(12, 3))   ];   
KPTS_ROT( 9, 2:3) = [0.5*(KPTS_ROT(3, 2)+KPTS_ROT(14, 2))    0.5*(KPTS_ROT(3, 3)+KPTS_ROT(14, 3))   ];
KPTS_ROT(10, 2:3) = [KPTS_ROT(9, 2)                         -KPTS_ROT(9, 3)   ];
KPTS_ROT(11, 2:3) = [KPTS_ROT(8, 2)                         -KPTS_ROT(8, 3)   ];


KELE_ROT(1, :) = [ 3    1   12   14    2    8    13    9    3    0   64];
KELE_ROT(2, :) = [ 5    3   14   16    4    9    15   10    3    0   64];        
KELE_ROT(3, :) = [ 7    5   16   18    6   10    17   11    3    0   64];




KPTS_ROT(20, 2:3) = [69.0729542E-03       0.9963116*pi/180  ];   
KPTS_ROT(25, 2:3) = [69.5721467E-03       0.5*ANG_SECT_ROT];
KPTS_ROT(27, 2:3) = [69.5721467E-03       1.0706705*pi/180 ];   
KPTS_ROT(26, 2:3) = [69.5721467E-03       0.5*(KPTS_ROT(25, 3)+KPTS_ROT(27, 3))  ];
KPTS_ROT(29, 2:3) = [69.5630369E-03       0.5353820*pi/180 ];
KPTS_ROT(28, 2:3) = [0.5*(KPTS_ROT(27, 2)+KPTS_ROT(29, 2))  0.5*(KPTS_ROT(27, 3)+KPTS_ROT(29, 3)) ];

KPTS_ROT(31, 2:3) = [69.1019091E-03                          0.3810958*pi/180 ]; 
KPTS_ROT(30, 2:3) = [0.5*(KPTS_ROT(29, 2)+KPTS_ROT(31, 2))   0.5*(KPTS_ROT(29, 3)+KPTS_ROT(31, 3)) ];  
KPTS_ROT(32, 2:3) = [68.91E-03                               0   ];
KPTS_ROT(33, 2:3) = [69.56E-03                               0   ];
KPTS_ROT(34, 2:3) = [ KPTS_ROT(31, 2)                       -KPTS_ROT(31, 3)  ];
KPTS_ROT(35, 2:3) = [ KPTS_ROT(30, 2)                       -KPTS_ROT(30, 3)  ];
KPTS_ROT(36, 2:3) = [ KPTS_ROT(29, 2)                       -KPTS_ROT(29, 3)  ];
KPTS_ROT(37, 2:3) = [ KPTS_ROT(28, 2)                       -KPTS_ROT(28, 3)  ];
KPTS_ROT(38, 2:3) = [ KPTS_ROT(27, 2)                       -KPTS_ROT(27, 3)  ];
KPTS_ROT(39, 2:3) = [ KPTS_ROT(26, 2)                       -KPTS_ROT(26, 3)  ];
KPTS_ROT(40, 2:3) = [ KPTS_ROT(25, 2)                       -KPTS_ROT(25, 3)  ];

KPTS_ROT(21, 2:3) = [0.5*(KPTS_ROT(14, 2)+KPTS_ROT(31, 2))   0.5*(KPTS_ROT(14, 3)+KPTS_ROT(31, 3))];
KPTS_ROT(22, 2:3) = [KPTS_ROT(21, 2)                        -KPTS_ROT(21, 3)];
KPTS_ROT(23, 2:3) = [KPTS_ROT(20, 2)                        -KPTS_ROT(20, 3)];
% 
% 
KPTS_ROT(19, 2:3) = [0.5*(KPTS_ROT(12, 2)+KPTS_ROT(25, 2))    0.5*(KPTS_ROT(12, 3)+KPTS_ROT(25, 3)) ];
KPTS_ROT(24, 2:3) = [KPTS_ROT(19, 2)                         -KPTS_ROT(19, 3) ];
KPTS_ROT(26, 2:3) = [0.5*(KPTS_ROT(25, 2)+KPTS_ROT(27, 2))    0.5*(KPTS_ROT(25, 3)+KPTS_ROT(27, 3)) ];   
% 
% 

KELE_ROT(4, :) = [14   12    25    27    13    19    26    20    3    0   64];  
KELE_ROT(5, :) = [31   14    27    29    21    20    28    30    5    1   64];     % 5 is for Rotor bar (Thick conductor region)
KELE_ROT(6, :) = [16   14    31    34    15    21    32    22    5    1   64];        
KELE_ROT(7, :) = [34   31    29    36    32    30    33    35    5    1   64];
KELE_ROT(8, :) = [16   34    36    38    22    35    37    23    5    1   64];
KELE_ROT(9, :) = [18   16    38    40    17    23    39    24    3    0   64];        


%  
KPTS_ROT(47, 2:3) = [95.7054758E-03                              0.5*ANG_SECT_ROT ];
KPTS_ROT(49, 2:3) = [95.7054758E-03                              1.7663496*pi/180     ];   
KPTS_ROT(48, 2:3) = [95.7054758E-03                              0.5*(KPTS_ROT(47, 3)+KPTS_ROT(49, 3)) ];
KPTS_ROT(51, 2:3) = [95.669E-03                                  0.748*pi/180        ];
KPTS_ROT(50, 2:3) = [0.5*(KPTS_ROT(49, 2)+KPTS_ROT(51, 2))       0.5*(KPTS_ROT(49, 3)+KPTS_ROT(51, 3)) ];   
KPTS_ROT(52, 2:3) = [95.661E-03                                  0          ];   
% 
% 
KPTS_ROT(53, 2:3) = [KPTS_ROT(51, 2)    -KPTS_ROT(51, 3) ];   
KPTS_ROT(54, 2:3) = [KPTS_ROT(50, 2)    -KPTS_ROT(50, 3) ];   
KPTS_ROT(55, 2:3) = [KPTS_ROT(49, 2)    -KPTS_ROT(49, 3) ];   
KPTS_ROT(56, 2:3) = [KPTS_ROT(48, 2)    -KPTS_ROT(48, 3) ];   
KPTS_ROT(57, 2:3) = [KPTS_ROT(47, 2)    -KPTS_ROT(47, 3) ];
%    
KPTS_ROT(41, 2:3) = [0.5*(KPTS_ROT(25, 2)+KPTS_ROT(47, 2))     0.5*(KPTS_ROT(25, 3)+KPTS_ROT(47, 3)) ];   
KPTS_ROT(42, 2:3) = [0.5*(KPTS_ROT(27, 2)+KPTS_ROT(49, 2))     0.5*(KPTS_ROT(27, 3)+KPTS_ROT(49, 3)) ];   
KPTS_ROT(43, 2:3) = [0.5*(KPTS_ROT(29, 2)+KPTS_ROT(51, 2))     0.5*(KPTS_ROT(29, 3)+KPTS_ROT(51, 3)) ];   
KPTS_ROT(44, 2:3) = [0.5*(KPTS_ROT(36, 2)+KPTS_ROT(53, 2))     0.5*(KPTS_ROT(36, 3)+KPTS_ROT(53, 3)) ];
KPTS_ROT(45, 2:3) = [0.5*(KPTS_ROT(38, 2)+KPTS_ROT(55, 2))     0.5*(KPTS_ROT(38, 3)+KPTS_ROT(55, 3)) ];   
KPTS_ROT(46, 2:3) = [0.5*(KPTS_ROT(40, 2)+KPTS_ROT(57, 2))     0.5*(KPTS_ROT(40, 3)+KPTS_ROT(57, 3)) ];      
% 

KELE_ROT(10, :)= [27    25    47    49    26    41    48    42    3    0   64];
KELE_ROT(11, :)= [29    27    49    51    28    42    50    43    5    1   64];
KELE_ROT(12, :) = [36   29    51    53    33    43    52    44    5    1   64];
KELE_ROT(13, :) = [38   36    53    55    37    44    54    45    5    1   64];  
KELE_ROT(14, :) = [40   38    55    57    39    45    56    46    3    0   64];


KPTS_ROT(64, 2:3) = [98.3400225E-03                              0.5*ANG_SECT_ROT  ];    
KPTS_ROT(66, 2:3) = [98.3400225E-03                              0.7283063*pi/180     ];
KPTS_ROT(65, 2:3) = [98.3400225E-03                              0.5*(KPTS_ROT(64, 3)+KPTS_ROT(66, 3)) ];   
% KPTS_ROT(68, 2:3) = [96.9714376                                0.4697076*pi/180     ];
KPTS_ROT(68, 2:3) = [96.9812578E-03                              0.3915892*pi/180     ];
KPTS_ROT(67, 2:3) = [0.5*(KPTS_ROT(66, 2)+KPTS_ROT(68, 2))       0.5*(KPTS_ROT(66, 3)+KPTS_ROT(68, 3)) ];  
KPTS_ROT(69, 2:3) = [96.9962344E-03                              0    ]; 
% 
% 
KPTS_ROT(70, 2:3) = [98.3320778E-03                                  0            ];    
KPTS_ROT(71, 2:3) = [KPTS_ROT(68, 2)                          -KPTS_ROT(68, 3)];
KPTS_ROT(72, 2:3) = [KPTS_ROT(67, 2)                          -KPTS_ROT(67, 3)];
KPTS_ROT(73, 2:3) = [KPTS_ROT(66, 2)                          -KPTS_ROT(66, 3)];    
KPTS_ROT(74, 2:3) = [KPTS_ROT(65, 2)                          -KPTS_ROT(65, 3)];  
KPTS_ROT(75, 2:3) = [KPTS_ROT(64, 2)                          -KPTS_ROT(64, 3)]; 
% 
% 
KPTS_ROT(58, 2:3) = [0.5*(KPTS_ROT(47, 2)+KPTS_ROT(64, 2))      0.5*(KPTS_ROT(47, 3)+KPTS_ROT(64, 3)) ];   
KPTS_ROT(59, 2:3) = [97.2753566E-03                             1.4661819*pi/180 ];   
KPTS_ROT(60, 2:3) = [0.5*(KPTS_ROT(51, 2)+KPTS_ROT(68, 2))      0.5*(KPTS_ROT(51, 3)+KPTS_ROT(68, 3)) ];    
KPTS_ROT(61, 2:3) = [KPTS_ROT(60, 2)                           -KPTS_ROT(60, 3) ]; 
KPTS_ROT(62, 2:3) = [KPTS_ROT(59, 2)                           -KPTS_ROT(59, 3) ]; 
KPTS_ROT(63, 2:3) = [KPTS_ROT(58, 2)                           -KPTS_ROT(58, 3) ]; 
% 
%
KELE_ROT(15, :) = [49   47    64    66    48    58    65    59    3    0   64];        
KELE_ROT(16, :) = [51   49    66    68    50    59    67    60    5    1   64];
KELE_ROT(17, :) = [53   51    68    71    52    60    69    61    5    1   64];
KELE_ROT(18, :) = [71   68    66    73    69    67    70    72    5    1   64];
KELE_ROT(19, :) = [55   53    71    73    54    61    72    62    5    1   64];
KELE_ROT(20, :) = [57   55    73    75    56    62    74    63    3    0   64];


% 
KPTS_ROT(80, 2:3) = [103.1903932E-03                               +0.5*ANG_SECT_ROT ];     
KPTS_ROT(82, 2:3) = [103.1903932E-03                                0.6940712*pi/180 ]; 
KPTS_ROT(81, 2:3) = [0.5*(KPTS_ROT(80, 2)+KPTS_ROT(82, 2))          0.5*(KPTS_ROT(80, 3)+KPTS_ROT(82, 3))];
KPTS_ROT(83, 2:3) = [103.1828220E-03                                0  ]; 
%  
% 
KPTS_ROT(84, 2:3) = [KPTS_ROT(82, 2)       -KPTS_ROT(82, 3)]; 
KPTS_ROT(85, 2:3) = [KPTS_ROT(81, 2)       -KPTS_ROT(81, 3)];   
KPTS_ROT(86, 2:3) = [KPTS_ROT(80, 2)       -KPTS_ROT(80, 3) ];  
% 
%  
KPTS_ROT(76, 2:3) = [0.5*(KPTS_ROT(64, 2)+KPTS_ROT(80, 2))      0.5*(KPTS_ROT(64, 3)+KPTS_ROT(80, 3)) ];   
KPTS_ROT(77, 2:3) = [0.5*(KPTS_ROT(66, 2)+KPTS_ROT(82, 2))      0.5*(KPTS_ROT(66, 3)+KPTS_ROT(82, 3)) ];   
KPTS_ROT(78, 2:3) = [KPTS_ROT(77, 2)                           -KPTS_ROT(77, 3) ]; 
KPTS_ROT(79, 2:3) = [KPTS_ROT(76, 2)                           -KPTS_ROT(76, 3) ];
% 
% 
KELE_ROT(21, :) = [66   64    80    82    65    76    81    77    3    0   64];        
KELE_ROT(22, :) = [73   66    82    84    70    77    83    78    5    1   64];
KELE_ROT(23, :) = [75   73    84    86    74    78    85    79    3    0   64];

% 
KPTS_ROT(93, 2:3) = [105.9524804E-03                          0.5*ANG_SECT_ROT ];   
KPTS_ROT(95, 2:3) = [105.9524804E-03                          1.6225228*pi/180    ]; 
KPTS_ROT(94, 2:3) = [0.5*(KPTS_ROT(93, 2)+KPTS_ROT(95, 2))    0.5*(KPTS_ROT(93, 3)+KPTS_ROT(95, 3)) ];
% KPTS_ROT(97, 2:3) = [105.9239657        0.9304134*pi/180    ]; 
KPTS_ROT(97, 2:3) = [105.9212394E-03                          0.8346817*pi/180    ]; 

KPTS_ROT(96, 2:3) = [105.9362908E-03                          1.2765146*pi/180    ];  
% 
KPTS_ROT(87, 2:3) = [0.5*(KPTS_ROT(80, 2)+KPTS_ROT(93, 2))    0.5*ANG_SECT_ROT ]; 
KPTS_ROT(88, 2:3) = [104.3203742E-03                          1.3868708*pi/180 ];   
 
KPTS_ROT(91, 2:3) = [KPTS_ROT(88, 2)     -KPTS_ROT(88, 3) ];
KPTS_ROT(92, 2:3) = [KPTS_ROT(87, 2)     -KPTS_ROT(87, 3) ];  
% 
KPTS_ROT(99, 2:3) = [104.5904451E-03                          0.4711226*pi/180 ];
KPTS_ROT(98, 2:3) = [0.5*(KPTS_ROT(97, 2)+KPTS_ROT(99, 2))    0.5*(KPTS_ROT(97, 3)+KPTS_ROT(99, 3)) ]; 
KPTS_ROT(89, 2:3) = [0.5*(KPTS_ROT(82, 2)+KPTS_ROT(99, 2))    0.5*(KPTS_ROT(82, 3)+KPTS_ROT(99, 3)) ];
KPTS_ROT(90, 2:3) = [KPTS_ROT(89, 2)                         -KPTS_ROT(89, 3) ];
KPTS_ROT(100, 2:3) = [104.5869093E-03       0 ];   
KPTS_ROT(101, 2:3) = [105.91E-03            0 ];
KPTS_ROT(102, 2:3) = [KPTS_ROT(99, 2)      -KPTS_ROT(99, 3)];
KPTS_ROT(103, 2:3) = [KPTS_ROT(98, 2)      -KPTS_ROT(98, 3)];
KPTS_ROT(104, 2:3) = [KPTS_ROT(97, 2)      -KPTS_ROT(97, 3)];
% 
KPTS_ROT(105, 2:3) = [KPTS_ROT(96, 2)      -KPTS_ROT(96, 3)];
KPTS_ROT(110, 2:3) = [107.2133355E-03       1.4552953*pi/180];
% 
% 
KPTS_ROT(106, 2:3) = [KPTS_ROT(95, 2)      -KPTS_ROT(95, 3)];
KPTS_ROT(107, 2:3) = [KPTS_ROT(94, 2)      -KPTS_ROT(94, 3)];
KPTS_ROT(108, 2:3) = [KPTS_ROT(93, 2)      -KPTS_ROT(93, 3)]; 


KELE_ROT(24, :) = [82   80    93    95   81     87    94    88    3    0   64];
KELE_ROT(25, :) = [99   82    95    97   89     88    96    98    5    1   64];
KELE_ROT(26, :) = [84   82    99   102   83     89   100    90    5    1   64];        
KELE_ROT(27, :) = [102  99    97   104  100     98   101   103    5    1   64];
KELE_ROT(28, :) = [84  102   104   106   90    103   105    91    5    1   64];
KELE_ROT(29, :) = [86   84   106   108   85     91   107    92    3    0   64];

KPTS_ROT(113, 2:3) = [KPTS_ROT(110, 2)   -KPTS_ROT(110, 3)]; 
% 
% KPTS_ROT(115, 2:3) = [107.8636416                              0.5*ANG_SECT_ROT];
KPTS_ROT(115, 2:3) = [108.2288262E-03                            0.5*ANG_SECT_ROT];
% KPTS_ROT(117, 2:3) = [107.8636416                              1.2204706*pi/180 ]; 
KPTS_ROT(117, 2:3) = [KPTS_ROT(115, 2)                           1.0247207*pi/180 ]; 
KPTS_ROT(116, 2:3) = [0.5*(KPTS_ROT(115, 2)+KPTS_ROT(117, 2))    0.5*(KPTS_ROT(115, 3)+KPTS_ROT(117, 3)) ];    
% KPTS_ROT(119, 2:3) = [107.0951703                              0.6747735*pi/180];
KPTS_ROT(119, 2:3) = [107.2048527E-03                            0.4733878*pi/180];
KPTS_ROT(118, 2:3) = [0.5*(KPTS_ROT(117, 2)+KPTS_ROT(119, 2))    0.5*(KPTS_ROT(117, 3)+KPTS_ROT(119, 3)) ];   
% KPTS_ROT(120, 2:3) = [107.63                                   0 ];
KPTS_ROT(120, 2:3) = [107.453E-03                                0 ];
% 
KPTS_ROT(109, 2:3) = [0.5*(KPTS_ROT(93, 2)+KPTS_ROT(115, 2))     0.5*(KPTS_ROT(93, 3)+KPTS_ROT(115, 3))]; 
KPTS_ROT(111, 2:3) = [0.5*(KPTS_ROT(97, 2)+KPTS_ROT(119, 2))     0.5*(KPTS_ROT(97, 3)+KPTS_ROT(119, 3))]; 
KPTS_ROT(112, 2:3) = [KPTS_ROT(111, 2)                          -KPTS_ROT(111, 3)];
KPTS_ROT(114, 2:3) = [KPTS_ROT(109, 2)                          -KPTS_ROT(109, 3)];   
% 
KPTS_ROT(121, 2:3) = [KPTS_ROT(119, 2)      -KPTS_ROT(119, 3)];   
KPTS_ROT(122, 2:3) = [KPTS_ROT(118, 2)      -KPTS_ROT(118, 3)];   
KPTS_ROT(123, 2:3) = [KPTS_ROT(117, 2)      -KPTS_ROT(117, 3)];  
KPTS_ROT(124, 2:3) = [KPTS_ROT(116, 2)      -KPTS_ROT(116, 3)];    
KPTS_ROT(125, 2:3) = [KPTS_ROT(115, 2)      -KPTS_ROT(115, 3)];


KELE_ROT(30, :) = [95     93   115   117   94    109   116   110    3    0   64];
KELE_ROT(31, :) = [97     95   117   119   96    110   118   111    5    1   64];        
KELE_ROT(32, :) = [104    97   119   121  101    111   120   112    5    1   64];
KELE_ROT(33, :) = [106   104   121   123  105    112   122   113    5    1   64];
KELE_ROT(34, :) = [108   106   123   125  107    113   124   114    3    0   64];

% 
KPTS_ROT(131, 2:3) = [0.5*OD_ROT           0.5* ANG_SECT_ROT ]; 
KPTS_ROT(133, 2:3) = [0.5*OD_ROT           1.1129959*pi/180  ]; 
KPTS_ROT(134, 2:3) = [0.5*OD_ROT           0 ]; 
KPTS_ROT(132, 2:3) = [0.5*OD_ROT           0.5*(KPTS_ROT(131, 3)+KPTS_ROT(133, 3))]; 
KPTS_ROT(135, 2:3) = [0.5*OD_ROT          -KPTS_ROT(133, 3)]; 
KPTS_ROT(136, 2:3) = [0.5*OD_ROT          -KPTS_ROT(132, 3)]; 
KPTS_ROT(137, 2:3) = [0.5*OD_ROT          -0.5*ANG_SECT_ROT]; 
% 
% 
KPTS_ROT(126, 2:3) = [0.5*(KPTS_ROT(115, 2)+KPTS_ROT(131, 2))     0.5*(KPTS_ROT(115, 3)+KPTS_ROT(131, 3))];
KPTS_ROT(127, 2:3) = [0.5*(KPTS_ROT(117, 2)+KPTS_ROT(133, 2))     0.5*(KPTS_ROT(117, 3)+KPTS_ROT(133, 3))];
KPTS_ROT(128, 2:3) = [ 108.91E-03                                 0 ];
KPTS_ROT(128, 2:3) = [ 108.91E-03                                 0 ];
KPTS_ROT(129, 2:3) = [ KPTS_ROT(127, 2)                          -KPTS_ROT(127, 3) ];
KPTS_ROT(130, 2:3) = [ KPTS_ROT(126, 2)                          -KPTS_ROT(126, 3) ];


KELE_ROT(35, :) = [117   115   131   133  116    126   132   127    3    0   64];
KELE_ROT(36, :) = [121   119   117   123   120   118   128   122    5    1   64];        
KELE_ROT(37, :) = [125   123   135   137   124   129   136   130    3    0   64];
KELE_ROT(38, :) = [123   117   133   135   128   127   134   129    3    0   64];



 KPTS_ROT(:,3) = KPTS_ROT(:,3) + 0.5*ANG_SECT_ROT;         
% 
[KPTS_ROT(:,2),KPTS_ROT(:,3)] = pol2cart(KPTS_ROT(:,3),KPTS_ROT(:,2));     

% Discretization ... for details refer <XXX.doc>
nkeler = size(KELE_ROT,1);
KDIVR = zeros(nkeler,2); 

KDIVR(:, 1) = 1 ; 
KDIVR(:, 2) = 1 ;

% Center = [2 6 7 12 17 18 22 26 27 32 36 38]' ;
% KDIVR(Center, 2) = 2 ;

KDIVR(1:3, 1) = 3 ;
KDIVR(10:14, 1) = 3 ;

% RAD1 = [1 3 4 9 10 14 15 20 21 23 24 29 30 34 35 37]' ;
% KDIVR(RAD1, 2) = 2 ;
% KDIVR(21:23, 1) = 2 ;



% Get the discretised mesh 
[PTSx, ELEMx] = getMesh_Q8(KPTS_ROT, KELE_ROT, KDIVR);
% Remove the redundant nodes 
[PTS_ROT1, ELE_ROT1] = rmDupl(PTSx, ELEMx);

% Convert the nodes coordinates from cartesian to polar.
[PTS_ROT1(:,3), PTS_ROT1(:,2)] = cart2pol(PTS_ROT1(:,2),PTS_ROT1(:,3));

% ---------GENERATE THE MESH FOR THE OTHER SECTOR ALSO -----------------
PTS_ROT2 = []; ELE_ROT2 = []; node_offset = 0;
  
  for islot = 1:SLOT_ROT
%  for islot = 1:2
     TEMP1 = PTS_ROT1;
     TEMP1(:,1) = TEMP1(:,1) + node_offset;
     TEMP1(:,3) = TEMP1(:,3) + ANG_SECT_ROT*(islot-1);
     PTS_ROT2 = [PTS_ROT2;TEMP1];   
     TEMP2 = ELE_ROT1;    
     TEMP2(:,1:8) = TEMP2(:,1:8)+node_offset; 
     TEMP2(:,10) = ELE_ROT1(:,10)*islot;
     ELE_ROT2 = [ELE_ROT2;TEMP2];    
     node_offset = max(PTS_ROT2(:,1));
end

% Convert the nodes coordinates from polar to cartesian. 
[PTS_ROT2(:,2),PTS_ROT2(:,3)] = pol2cart(PTS_ROT2(:,3),PTS_ROT2(:,2));
% Remove the duplicate nodes
[PTS_ROT3, ELE_ROT3] = rmDupl(PTS_ROT2, ELE_ROT2);

% REPLACING THE NODELABELS WITH THEIR POSITION IN THE NODAL COORDINATES 
[PTS_ROT, ELE_ROT] = label2pos(PTS_ROT3, ELE_ROT3);
 
clear ELE_ROT1
clear ELE_ROT2
clear ELE_ROT3

% npts_rot = size(PTS_ROT,1);           
% nele_rot = size(ELE_ROT,1);
% 
% disp(' NODES AND ELEMENTS FOR THE ROTOR HAS GENERATED ')
% disp([' ROTOR HAS ', int2str(npts_rot), ' NODES AND ', int2str(nele_rot), ' ELEMENTS']);
% 
% 
% 
% figure(1)        %one Rotot sector
% clf
% iopt = 0;
% iok = Drawplt_4(KPTS_ROT, KELE_ROT, iopt);
% % hold on;
% % iok = drawnodes(KPTS_ROT, KELE_ROT, iopt);
% % title('MESH ONLY WITH THE KEY ELEMENTS')
% % hold off
% % % 
% figure(2)        %full Rotor
% clf
% iopt = 0 ;
% iok = Drawplt_4(PTS_ROT, ELE_ROT, iopt) ;
% 
% % hold on;
% % iok = drawnodes(PTS_ROT, ELE_ROT, iopt);
% % title('MESH ONLY WITH THE KEY ELEMENTS')
% % hold off
% % 
% % pause 
end

