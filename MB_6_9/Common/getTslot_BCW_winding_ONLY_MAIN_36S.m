function Tslot_v2 = getTslot_BCW_winding_ONLY_MAIN_36S(SLOT_STA)

% ------------------------------- getTslot.m ------------------------------
% THIS MATLAB FUNCTION WILL RETURN THE STATOR SLOT TRANSFORMATION MATRIX TO 
% TRANSFORM THE STATOR SLOT CURRENTS TO PHASE CURRENTS IN THE PRESENT MODEL 
% THE NUMBER OF STATOR SLOTS IS 36 AND 3 PHASE CURRENTS AND 3 BRIDGE
% CURRENTS

Tslot    = zeros(2*SLOT_STA, 4*3) ;
Tslot_v1 = zeros(12, 6) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PHASE A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (+1)a1<->(-1)a3
Tslot(2,   1) = 1 ; 
Tslot(72,  1) = 1 ;
Tslot(70,  1) = 1 ;

Tslot(19, 1) =  -1 ;
Tslot(17, 1) =  -1 ;
Tslot(15, 1) =  -1 ;

% (+1)a4<->(-1)a6
Tslot(68, 2) =  1 ;
Tslot(66, 2) =  1 ;
Tslot(64, 2) =  1 ;

Tslot(13, 2) = -1 ;
Tslot(11, 2) = -1 ;
Tslot(9, 2) = -1 ;

% (+1)aa1<->(-1)aa3
Tslot(38, 3) =  1 ;
Tslot(36, 3) =  1 ;
Tslot(34, 3) =  1 ;

Tslot(55, 3) = -1 ;
Tslot(53, 3) = -1 ;
Tslot(51, 3) = -1 ;

% (+1)aa4<->(-1)aa6
Tslot(32,  4) = 1 ;
Tslot(30,  4) = 1 ;
Tslot(28,  4) = 1 ;

Tslot(49, 4) =  -1 ;
Tslot(47, 4) =  -1 ;
Tslot(45, 4) =  -1 ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PHASE B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (+1)b1<->(-1)b3
Tslot(14, 5) = 1 ;
Tslot(12, 5) = 1 ;
Tslot(10, 5) = 1 ;

Tslot(31,  5) =  -1 ;
Tslot(29,  5) =  -1 ;
Tslot(27,  5) =  -1 ;

% (+1)b4<->(-1)b6
Tslot(8, 6) =  1 ;
Tslot(6, 6) =  1 ;
Tslot(4, 6) =  1 ;

Tslot(25, 6) = -1 ;
Tslot(23, 6) = -1 ;
Tslot(21, 6) = -1 ;

% (+1)bb1<->(-1)bb3
Tslot(50, 7) =  1 ;
Tslot(48, 7) =  1 ;
Tslot(46, 7) =  1 ;

Tslot(67, 7) = -1 ;
Tslot(65, 7) = -1 ;
Tslot(63, 7) = -1 ;

% (+1)bb4<->(-1)bb6
Tslot(44, 8) = 1 ;
Tslot(42, 8) = 1 ;
Tslot(40, 8) = 1 ;

Tslot(61, 8) =  -1 ;
Tslot(59, 8) =  -1 ;
Tslot(57, 8) =  -1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PHASE C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (+1)c1<->(-1)c3
Tslot(26, 9) = 1 ;
Tslot(24, 9) = 1 ;
Tslot(22, 9) = 1 ;

Tslot(43, 9) =  -1 ;
Tslot(41, 9) =  -1 ;
Tslot(39, 9) =  -1 ;

% (+1)c4<->(-1)c6
Tslot(20, 10) =  1 ;
Tslot(18, 10) =  1 ;
Tslot(16, 10) =  1 ;

Tslot(37, 10) = -1 ;
Tslot(35, 10) = -1 ;
Tslot(33, 10) = -1 ;

% (+1)cc1<->(-1)cc3
Tslot(62, 11) =  1 ;
Tslot(60, 11) =  1 ;
Tslot(58, 11) =  1 ;

Tslot(7, 11) = -1 ;
Tslot(5, 11) = -1 ;
Tslot(3, 11) = -1 ;

% (+1)cc4<->(-1)cc6
Tslot(56, 12) = 1 ;
Tslot(54, 12) = 1 ;
Tslot(52, 12) = 1 ;

Tslot(1,  12) =  -1 ;
Tslot(71, 12) =  -1 ;
Tslot(69, 12) =  -1 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PHASE A %%%%%%%%
Tslot_v1(1, 1) = (+1)*0.5 ; 
Tslot_v1(2, 1) = (+1)*0.5 ; 
Tslot_v1(3, 1) = (+1)*0.5 ; 
Tslot_v1(4, 1) = (+1)*0.5 ;
Tslot_v1(1, 2) = (+1)*0.5 ; 
Tslot_v1(2, 2) = (+1)*0.5 ; 
Tslot_v1(3, 2) = (-1)*0.5 ; 
Tslot_v1(4, 2) = (-1)*0.5 ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PHASE B %%%%%%%%
Tslot_v1(5, 3) = (+1)*0.5 ; 
Tslot_v1(6, 3) = (+1)*0.5 ; 
Tslot_v1(7, 3) = (+1)*0.5 ; 
Tslot_v1(8, 3) = (+1)*0.5 ;
Tslot_v1(5, 4) = (+1)*0.5 ; 
Tslot_v1(6, 4) = (+1)*0.5 ; 
Tslot_v1(7, 4) = (-1)*0.5 ; 
Tslot_v1(8, 4) = (-1)*0.5 ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PHASE C %%%%%%%%%
Tslot_v1(9,  5) = (+1)*0.5 ; 
Tslot_v1(10, 5) = (+1)*0.5 ; 
Tslot_v1(11, 5) = (+1)*0.5 ;
Tslot_v1(12, 5) = (+1)*0.5 ;
Tslot_v1(9,  6) = (+1)*0.5 ; 
Tslot_v1(10, 6) = (+1)*0.5 ; 
Tslot_v1(11, 6) = (-1)*0.5 ; 
Tslot_v1(12, 6) = (-1)*0.5; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

size(Tslot)

pause(1)

Tslot_v2 = Tslot*Tslot_v1 ;

end