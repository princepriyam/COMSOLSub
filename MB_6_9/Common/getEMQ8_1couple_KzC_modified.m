function EMQ8 = getEMQ8_1couple_KzC_modified(nodeX,nodeY,muR0,PD_Data)

% M - FILE
% ----------------------------- getEMQ8_1.m ---------------------------------
% THIS MATALAB FUNCTION RETURNS THE ELEMENT MATRIX AND FORSING FUNCTION IN 
% CASE OF A EIGHT NODED QUADRILATERAL ELEMENT
% EMQ8 AND J0 (J(zero)) ARE THE ELEMENT MATRIX AND THE CURRENT DENSITY RESPLY
% EMQ8 -> <8X8> IS THE ELEMENT MATRIX
% FQ8  -> <8X1> IS THE EXITATION VECTOR

S    = [ 0 -1;  1  0];

EMQ8   = zeros(8, 8); 

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
 
%     tw_8 = [ 0.25*(1-eta)*(1-neta)*(-1-eta-neta) ;
%              0.25*(1-eta)*(1+neta)*(-1-eta+neta) ;
%              0.25*(1+eta)*(1+neta)*(-1+eta+neta) ;
%              0.25*(1+eta)*(1-neta)*(-1+eta-neta) ;
%              0.50*(1-eta)*(1-neta*neta)          ;
%              0.50*(1+neta)*(1-eta*eta)           ; 
%              0.50*(1+eta)*(1-neta*neta)          ;
%              0.50*(1-neta)*(1-eta*eta)          ]; 
        
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
    if (PD_Data(1)==0)            % Vector v_pd is in (ksi,eta) space.
       v_pd_xy = Jaco'*v_pd;      % Transform to (x,y) space.
    else                          % Vector v_pd is already in (x,y) space.
       v_pd_xy = v_pd;            % No transformation needed.
    end
    v_pd_xy = v_pd_xy/sqrt(v_pd_xy'*v_pd_xy); % Normalise the vector now. 
    R2x2 = [ v_pd_xy(1)  -v_pd_xy(2);
             v_pd_xy(2)   v_pd_xy(1)];  % Form the rotation matrix.
         
         
         
    % Derive the actual Emat matrix (expressed in x-y frame). 
    muR  = R2x2*muR0*R2x2.';          % Refer Emat to the x-y frame. 
    EMQ8  = EMQ8 + (factor*((SJaciBv'*muR)*SJaciBv));
end     