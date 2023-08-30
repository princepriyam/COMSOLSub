function [A_ele, V_ele] = ele8_area(Node_X,Node_Y)
% ----------------------------- ele8_area.m -------------------------------
% This function calculates the area of an 8-noded quadrilateral element. 
% ... INPUT ARGUMENTS ... 
% Node_X    : A vector of 8 nodal X-coordinates
% Node_Y    : A vector of 8 nodal Y-coordinates
% ... OUTPUT ARGUMENTS ... 
% A_ele     : The scalar area (in length-units squared)
% V_ele     : A vector of 8 individual areas indicating the corresponding
%             distribution of area across the nodes.
%
% The same ordering is used for how KeyPoints define the SMR (structured 
% meshable region) as is used for how Nodes define a quadrilateral element.
%
%                    2  6  3
%                    5     7
%                    1  8  4
% 
% In the reference coordinate set (ksi, eta), these points have the 
% following coordinate pairs:
% 1: (-1,-1) ,  2: (-1,+1) , 3: (+1,+1) , 4: (+1,-1)   
% 5: (-1, 0) ,  6: ( 0,+1) , 7: (+1, 0) , 8: ( 0,-1)
%
% [A_ele, V_ele] = ele8_area(Node_X,Node_Y)
%
% ------------------------------------------------------------------------

% --- We operate analogous to assuming a unity current density in the
%     element and finding the corresponding 8 nodal voltages.
%     The sum of these 8 nodal voltages is the element area.
V_ele = zeros(8, 1); 

% Gauss points and corresponding weights 

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
       
for igp = 1:ngp
    
    ksi = GSSP(igp, 1);           
    eta = GSSP(igp, 2);          
 
    % Eight shape functions 
    tw_8 = [ 0.25*(1-ksi)*(1-eta)*(-1-ksi-eta) ;
             0.25*(1-ksi)*(1+eta)*(-1-ksi+eta) ;
             0.25*(1+ksi)*(1+eta)*(-1+ksi+eta) ;
             0.25*(1+ksi)*(1-eta)*(-1+ksi-eta) ;
             0.50*(1-ksi)*(1-eta*eta)          ;
             0.50*(1+eta)*(1-ksi*ksi)           ; 
             0.50*(1+ksi)*(1-eta*eta)          ;
             0.50*(1-eta)*(1-ksi*ksi)          ]; 
    
    % Differentiation of Shape functions w.r.t ksi     
    tw_8_diff_ksi = [0.25*(2*ksi + eta - 2*ksi*eta - eta*eta) ;
                     0.25*(2*ksi - eta + 2*ksi*eta - eta*eta) ;
                     0.25*(2*ksi + eta + 2*ksi*eta + eta*eta) ;
                     0.25*(2*ksi - eta - 2*ksi*eta + eta*eta) ;
                     0.50*(-1 + eta*eta)                      ;
                     0.50*(-2*ksi - 2*ksi*eta)                ;
                     0.50*( 1 - eta*eta)                      ;
                     0.50*(-2*ksi + 2*ksi*eta)               ];

    % Differentiation of Shape functions w.r.t eta             
    tw_8_diff_eta = [0.25*(2*eta + ksi - 2*ksi*eta - ksi*ksi)   ;
                     0.25*(2*eta - ksi - 2*ksi*eta + ksi*ksi)   ;
                     0.25*(2*eta + ksi + 2*ksi*eta + ksi*ksi)   ;
                     0.25*(2*eta - ksi + 2*ksi*eta - ksi*ksi)   ;
                     0.50*(-2*eta + 2*ksi*eta)                  ;
                     0.50*( 1 - ksi*ksi)                        ;
                     0.50*(-2*eta - 2*ksi*eta)                  ;
                     0.50*(-1 + ksi*ksi)                       ];

    % Assemble the gradient matrix at this Gauss point. This expresses 
    % local gradients of value (in REF space) w.r.t. discrete nodal values)
    Bv = [tw_8_diff_ksi' ;
          tw_8_diff_eta'];
    
    % Calculate Jacobian matrix [ d_x/d_ksi, d_y/d_ksi; d_x/d_eta, d_y/d_eta;  
    Jaco = Bv * [Node_X Node_Y];
      
    DetJ   = det(Jaco) ;          % This is its determinant.
    JaciBv = Jaco\Bv   ;          % Inverse of the Jacobian * Bv.    
    
    factor  = DetJ * GSSP(igp,3);
    
    % Add the contribution to nodal currents from circuit currents
    V_ele =  V_ele + factor*tw_8*1.0;    
end

A_ele = sum(V_ele);


end
