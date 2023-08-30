function [PTS,CONN,Ts1] = getIndMesh_Q8_save1(KPTS, KELEMS, x_div, y_div, OFFSET)

%-------------------- getIndMesh_Q8.m ---------------------------------------
%THIS MATLAB SCRIPT GENERATES THE INDIVIDUAL MESH FOR THE EACH KEY ELEMENTS
%elem IS THE CONNECTIVITY MATRIX AND pts IS THE COORDINATE MATRIX
%NUMBERING OF THE ELEMENTS ARE 

% ---------------2----6----3--------------------------
%                |         |
% ---------------5         7--------------------------
%                |         |
% ---------------1----8----4--------------------------

KELEMS(8);
irange = KELEMS(1:8);
nodeX = KPTS(irange, 2) ;
nodeY = KPTS(irange, 3) ;

CONN = zeros(x_div*y_div, 13); 
CONN(:,  9) =  KELEMS( 9);
CONN(:, 10) =  KELEMS(10);
CONN(:, 11) =  KELEMS(11);
CONN(:, 12) =  KELEMS(12);

x_pts = (2*x_div+1); y_pts = (2*y_div+1);
PTS = zeros(x_pts*y_pts, 3);
PTS(:, 1) = OFFSET*10000+(1:x_pts*y_pts).';
eta_range = (-1:(1/x_div):1).'; neta_range = (-1:(1/y_div):1).'; 
for nt = 1:y_pts
    for jt = 1:x_pts
    
    eta  = eta_range(jt)  ; 
    neta = neta_range(nt) ;    

    tw_8 = [ 0.25*(1-eta)*(1-neta)*(-1-eta-neta) ;
             0.25*(1-eta)*(1+neta)*(-1-eta+neta) ;
             0.25*(1+eta)*(1+neta)*(-1+eta+neta) ;
             0.25*(1+eta)*(1-neta)*(-1+eta-neta) ;
             0.50*(1-eta)*(1-neta*neta)          ;
             0.50*(1+neta)*(1-eta*eta)           ; 
             0.50*(1+eta)*(1-neta*neta)          ;
             0.50*(1-neta)*(1-eta*eta)          ]; 

     nm = x_pts*(nt-1);  
     PTS(jt+nm, 2:3) = [tw_8'*nodeX tw_8'*nodeY]; 
    end
end

dummy = zeros(x_div*y_div,1);
ielem = 1;

for it = 1:x_div
 for jt = 1:y_div
   tx1 = 2*(x_pts*(jt-1));
   tx2 = 4*x_div+2*it;
   tx3 = 2*x_div+2*it;
   
   CONN(ielem,1:8)=[PTS((2*it-1)+tx1,1) PTS(tx2+tx1+1, 1)...
                    PTS(tx2+tx1+3,   1) PTS(2*it+tx1+1,1)...
                    PTS(tx3+tx1,     1) PTS(tx2+tx1+2, 1)...
                    PTS(tx3+tx1+2,   1) PTS(2*it+tx1,  1)];

   dummy(ielem) = tx3+tx1+1;
   ielem = ielem+1; 
 end
end

PTS(dummy,:) = [];

[PTS_new, ELE_new] = label2pos(PTS, CONN);
nele = size(ELE_new, 1);
Ts1  = zeros(nele,   1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

ngp = 9 ; % size(GSSP,1) ... it may vary

for iele = 1:nele
    Ts = zeros(8,1);
    iprop  = ELE_new(iele, 9) ;    
    irange = ELE_new(iele, 1:8).';
    nodeX = PTS_new(irange,2);
    nodeY = PTS_new(irange,3);
       
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
        JaciBv = Jaco\Bv   ;          % Inverse of the Jacobian *Bv.    
    
        factor  = DetJ * GSSP(igp,3);
        Ts = Ts + factor*tw_8;
    end
    Ts1(iele, 1:2) = [sum(Ts) iprop];
end