function [r0, s0] = getLfromG_gen(X, Y, agx, agy)

% ----------------------- getLfromG_gen.m -------------------
% THIS MATLAB FUNCTION RETURNS THE LOCAL COORDINATE FROM THE 
% GLOBAL COORDINATE USING THE NEWTON-RAPHSON TECHNIQUE
SF   = zeros(8, 1) ;
JJfp = zeros(2, 8) ;
   
% INTIAL GUESS 
r0 = 0.0 ; %eta
s0 = 0.0 ;

XY0 = [X Y];     
axy = [agx agy]';

ERROR = 1E04 ;

while(ERROR>1E-10)

   SF(1, 1) = 0.25*(1-r0)*(1-s0)*(-1-r0-s0) ; %N
   SF(2, 1) = 0.25*(1-r0)*(1+s0)*(-1-r0+s0) ;
   SF(3, 1) = 0.25*(1+r0)*(1+s0)*(-1+r0+s0) ;
   SF(4, 1) = 0.25*(1+r0)*(1-s0)*(-1+r0-s0) ;

   SF(5, 1) = 0.5*(1- r0)*(1-s0*s0) ;
   SF(6, 1) = 0.5*(1+ s0)*(1-r0*r0) ; 
   SF(7, 1) = 0.5*(1+ r0)*(1-s0*s0) ;
   SF(8, 1) = 0.5*(1- s0)*(1-r0*r0) ;
        
   JJfp(1, 1) = 0.25*(2*r0 + s0 - 2*r0*s0 - s0*s0) ; %dN/deta
   JJfp(1, 2) = 0.25*(2*r0 - s0 + 2*r0*s0 - s0*s0) ;
   JJfp(1, 3) = 0.25*(2*r0 + s0 + 2*r0*s0 + s0*s0) ;
   JJfp(1, 4) = 0.25*(2*r0 - s0 - 2*r0*s0 + s0*s0) ;

   JJfp(1, 5) = 0.5*(-1 + s0*s0)      ;
   JJfp(1, 6) = 0.5*(-2*r0 - 2*r0*s0) ;
   JJfp(1, 7) = 0.5*( 1 - s0*s0)      ;
   JJfp(1, 8) = 0.5*(-2*r0 + 2*r0*s0) ;

   JJfp(2, 1) = 0.25*(2*s0 + r0 - 2*r0*s0 - r0*r0) ;
   JJfp(2, 2) = 0.25*(2*s0 - r0 - 2*r0*s0 + r0*r0) ;
   JJfp(2, 3) = 0.25*(2*s0 + r0 + 2*r0*s0 + r0*r0) ;
   JJfp(2, 4) = 0.25*(2*s0 - r0 + 2*r0*s0 - r0*r0) ;

   JJfp(2, 5) = 0.5*(-2*s0 + 2*r0*s0) ;
   JJfp(2, 6) = 0.5*( 1 - r0*r0)      ;
   JJfp(2, 7) = 0.5*(-2*s0 - 2*r0*s0) ;
   JJfp(2, 8) = 0.5*(-1 + r0*r0)      ;      
          
   S = JJfp*XY0 ;
   
   pxy0 = (SF'*XY0)'; 

   RES = axy - pxy0 ; % RESIDUE
      
   prs0 = (S'\RES)  ; %h

   ERROR  = sqrt(RES'*RES);

   r1 = r0 + prs0(1) ; % UPDATE 'r1'
   s1 = s0 + prs0(2) ; % UPDATE 's1'

   r0 = r1 ;
   s0 = s1 ;
end  