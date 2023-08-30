function [Ts, T_c_r, T_c_l, T_m] = getTs_12X6_exp_automatic_iaibic_close(SLOT_STA,MD_STA,L_STA,Le_S)

%%%%%%%%%%%%%%%  getTs_12X6_exp_automatic_iaibic_close.m  %%%%%%%%%%%%%%%%%

Ts = getTslot_BCW_winding_ONLY_MAIN_24S(SLOT_STA); % 48X6

% FIND OUT THE RESISTANCE OF THE STATOR WINDING
circum_turn = 2*pi*(1/SLOT_STA)*10*0.5*MD_STA;    % why multiplied by 10?

L_one = (L_STA + (1.5*circum_turn))*2;    %? DOUBT

%L_equi = 17*L_one*6;  

rho_coil = 1.68E-08;

a_coil = pi*(1/4)*(0.56E-03)^2;
a_coil = a_coil*1;

Res_one_coil = rho_coil*L_one*(1/a_coil);
Res_equi     = Res_one_coil*1;                                                             

% Res_equi = 0.017; 
% RES_STA  = Res_equi*eye(6);
RES_STA = Res_equi;
% RES_STA = 6.8;

% FIND OUT THE INDUCTANCE OF THE STATOR WINDING
% IND_STA = Le_S*eye(6);
IND_STA = Le_S;
R = RES_STA;
L = IND_STA;
% Rb = 0.001;
% Lb = 1e-14;

% % Rb = 0;
% % Lb = 0;


T_c_r = R*[2  0  -2  0   0   0 ;
           0  0  -2  2  -2   0 ;
          -4  2   0  0   0   0;
           0  0   4 -2   0   0 ;
           0  0   0  0   4  -2; 
           0  1   0  1   0   1];

                
T_c_l = L*[2  0  -2  0   0   0 ;
           0  0  -2  2  -2   0 ;
          -4  2   0  0   0   0;
           0  0   4 -2   0   0 ;
           0  0   0  0   4  -2; 
           0  1   0  1   0   1];
                          

T_m = [ 1 0  0  0  0 0 ;
       -1 1  0  0  0 0 ;
       -1 1  0  0  0 0 ;
        1 0  0  0  0 0 ;
        0 0  1  0  0 0 ;
        0 0 -1  1  0 0 ;
        0 0 -1  1  0 0 ;
        0 0  1  0  0 0 ;
        0 0  0  0  1 0 ;
        0 0  0  0 -1 1 ;
        0 0  0  0 -1 1 ;
        0 0  0  0  1 0 ]; 
    
    
    
% T_c_r = R*[2  0  -2  0   0   0 ;
%            0  0  -2  2  -2   0 ;
%           -4  2   0  0   0   0;
%            0  0  -4  2   0   0 ;
%            0  0   0  0  -4   2; 
%            0  1   0  1   0   1];
% 
%                 
% T_c_l = L*[2  0  -2  0   0   0 ;
%            0  0  -2  2  -2   0 ;
%           -4  2   0  0   0   0;
%            0  0  -4  2   0   0 ;
%            0  0   0  0  -4   2; 
%            0  1   0  1   0   1];
%                           
% 
% T_m = [ 1 0  0  0  0 0 ;
%        -1 1  0  0  0 0 ;
%        -1 1  0  0  0 0 ;
%         1 0  0  0  0 0 ;
%         0 0  1  0  0 0 ;
%         0 0 -1  1  0 0 ;
%         0 0 -1  1  0 0 ;
%         0 0  1  0  0 0 ;
%         0 0  0  0  1 0 ;
%         0 0  0  0 -1 1 ;
%         0 0  0  0 -1 1 ;
%         0 0  0  0  1 0 ]; 

% 
% T_c_r =   [2*R  0  -2*R   0     0    0   -R      R      0;
%             0   0  -2*R  2*R  -2*R   0    0      R      R;
%           -2*R  R    0    0     0    0   -Rb     0      0;
%           -2*R  R    0    0     0    0  2*R+Rb   0      0;
%             0   0  -2*R   R     0    0    0     -Rb     0;
%             0   0  -2*R   R     0    0    0    2*R+Rb   0;
%             0   0    0    0   -2*R   R    0      0     -Rb;
%             0   0    0    0   -2*R   R    0      0     2*R+Rb;
%             0   1    0    1     0    1    0      0      0];
% 
%                 
% T_c_l =   [2*L  0  -2*L   0     0    0   -L      L      0;
%             0   0  -2*L  2*L  -2*L   0    0      L      L;
%           -2*L  L    0    0     0    0   -Lb     0      0;
%           -2*L  L    0    0     0    0  2*L+Lb   0      0;
%             0   0  -2*L   L     0    0    0     -Lb     0;
%             0   0  -2*L   L     0    0    0    2*L+Lb   0;
%             0   0    0    0   -2*L   L    0      0     -Lb;
%             0   0    0    0   -2*L   L    0      0     2*L+Lb;
%             0   1    0    1     0    1    0      0      0];
%                           
% 
% T_m = [ 1 0  0  0  0 0  0  0  0;
%        -1 1  0  0  0 0  1  0  0;
%        -1 1  0  0  0 0  0  0  0;
%         1 0  0  0  0 0 -1  0  0;
%         0 0  1  0  0 0  0  0  0;
%         0 0 -1  1  0 0  0  1  0;
%         0 0 -1  1  0 0  0  0  0;
%         0 0  1  0  0 0  0 -1  0;
%         0 0  0  0  1 0  0  0  0;
%         0 0  0  0 -1 1  0  0  1;
%         0 0  0  0 -1 1  0  0  0;
%         0 0  0  0  1 0  0  0 -1]; 
% 
end