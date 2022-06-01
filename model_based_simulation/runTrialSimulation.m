function [Response] = runTrialSimulation(fixedParam, S, freeParam)
%% NOISE TO GAIN MEASURE X (PERCEPT)
%apply noise to the orientation to gain percept value
Data.Sigma_X = freeParam.sigma_X(S.index);
Data.Sigma_X = (Data.Sigma_X)';

%housekeeping to pass off to percept function
Data.ContrastLevel = S.ContrastLevel;
Data.Orientation = S.Stimulus;
Data.Percept = producePercept(Data); %calculate perceived stimulus value

% If any percepts are outside the range [-pi pi] then move them back 
%Data.Percept = vS_mapBackInRange(Data.Percept, -pi, pi);
% remove as assuming we can approximate the linear here

Response = runResponseSimulation(Data, fixedParam, S, freeParam);    
end