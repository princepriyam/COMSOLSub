   function iok = Drawplt_4(points, elems, iopt);
% --- drawplt ---
% Function for drawing a 2D mesh of straight-sided quadrilateral elements.
% <points>   ...   An array (<NPT> 	x 3)  containing LABEL, X_coord, Y_coord.
% <elems>    ...   An array (<NELE> x 4) containing 4 node labels per element.
% <bound>    ...   An array (<NBND> x 2) containing 2 node labels per boundary segment.
% <specpt>   ...   An array (<NSPT> x 1) containing labels of nodes to be circled.
% ------------------------------------------------------------------------


%clf;
axis('equal'); axis('off');

hold on
if iopt>0, plot(points(:,2),points(:,3),'b-'), end;

nele=size(elems,1); 
for iele=1:nele;
   if(elems(iele, 11) == 64) 
   labl_nod_1 = elems(iele,1);     [junk,indx_nod_1] = min(abs( points(:,1)-labl_nod_1 ));
   xt1=points(indx_nod_1,2);       yt1=points(indx_nod_1,3);
   labl_nod_2 = elems(iele,2);     [junk,indx_nod_2] = min(abs( points(:,1)-labl_nod_2 ));
   xt2=points(indx_nod_2,2);       yt2=points(indx_nod_2,3);
   labl_nod_3 = elems(iele,3);     [junk,indx_nod_3] = min(abs( points(:,1)-labl_nod_3 ));
   xt3=points(indx_nod_3,2);       yt3=points(indx_nod_3,3);
   labl_nod_4 = elems(iele,4);     [junk,indx_nod_4] = min(abs( points(:,1)-labl_nod_4 ));
   xt4=points(indx_nod_4,2);       yt4=points(indx_nod_4,3);
   labl_nod_5 = elems(iele,5);     [junk,indx_nod_5] = min(abs( points(:,1)-labl_nod_5 ));
   xt5=points(indx_nod_5,2);       yt5=points(indx_nod_5,3);
   labl_nod_6 = elems(iele,6);     [junk,indx_nod_6] = min(abs( points(:,1)-labl_nod_6 ));
   xt6=points(indx_nod_6,2);       yt6=points(indx_nod_6,3);
   labl_nod_7 = elems(iele,7);     [junk,indx_nod_7] = min(abs( points(:,1)-labl_nod_7 ));
   xt7=points(indx_nod_7,2);       yt7=points(indx_nod_7,3);
   labl_nod_8 = elems(iele,8);     [junk,indx_nod_8] = min(abs( points(:,1)-labl_nod_8 ));
   xt8=points(indx_nod_8,2);       yt8=points(indx_nod_8,3);
   
   if(elems(iele, 9) == 3)
     plot([xt1; xt5], [yt1; yt5], 'b-');
     plot([xt5; xt2], [yt5; yt2], 'b-');
     plot([xt2; xt6], [yt2; yt6], 'b-');
     plot([xt6; xt3], [yt6; yt3], 'b-');
     plot([xt3; xt7], [yt3; yt7], 'b-');
     plot([xt7; xt4], [yt7; yt4], 'b-');
     plot([xt4; xt8], [yt4; yt8], 'b-');
     plot([xt8; xt1], [yt8; yt1], 'b-');
   elseif((elems(iele, 9) == 4)|(elems(iele, 9) == 5))
     plot([xt1; xt5], [yt1; yt5], 'r-');
     plot([xt5; xt2], [yt5; yt2], 'r-');
     plot([xt2; xt6], [yt2; yt6], 'r-');
     plot([xt6; xt3], [yt6; yt3], 'r-');
     plot([xt3; xt7], [yt3; yt7], 'r-');
     plot([xt7; xt4], [yt7; yt4], 'r-');
     plot([xt4; xt8], [yt4; yt8], 'r-');
     plot([xt8; xt1], [yt8; yt1], 'r-');
   elseif((elems(iele, 9) == 6)|(elems(iele, 9) == 7))
     plot([xt1; xt5], [yt1; yt5], 'c-');
     plot([xt5; xt2], [yt5; yt2], 'c-');
     plot([xt2; xt6], [yt2; yt6], 'c-');
     plot([xt6; xt3], [yt6; yt3], 'c-');
     plot([xt3; xt7], [yt3; yt7], 'c-');
     plot([xt7; xt4], [yt7; yt4], 'c-');
     plot([xt4; xt8], [yt4; yt8], 'c-');
     plot([xt8; xt1], [yt8; yt1], 'c-');
   elseif((elems(iele, 9) == 8)|(elems(iele, 9) == 9))
     plot([xt1; xt5], [yt1; yt5], 'm-');
     plot([xt5; xt2], [yt5; yt2], 'm-');
     plot([xt2; xt6], [yt2; yt6], 'm-');
     plot([xt6; xt3], [yt6; yt3], 'm-');
     plot([xt3; xt7], [yt3; yt7], 'm-');
     plot([xt7; xt4], [yt7; yt4], 'm-');
     plot([xt4; xt8], [yt4; yt8], 'm-');
     plot([xt8; xt1], [yt8; yt1], 'm-');
   else
     plot([xt1; xt5], [yt1; yt5], 'g-');
     plot([xt5; xt2], [yt5; yt2], 'g-');
     plot([xt2; xt6], [yt2; yt6], 'g-');
     plot([xt6; xt3], [yt6; yt3], 'g-');
     plot([xt3; xt7], [yt3; yt7], 'g-');
     plot([xt7; xt4], [yt7; yt4], 'g-');
     plot([xt4; xt8], [yt4; yt8], 'g-');
     plot([xt8; xt1], [yt8; yt1], 'g-');
   end  
   else
       labl_nod_1 = elems(iele,1);     [junk,indx_nod_1] = min(abs( points(:,1)-labl_nod_1 ));
       xt1=points(indx_nod_1,2);       yt1=points(indx_nod_1,3);
       labl_nod_2 = elems(iele,2);     [junk,indx_nod_2] = min(abs( points(:,1)-labl_nod_2 ));
       xt2=points(indx_nod_2,2);       yt2=points(indx_nod_2,3);
       labl_nod_3 = elems(iele,3);     [junk,indx_nod_3] = min(abs( points(:,1)-labl_nod_3 ));
       xt3=points(indx_nod_3,2);       yt3=points(indx_nod_3,3);
       labl_nod_4 = elems(iele,4);     [junk,indx_nod_4] = min(abs( points(:,1)-labl_nod_4 ));
       xt4=points(indx_nod_4,2);       yt4=points(indx_nod_4,3);
       labl_nod_5 = elems(iele,5);     [junk,indx_nod_5] = min(abs( points(:,1)-labl_nod_5 ));
       xt5=points(indx_nod_5,2);       yt5=points(indx_nod_5,3);
       labl_nod_6 = elems(iele,6);     [junk,indx_nod_6] = min(abs( points(:,1)-labl_nod_6 ));
       xt6=points(indx_nod_6,2);       yt6=points(indx_nod_6,3);
       if(elems(iele, 9) == 3)
          plot([xt1; xt4], [yt1; yt4], 'b-');
          plot([xt4; xt2], [yt4; yt2], 'b-');
          plot([xt2; xt5], [yt2; yt5], 'b-');
          plot([xt5; xt3], [yt5; yt3], 'b-');
          plot([xt3; xt6], [yt3; yt6], 'b-');
          plot([xt6; xt1], [yt6; yt1], 'b-');          
       elseif((elems(iele, 9) == 4)|(elems(iele, 9) == 5))
          plot([xt1; xt4], [yt1; yt4], 'r-');
          plot([xt4; xt2], [yt4; yt2], 'r-');
          plot([xt2; xt5], [yt2; yt5], 'r-');
          plot([xt5; xt3], [yt5; yt3], 'r-');
          plot([xt3; xt6], [yt3; yt6], 'r-');
          plot([xt6; xt1], [yt6; yt1], 'r-');          
       elseif((elems(iele, 9) == 6)|(elems(iele, 9) == 7))
          plot([xt1; xt4], [yt1; yt4], 'c-');
          plot([xt4; xt2], [yt4; yt2], 'c-');
          plot([xt2; xt5], [yt2; yt5], 'c-');
          plot([xt5; xt3], [yt5; yt3], 'c-');
          plot([xt3; xt6], [yt3; yt6], 'c-');
          plot([xt6; xt1], [yt6; yt1], 'c-'); 
       elseif((elems(iele, 9) == 8)|(elems(iele, 9) == 9))
          plot([xt1; xt5], [yt1; yt5], 'm-');
          plot([xt5; xt2], [yt5; yt2], 'm-');
          plot([xt2; xt6], [yt2; yt6], 'm-');
          plot([xt6; xt3], [yt6; yt3], 'm-');
          plot([xt3; xt7], [yt3; yt7], 'm-');
          plot([xt7; xt4], [yt7; yt4], 'm-');
          plot([xt4; xt8], [yt4; yt8], 'm-');
          plot([xt8; xt1], [yt8; yt1], 'm-');
       else
          plot([xt1; xt4], [yt1; yt4], 'g-');
          plot([xt4; xt2], [yt4; yt2], 'g-');
          plot([xt2; xt5], [yt2; yt5], 'g-');
          plot([xt5; xt3], [yt5; yt3], 'g-');
          plot([xt3; xt6], [yt3; yt6], 'g-');
          plot([xt6; xt1], [yt6; yt1], 'g-');
       end 
   end
end

hold off
iok = 0;