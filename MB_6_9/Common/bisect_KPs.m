function [KP_xy, c_xy] = bisect_KPs(KeyPoints,KP_Labl1,KP_Labl2,KP_Labl0)
% --- bisect_KPs ---
% This function bisects the line (or circular arc) between two existing
% KeyPoints ("corner KeyPoints") to produce a new KeyPoint which would
% obviously be a "mid-side KeyPoint". The line/arc extends between
% the KeyPoints whose labels are KP_Labl1 and KP_Labl2 and the third label
% (KP_Labl0) denotes the centre of the arc. If that is "0", a straight 
% line is assumed. That input argument can be omitted.
% 
% If the supplied centre is not equi-distant from the two end points,
% the minimum adjustment is made to fix this.
% 
% Note that the two outputs here are row-vectors with 2 entries each. 
%
% [KP_xy, c_xy] = bisect_KPs(KeyPoints,KP_Labl1,KP_Labl2,KP_Labl0)
%
% S. Garvey, September 9, 2021.
% -----------------------------------------------------------------------

if (nargin<4)           % Allow a default for the final argument. 
   KP_Labl0=0;
end

if (abs(KP_Labl0) > 0)                 % Then this is a circular arc.
   Labls = [ KP_Labl1; KP_Labl2; KP_Labl0 ];
   Indxs = findlabl( KeyPoints, Labls );
   if (min(Indxs)<0)
      disp(' ERROR trapped in <bisect_KPs> ... ');
      disp(' Not all KeyPoint labels were found in the supplied array:');
      Labels_and_Corresponding_Indices = [ Labls Indxs ]
      disp(' Please break out here : '); pause
   end
   Pts_xy = KeyPoints(Indxs,(2:3));
   % --- First adjust the supplied centre so that it is equidistant. 
   vct12  = (Pts_xy(2,:) - Pts_xy(1,:)).';  
   vctmp  = (Pts_xy(2,:) + Pts_xy(1,:)).'/2;  % Midpoint of the line.
   cntr0  =  Pts_xy(3,:).';                                % Supplied centre
   vctad  = vct12*(vct12.'*(cntr0-vctmp))/(vct12.'*vct12); % Adjustment
   cntrc  = cntr0 - vctad;                                 % Shifted centre
   % --- Now find the bisected point by extending (centre->midpt). 
   vctc1  = (Pts_xy(1,:)).' - cntrc;          % Vector from centre to pt1 
   vctc2  = (Pts_xy(2,:)).' - cntrc;          % Vector from centre to pt2
   vctcm  = vctmp - cntrc;                    % Vector from centre to midpt
   rad1   = sqrt(vctc1.'*vctc1);
   rad2   = sqrt(vctc2.'*vctc2);
   radm   = (rad1+rad2)/2;                    % The mean radius.
   tx     = sqrt(vctcm.'*vctcm);
   if (tx > 1E-6*radm)
      vctcp  = vctcm*radm/tx;
      KP_xy  = (cntrc+vctcp).';
   else
      KP_xy = (Pts_xy(1,:)+Pts_xy(2,:))/2;
   end
   c_xy   = cntrc.'; 
else                                   % Then this is a straight line.
   Labls = [ KP_Labl1; KP_Labl2 ];
   Indxs = findlabl( KeyPoints, Labls );
   if (min(Indxs)<0)
      disp(' ERROR trapped in <bisect_KPs> ... ');
      disp(' Not all KeyPoint labels were found in the supplied array:');
      Labels_and_Corresponding_Indices = [ Labls Indxs ]
      disp(' Please break out here : '); pause
   end
   Pts_xy = KeyPoints(Indxs,(2:3));
   KP_xy  = sum(Pts_xy)/2;
   c_xy   = KP_xy; 
end

end