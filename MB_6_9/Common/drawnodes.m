   function iok = drawnodes(points, elems, iopt);
% --- drawplt ---
% Function for drawing a 2D mesh of straight-sided quadrilateral elements.
% <points>   ...   An array (<NPT> 	x 3) containing LABEL, X_coord, Y_coord.
% <elems>    ...   An array (<NELE> x 4) containing 4 node labels per element.
% <bound>    ...   An array (<NBND> x 2) containing 2 node labels per boundary segment.
% <specpt>   ...   An array (<NSPT> x 1) containing labels of nodes to be circled.
% ------------------------------------------------------------------------

axis('equal'); axis('off');

hold on

nele=size(elems,1); 
for iele=1:nele;
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
   
   plot(xt1,yt1,'rO'); 
   plot(xt2,yt2,'rO'); 
   plot(xt3,yt3,'rO'); 
   plot(xt4,yt4,'rO'); 
   plot(xt5,yt5,'rO'); 
   plot(xt6,yt6,'rO'); 
   plot(xt7,yt7,'rO'); 
   plot(xt8,yt8,'rO'); 
end

hold off
iok = 0;