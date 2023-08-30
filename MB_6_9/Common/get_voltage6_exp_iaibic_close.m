function [Load_vec, Load_vec_old, Ufs]=get_voltage6_exp_iaibic_close(TIME,SUP_VOL,LEV_VOL,Load_vec,npts,SUP_FRE,LEV_FRE)

OME = 2*pi*SUP_FRE;
OMEL = 2*pi*LEV_FRE;

Load_vec_old = Load_vec;

% Ul1 = LEV_VOL*cos(OMEL*TIME) ;
% Ul2 = LEV_VOL*cos(OMEL*TIME-(2.0*pi/3.0));
% Ul3 = LEV_VOL*cos(OMEL*TIME-(4.0*pi/3.0));
% Ul2 = 0;
% Ul3 = 0;

Up1 = SUP_VOL*cos(OME*TIME)             ;
Up2 = SUP_VOL*cos(OME*TIME-(2.0*pi/3.0));
Up3 = SUP_VOL*cos(OME*TIME-(4.0*pi/3.0));


Ufs = [Up1-Up2;Up2-Up3;0;0;0;0];
% Ub = [Ul1; Ul2;Ul3]; 

% Ufs = [Up1;Up2;Up3];

%Load_vec                      = zeros(npts+6+2*SLOT_ROT,1)                   ;
Load_vec((npts+1):(npts+6),1) = Ufs; 
% Load_vec((npts+25):(npts+27),1) = Ub;