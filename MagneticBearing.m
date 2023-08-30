clc
clear all


model = mphopen('AMB.mph','Model');
% mphlaunch()
parameters = model.param.varnames;
variables = model.variable.tags;
data = model.result.dataset.tags; 
solutions = model.sol.tags;
ftag = model.physics('mf').feature.tags;
% normB = mphinterp(model, 'normB', 'coord',[0.10 0.10]', 'dataset', 'dset1');  % Replace 'dset1' with the actual dataset tag
[t, Bx] = mphinterp(model, {'t','mf.Bx'},'coord',[0.01; 0.01], 'dataset', 'dset1');  % Replace 'mf' and 'dset1' with the correct physics and dataset tags
By = mphinterp(model, 'mf.By','coord',[0.01; 0.01], 'dataset', 'dset1');
% Bz = mphinterp(model, 'mf.Bz','coord',[0.1; 0.1], 'dataset', 'dset1');
normB = sqrt(Bx.^2 + By.^2 );
Fx = mphinterp(model, 'mf.Forcex_0','coord',[16; 16], 'dataset', 'dset1');
Fy = mphinterp(model, 'mf.Forcey_0','coord',[16; 16], 'dataset', 'dset1');

theta = atan(Fy./Fx);
rho  = sqrt(Fx.^2 + Fy.^2);
% 
% CoiFlux = mphinterp(model, 'mf.PhiCoil_1','coord',[0.01; 0.01], 'dataset', 'dset1');
% 
% figure(1)
% hold on
% plot(t,normB)
% plot(t,Bx)
% plot(t,By)
% hold off

% figure(2)
% hold on
% plot(t,Fx)
% plot(t,Fy)
% hold off


figure(3)
% polarplot(theta,rho)

for i = 1:5
    polarplot(Fy((75+ 100*(i-1)):(75 + 100*(i))),Fx((75+ 100*(i-1)):(75 + 100*(i))))
end

fileID = fopen('ForceData.txt','w');
fprintf(fileID,'%6.2f %12.8f\n',Fx , Fy);
fclose(fileID); 

% figure(4)
% plot(t,CoiFlux)
% model.sol('std2').runAll();
% 
% B = mphinterp(model, 'B', 'dataset', 'dset1');  % Get magnetic flux density
% F = mphinterp(model, 'F', 'dataset', 'dset1');  % Get force component

