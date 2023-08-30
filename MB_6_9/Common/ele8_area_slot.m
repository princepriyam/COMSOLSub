function m_area = ele8_area_slot(PTS,ELE, MatLabl)
% model_area
% This function computes the total area of all elements in the model
% having the specified material label, <MatLabl>.
%
%  m_area = MODEL8_area(PTS,ELE, MatLabl);
% 
% ----------------------------------------------------------------------

m_area = 0.0;                       % Initialise the output.
Nele4 = size(ELE,1);
for iele4 = 1:Nele4
    if ELE(iele4,9) == 4
        if ELE(iele4,10) == MatLabl
          Indx = ELE(iele4,1:8);
          Node_X = PTS(Indx,2);
          Node_Y = PTS(Indx,3);
          area_t = ele8_area(Node_X,Node_Y);
          m_area = m_area + area_t;
        end
    end
end