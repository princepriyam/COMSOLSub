function Indices = findlabl(Objects, Labels);
% --- findlabl ---
% Array <Objects> contains several columns. Column 1 contains labels. 
% Array <Labels> contains labels whose indices should be found.
% This function determines the corresponding indices.
% If a label present in <Labels> is not found within column 1 of <Objects>,
% then a (-1) is returned in place of the index.
%
%     function Indices = findlabl(Objects, Labels);
%
% NOTE: This function does NOT protect against duplication of labels
% within column 1 of <Objects>
% ------------------------------------------------------------------------

MLbls = size(Labels,1);         % Count how many rows are in Labels. 
NLbls = size(Labels,2);         % Count how many columns are in Labels. 
Indices = Labels*0;             % Initialise the output array.

for iLbl=1:MLbls                % Step through all rows
   for jLbl=1:NLbls             % Step through all columns
      [a,b] = min(abs(Objects(:,1)-Labels(iLbl,jLbl)));
      if (a > 0)
         Indices(iLbl,jLbl)=-1;
      else
         Indices(iLbl,jLbl)=b;
      end
   end
end

end
