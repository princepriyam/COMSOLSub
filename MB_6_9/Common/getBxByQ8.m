function [Bx, By, BM] = getBxByQ8(ELEMS,PTS,Az,agX,agY)

% M - FILE
% -------------------------- getBxByQ8_gen.m ---------------------------
% THIS MATLAB FUNCTION CALCULATES Bx, By AND Bm IN CASE OF A 8 NODED
% QUADRILATERAL ELEMENT, THIS FUNCTION CALCULATES THE FLUX DENSITY AT
% THE ANY LOCAL POSITION GIVEN BY THE PTS

% Jacobian = zeros(2, 2); 
% JJ2  = zeros(8, 2) ; 

JJfp = zeros(2, 8) ;
SF = zeros(8, 1) ;

% Temp = zeros(8, 1); 
% BxBy = zeros(2, 1); 

nelems = size(ELEMS,1);

Bx = zeros(nelems, 1); 
By = zeros(nelems, 1); 
% BM = zeros(nelems, 1); 

for ielem = 1:nelems
   irange = ELEMS(ielem, 1:8).';
   
   X = PTS(irange, 2); 
   Y = PTS(irange, 3); 

   JJ2 = [X Y]; 

%    X0 = agX(ielem);       

   agx = agX(ielem);
   agy = agY(ielem);
   
   [Ji, Eta] = getLfromG_gen(X, Y, agx, agy);
   
   SF(1,1) = 0.25*(1-Ji)*(1-Eta)*(-1-Ji-Eta);
   SF(2,1) = 0.25*(1-Ji)*(1+Eta)*(-1-Ji+Eta);
   SF(3,1) = 0.25*(1+Ji)*(1+Eta)*(-1+Ji+Eta);
   SF(4,1) = 0.25*(1+Ji)*(1-Eta)*(-1+Ji-Eta);

   SF(5,1) = 0.5*(1- Ji)*(1-Eta*Eta);
   SF(6,1) = 0.5*(1+Eta)*(1-Ji*Ji)  ; 
   SF(7,1) = 0.5*(1+ Ji)*(1-Eta*Eta);
   SF(8,1) = 0.5*(1-Eta)*(1-Ji*Ji)  ;
   
   JJfp(1,1) = 0.25*(2*Ji + Eta - 2*Ji*Eta - Eta*Eta);
   JJfp(1,2) = 0.25*(2*Ji - Eta + 2*Ji*Eta - Eta*Eta);
   JJfp(1,3) = 0.25*(2*Ji + Eta + 2*Ji*Eta + Eta*Eta);
   JJfp(1,4) = 0.25*(2*Ji - Eta - 2*Ji*Eta + Eta*Eta);

   JJfp(1,5) = 0.5*(-1 + Eta*Eta);
   JJfp(1,6) = 0.5*(-2*Ji - 2*Ji*Eta);
   JJfp(1,7) = 0.5*( 1 - Eta*Eta);
   JJfp(1,8) = 0.5*(-2*Ji + 2*Ji*Eta);

   JJfp(2,1) =	0.25*(2*Eta + Ji - 2*Ji*Eta - Ji*Ji);
   JJfp(2,2) =	0.25*(2*Eta - Ji - 2*Ji*Eta + Ji*Ji);
   JJfp(2,3) =	0.25*(2*Eta + Ji + 2*Ji*Eta + Ji*Ji);
   JJfp(2,4) =	0.25*(2*Eta - Ji + 2*Ji*Eta - Ji*Ji);

   JJfp(2,5) =	0.5*(-2*Eta + 2*Ji*Eta);
   JJfp(2,6) =	0.5*( 1 - Ji*Ji);
   JJfp(2,7) =	0.5*(-2*Eta - 2*Ji*Eta);
   JJfp(2,8) =	0.5*(-1 + Ji*Ji);      
          
   Jacobian = JJfp*JJ2;

   Temp = Az(irange);            
   BxBy = (Jacobian\JJfp)*Temp;  
   Bx(ielem) = BxBy(2);
   By(ielem) = (-1)*BxBy(1);   
end	

BM	= sqrt(Bx.*Bx+By.*By);