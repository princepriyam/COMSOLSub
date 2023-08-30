function EMT6 = getEMT6_modified(nodeX,nodeY,muR0,PD_Data)

% M - FILE
% ----------------------------- getEMT6.m ---------------------------------
% THIS MATALAB FUNCTION RETURNS THE ELEMENT MATRIX AND FORSING FUNCTION IN 
% CASE OF A EIGHT NODED QUADRILATERAL ELEMENT
% EMQ8 AND J0 (J(zero)) ARE THE ELEMENT MATRIX AND THE CURRENT DENSITY RESPLY
% EMQ8 -> <8X8> IS THE ELEMENT MATRIX
% FQ8  -> <8X1> IS THE EXITATION VECTOR


% --- Establish the symplectic 2x2 identity. (Used for "curl" from "grads")
% S    = [ 0 -1;   1  0];
S    = [ 0  1;  -1  0];

JJ2  = zeros(6,2);
EMT6 = zeros(6,6); 
JJfp = zeros(2,6);

Length = 1.0; % UNIT LENGTH ALONG Z

JJ2(:,1) = nodeX; 
JJ2(:,2) = nodeY;
       
np  = 7;   % np x np WILL BE THE NUMBER OF GAUSS POINTS        
GPr = zeros(7,1); 
GPs = zeros(7,1); 
WF  = zeros(7,1);

GPr(1)=0.1012865073235;  GPs(1)=0.1012865073235;
GPr(2)=0.7974269853531;  GPs(2)=0.1012865073235;
GPr(3)=0.1012865073235;  GPs(3)=0.7974269853531;
GPr(4)=0.4701420641051;  GPs(4)=0.0597158717898;
GPr(5)=0.4701420641051;  GPs(5)=0.4701420641051;
GPr(6)=0.0597158717898;  GPs(6)=0.4701420641051;
GPr(7)=0.3333333333333;  GPs(7)=0.3333333333333;

WF(1) = 0.1259391805448;
WF(2) = 0.1259391805448;
WF(3) = 0.1259391805448;
WF(4) = 0.1323941527885;
WF(5) = 0.1323941527885;
WF(6) = 0.1323941527885;
WF(7) = 0.225;

for ip = 1:np
    
    eta  = GPr(ip);
    neta = GPs(ip); 	
    
    JJfp(1,1) = 4.0*eta+4.0*neta-3.0;
    JJfp(1,2) = 0.0;
    JJfp(1,3) = 4.0*eta-1.0;

    JJfp(1,4) = (-1)*4.0*neta;
    JJfp(1,5) =      4.0*neta;
    JJfp(1,6) = 4.0-8.0*eta-4.0*neta;

    JJfp(2,1) =	4.0*eta+4.0*neta-3.0;
    JJfp(2,2) = 4.0*neta-1.0;
    JJfp(2,3) =	0.0;

    JJfp(2,4) =	4.0-4.0*eta-8.0*neta;
    JJfp(2,5) =	4.0*eta;
    JJfp(2,6) =	(-1.0)*4.0*eta;
        
    Jacobian = JJfp*JJ2;       
    JaciBv   = (Jacobian\JJfp);
    
%     EMT6 = EMT6 + ((WF(ip)*det(Jacobian))*((JaciBv'*muR)*JaciBv));  

    % Derive the actual Emat matrix (expressed in x-y frame). 
    muR   = R2x2*muR0*R2x2.';          % Refer Emat to the x-y frame. 
%     EMT6  = EMT6 + (factor*((SJaciBv'*muR)*SJaciBv));
    EMT6  = EMT6 + ((WF(ip)*det(Jacobian))*((SJaciBv'*muR)*SJaciBv));
end