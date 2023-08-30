function [Big_pts,Big_conn,Big_Ts] = getMesh_Q8(KPTS, KELEMS, MYDIV)

%THIS MATLAB FUNCTION GEMERATES THE NODES AND CONNECTIVITY FOR THE 
%WHOLE REGION

nm = size(KELEMS, 1);

Big_conn = [];
Big_pts  = [];
Big_Ts   = [];

for it = 1:nm
    myoffset = it;
    x_div = MYDIV(it, 1); y_div = MYDIV(it, 2);
    [PTS,CONN,Ts1] = getIndMesh_Q8_save1(KPTS, KELEMS(it,:), x_div, y_div, myoffset);    
    Big_conn = [Big_conn; CONN];    
    Big_pts  = [Big_pts; PTS];
    Big_Ts   = [Big_Ts;  Ts1];
end