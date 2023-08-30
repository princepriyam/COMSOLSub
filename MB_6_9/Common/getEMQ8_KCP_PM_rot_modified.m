function [EMQ8, PQ8, bQ8] = getEMQ8_KCP_PM_rot_modified(nodeX,nodeY,muR0,iprop,BR,AREA_SLOT,Nturn,PD_Data)
% M - FILE
% ----------------------------- getEMQ8_KCP_PM_rot.m --------------------
% ----------------------- modified by KK on 19.07.2018 --------------------
% THIS MATALAB FUNCTION RETURNS THE ELEMENT MATRIX AND FORSING FUNCTION IN 
% CASE OF A EIGHT NODED QUADRILATERAL ELEMENT
% EMQ8 AND J0 (J(zero)) ARE THE ELEMENT MATRIX AND THE CURRENT DENSITY RESPLY
% EMQ8 -> <8X8> IS THE ELEMENT MATRIX
% FQ8  -> <8X1> IS THE EXITATION VECTOR

% AWIRE = 3* pi*(1/4)*(0.56E-03)^2;

% --- Establish the symplectic 2x2 identity. (Used for "curl" from "grads")
% S    = [ 0 -1;   1  0];
S    = [ 0  1;  -1  0];

EMQ8 = zeros(8, 8); 
PQ8  = zeros(8, 1);
bQ8  = zeros(8, 1); 
% bQ8_1  = zeros(8, 1);
% ECQ8   = zeros(8, 8);
% PQR8   = zeros(8, 1);
% P_dash = zeros(8, 1);

% rho_cu  = 1.68E-08;    % RESISTIVITY OF COPPER (Ohm-m)   
% ECONVTY = (1/rho_cu);
% ECONVTY = (1/rho_cu);

% cond = (1/rho_cu);
% l    = L_STA;

% ECONVTY_rot = (1/rho_cu)*r_dc;


coors = [0.774596669241483;   0.000000000000000];
coefs = [0.555555555555556;   0.888888888888889];

GSSP = [  -coors(1)   -coors(1)   coefs(1)*coefs(1);
           coors(2)   -coors(1)   coefs(2)*coefs(1);
           coors(1)   -coors(1)   coefs(1)*coefs(1);
          -coors(1)    coors(2)   coefs(1)*coefs(2);
           coors(2)    coors(2)   coefs(2)*coefs(2);
           coors(1)    coors(2)   coefs(1)*coefs(2);
          -coors(1)    coors(1)   coefs(1)*coefs(1);
           coors(2)    coors(1)   coefs(2)*coefs(1);
           coors(1)    coors(1)   coefs(1)*coefs(1)];

ngp = 9 ; % size(GSSP,1) ... it amy vary
       
for igp = 1:ngp
    
    eta  = GSSP(igp,1);           
    neta = GSSP(igp,2);          
 
    tw_8 = [ 0.25*(1-eta)*(1-neta)*(-1-eta-neta) ;
             0.25*(1-eta)*(1+neta)*(-1-eta+neta) ;
             0.25*(1+eta)*(1+neta)*(-1+eta+neta) ;
             0.25*(1+eta)*(1-neta)*(-1+eta-neta) ;
             0.50*(1-eta)*(1-neta*neta)          ;
             0.50*(1+neta)*(1-eta*eta)           ; 
             0.50*(1+eta)*(1-neta*neta)          ;
             0.50*(1-neta)*(1-eta*eta)          ]; 
        
    tw_8_diff_eta = [0.25*(2*eta + neta - 2*eta*neta - neta*neta) ;
                     0.25*(2*eta - neta + 2*eta*neta - neta*neta) ;
                     0.25*(2*eta + neta + 2*eta*neta + neta*neta) ;
                     0.25*(2*eta - neta - 2*eta*neta + neta*neta) ;
                     0.50*(-1 + neta*neta)                        ;
                     0.50*(-2*eta - 2*eta*neta)                   ;
                     0.50*( 1 - neta*neta)                        ;
                     0.50*(-2*eta + 2*eta*neta)                  ];

    tw_8_diff_neta = [0.25*(2*neta + eta - 2*eta*neta - eta*eta)   ;
                      0.25*(2*neta - eta - 2*eta*neta + eta*eta)   ;
                      0.25*(2*neta + eta + 2*eta*neta + eta*eta)   ;
                      0.25*(2*neta - eta + 2*eta*neta - eta*eta)   ;
                      0.50*(-2*neta + 2*eta*neta)                  ;
                      0.50*( 1 - eta*eta)                          ;
                      0.50*(-2*neta - 2*eta*neta)                  ;
                      0.50*(-1 + eta*eta)                         ];
    
    Jaco = [tw_8_diff_eta'; tw_8_diff_neta']*[nodeX nodeY];
    
    Bv = [tw_8_diff_eta'  ;
          tw_8_diff_neta'];
      
    DetJ   = det(Jaco) ;          % This is its determinant.
    JaciBv = Jaco\Bv   ;          % Inverse of the Jacobian.    
    
    factor  = DetJ * GSSP(igp,3);
    SJaciBv = S*JaciBv; 
    
     
    % Interpret the principal directions data. 
    v_pd = [PD_Data(2); PD_Data(3)]; % Extract the vector v_pd.
    if (PD_Data(1)==0)               % Vector v_pd is in (ksi,eta) space.
       v_pd_xy = Jaco'*v_pd;         % Transform to (x,y) space.
    else                             % Vector v_pd is already in (x,y) space.
       v_pd_xy = v_pd;               % No transformation needed.
    end
    v_pd_xy = v_pd_xy/sqrt(v_pd_xy'*v_pd_xy); % Normalise the vector now. 
    R2x2 = [ v_pd_xy(1)  -v_pd_xy(2);
             v_pd_xy(2)   v_pd_xy(1)];  % Form the rotation matrix.
         
         
         
    % Derive the actual Emat matrix (expressed in x-y frame). 
    muR   = R2x2*muR0*R2x2.';          % Refer Emat to the x-y frame. 
    EMQ8  = EMQ8 + (factor*((SJaciBv'*muR)*SJaciBv));
%     EMQ8  = EMQ8 + (factor*((JaciBv'*muR0)*JaciBv));
    
    if(iprop == 4)    % Thin conductor regions
%         ASLOT = AREA_SLOT_HALF ;
%         ASLOT = 562.2920169 * 1E-06 ;

        ff  = 0.99;%(AWIRE*17)/ASLOT;
        PQ8 = PQ8 +(Nturn/(ff*AREA_SLOT))*factor*tw_8;        
    else
        if(iprop==8)|(iprop==6)
            BR0 = [BR(1); BR(2)];
            rem_flx =  R2x2*BR0;
%           M0x = (BR(1)*muR0(1,1)) ; 
%           M0y = (BR(2)*muR0(1,1)) ;
%           bQ8_1 =  bQ8_1 + factor*([-JaciBv(1,:)' JaciBv(2,:)']*[M0y; M0x]);
            bQ8 =  bQ8 + factor*(SJaciBv'*(muR*rem_flx));
        end
    end 
end     