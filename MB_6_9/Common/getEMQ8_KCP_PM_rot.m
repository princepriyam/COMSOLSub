function [EMQ8, PQ8, bQ8] = getEMQ8_KCP_PM_rot(nodeX,nodeY,muR,iprop,BR,AREA_SLOT,Nturn)
% M - FILE
% ----------------------------- getEMQ8_KCP_PM_rot.m --------------------
% ----------------------- modified by KK on 19.07.2018 --------------------
% THIS MATALAB FUNCTION RETURNS THE ELEMENT MATRIX AND FORSING FUNCTION IN 
% CASE OF A EIGHT NODED QUADRILATERAL ELEMENT
% EMQ8 AND J0 (J(zero)) ARE THE ELEMENT MATRIX AND THE CURRENT DENSITY RESPLY
% EMQ8 -> <8X8> IS THE ELEMENT MATRIX
% FQ8  -> <8X1> IS THE EXITATION VECTOR

% AWIRE = 3* pi*(1/4)*(0.56E-03)^2;

EMQ8 = zeros(8, 8); 
PQ8  = zeros(8, 1);
bQ8  = zeros(8, 1); 

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
    
    EMQ8  = EMQ8 + (factor*((JaciBv'*muR)*JaciBv));      
    
    if(iprop == 4)    % Thin conductor regions
%         ASLOT = AREA_SLOT_HALF ;
%         ASLOT = 562.2920169 * 1E-06 ;
        ff  = 0.99;%(AWIRE*17)/ASLOT;
        PQ8 = PQ8 +(Nturn/(ff*AREA_SLOT))*factor*tw_8;        
    else
        if(iprop==8)|(iprop==6)
            M0x = (BR(1)*muR(1,1)) ; 
            M0y = (BR(2)*muR(1,1)) ;
            bQ8 =  bQ8 + factor*([-JaciBv(1,:)' JaciBv(2,:)']*[M0y; M0x]);
        end
    end 
end     