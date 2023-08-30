function [Big_ptsM, Big_connM] = rmDupl(Big_pts, Big_conn)

%THIS MATLAB FUNCTION REMOVES THE DUPLICATE NODES AND ACCORDINGLY MODIFIES 
%THE CONNECTIVITY 

Big_ptsM  = Big_pts; 
Big_connM = Big_conn; 
n_pts = size(Big_ptsM, 1); 
DUP = [];

for it = 1:n_pts
    X1 = Big_ptsM(it, 2); 
    Y1 = Big_ptsM(it, 3);
    for jt = (it+1):n_pts
        X2 = Big_ptsM(jt, 2); Y2 = Big_ptsM(jt, 3);
        DIST = sqrt((X1-X2)^2+(Y1-Y2)^2);
        if(DIST<1E-10)
           DUP = [DUP; jt Big_ptsM(jt, 1) Big_ptsM(it, 1)];
        end
    end
end

n_dup = length(DUP);
for kt = 1:n_dup
    [myR, myC] = find(abs(DUP(kt,2)-Big_connM)<1E-10);
    n_index = length(myR);
    for it = 1:n_index
        Big_connM(myR(it), myC(it)) = DUP(kt, 3);
    end    
end

nDup = size(DUP,1);

if(nDup>=1)
    Big_ptsM(DUP(:, 1), :) = [];
end