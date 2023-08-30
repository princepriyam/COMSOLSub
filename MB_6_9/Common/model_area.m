function m_area = model_area(NodSet, Elems3, Elems4, MatLabl);
% --- model_area ---
% This function computes the total area of all elements in the model
% having the specified material label, <MatLabl>.
%
%  m_area = model_area(NodSet, Elems3, Elems4, MatLabl);
% 
% ----------------------------------------------------------------------

m_area = 0.0;                       % Initialise the output.

% --- First process the 3-sided elements. ---
Nele3 = size(Elems3,1);
for iele3=1:Nele3
   ele3 = Elems3(iele3,:);        % Pick out the element data.
   if (ele3(8)==MatLabl)          % Only process this element if ... 
      Labls = (ele3(1:6)).';      % Pick out the node labels
      Indxs = findlabl(NodSet,Labls);  % Find the corresponding indices.
      area_t = ele6_area(NodSet(Indxs,2),NodSet(Indxs,3));
      m_area  = m_area + area_t;
   end
end

% --- Next process the 4-sided elements. ---
Nele4 = size(Elems4,1);
for iele4=1:Nele4
   ele4 = Elems4(iele4,:);        % Pick out the element data.
   if (ele4(10)==MatLabl)         % Only process this element if ... 
      Labls = (ele4(1:8)).';      % Pick out the node labels
      Indxs = findlabl(NodSet,Labls);  % Find the corresponding indices.
      area_t = ele8_area(NodSet(Indxs,2),NodSet(Indxs,3));
      m_area  = m_area + area_t;
   end
end

end
