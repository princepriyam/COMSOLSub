function [Big_ptsN, Big_connN] = label2pos(Big_ptsM, Big_connM)

% -------------------- label2pos.m ----------------------------
% THIS MATLAB FUNCTION MODIFIES THE CONNECTIVITY MATRIX. NODE 
% LABELS ARE REPLACED BY THE POSITION IN THE NODES

n_pts  = size(Big_ptsM, 1); 
n_conn = size(Big_connM,1);

Big_ptsN = zeros(n_pts,3); 
Big_ptsN(:,2:3) = Big_ptsM(:,2:3);
Big_ptsN(:,1) = (1:n_pts)';

Big_connN = zeros(n_conn,11);
Big_connN(:, 9:13) = Big_connM(:, 9:13);

for it = 1:n_conn
    for jt = 1:8
        kt = find(abs(Big_connM(it,jt)-Big_ptsM(:,1))<1E-12);
        Big_connN(it,jt) = kt;
    end
end