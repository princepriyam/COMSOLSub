function [T_stored, fx_stored ,fy_stored, fxy_stored]= RSK_tor_fxy_4m_Az_stored(Az_stored,PTS_MESH,OD_ROT,agap,ELE_STA)

    mu_O = pi*4E-7 ; % PERMEABILITY OF THE FREE SPACE

    Big_ptsN  = PTS_MESH;
    % Big_connN = [ELE_ROT; ELE_STA; ELE_AG];

    % NUMBER OF DIVISIONS IN THE AIRGAP
    TolDiv = 1024           ;
    div1   = (2.0*pi)/TolDiv ;

%     ag_R = ones(TolDiv+1,1)*(0.5*(OD_ROT)+(5/8)*(agap)+0.000001);
    ag_R = ones(TolDiv+1,1)*0.04775+0.0001;
    % ag_T = (0.0:div1:(2.0*pi)-div1)';
    ag_T = (0.0:div1:(2.0*pi))'; %size 1025

    [ag_X, ag_Y] = pol2cart(ag_T, ag_R);

    %[AGELEM,AGELEM_INDEX] = getagelems(ag_X,ag_Y,Big_ptsN,ELE_STA);
    [AGELEM,AGELEM_INDEX]  = getEfL(ag_X,ag_Y,Big_ptsN,ELE_STA);
    
    AGELEM
    
    AGELEM_INDEX
    
   
    
%     figure(6)
%     iopt = 0;
%     iok = Drawplt_4(PTS_STA, AGELEM, iopt);
%     
%      pause

    [ag_T1, ag_R] = cart2pol(ag_X, ag_Y);

    T_count = size(Az_stored,2);
    T_stored = zeros(1,T_count);
    fx_stored = zeros(1,T_count);
    fy_stored = zeros(1,T_count);
    fxy_stored = zeros(1,T_count);
    
%%%% INTERGRATION IS DONE USING SIMPSON'S RULE %%%%%%%%%%%
NN = TolDiv/2 ;
Weights          = ones(NN*2+1,1)*2 ;
Weights(2:2:2*NN)= Weights(2:2:2*NN)*2 ;
Weights(1)       = 1 ;
Weights(NN*2+1)  = 1 ;
Weights = Weights/3.0 ;    % size 1025*1 = [ 1 4 2 4 ..... 4 1]
del_s = (0.5*OD_ROT*pi)/NN ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    ii = 1;
    

    for loop_t=1:T_count
    
         
        Az = Az_stored(:,loop_t);


        [Bx, By, BM]  = getBxByQ8(AGELEM,Big_ptsN,Az,ag_X,ag_Y);
  
        BN =      Bx.*cos(ag_T) + By.*sin(ag_T) ; %size(BN)= 1025
        BT = (-1)*Bx.*sin(ag_T) + By.*cos(ag_T) ;
        
  
    % figure(7)
    % plot(ag_T, BN, 'LineWidth', 2)
    % grid on
    % xlabel('Angles in radian ','FontSize', 14);
    % ylabel('Normal Component of Flux Density (in Tesla)','FontSize', 14)
    % 
    % figure(8)
    % plot(ag_T, BT, 'LineWidth', 2)
    % grid on
    % xlabel('Angles in radian ','FontSize', 14);
    % ylabel('Tangential Component of Flux Density (in Tesla)','FontSize', 14)

    % save agindex AGELEM AGELEM_INDEX

    % CALCULATION OF NORMAL FORCE



        Sigma_rr = (BN.*BN-BT.*BT)/(2*mu_O)  ;%radial stress= (br2-bn2)/2muo
        Tau_rt = (2.0*BN.*BT)/(2*mu_O)  ;

        Sigma_rr_sin = Sigma_rr.*sin(ag_T) ;
        Sigma_rr_cos = Sigma_rr.*cos(ag_T) ;

        Tau_rt_sin = Tau_rt.*sin(ag_T) ;
        Tau_rt_cos = Tau_rt.*cos(ag_T) ;

        %Frefx = sum((Sigma_rr_cos-Tau_rt_sin).*Weights)*del_s*OD_ROT*0.5 ;
        Frefx = sum((Sigma_rr_cos-Tau_rt_sin).*Weights)*del_s;
        %Frefy = sum((Sigma_rr_sin+Tau_rt_cos).*Weights)*del_s*OD_ROT*0.5 ;
        Frefy = sum((Sigma_rr_sin+Tau_rt_cos).*Weights)*del_s;

        FN = sum(Sigma_rr.*Weights)*del_s; 
        FT = sum(Tau_rt.*Weights)*del_s;
        T_ag = FT*0.5*(OD_ROT);
        T_stored(1,loop_t) = (T_ag);
        fxy = sqrt(Frefx*Frefx + Frefy*Frefy);
        %FNT = sqrt(FN*FN+FT*FT);
        
        %fxy_stored(1,loop_t) = fxy;
        fxy_stored(1,loop_t) = fxy;
        fx_stored(1,loop_t) = Frefx;
        fy_stored(1,loop_t) = Frefy;
    end