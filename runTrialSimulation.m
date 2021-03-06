function [Response] = runTrialSimulation(fixedParam, S, freeParam)
%% NOISE TO GAIN MEASURE X (PERCEPT)
%apply noise to the orientation to gain percept value
S.indexofInterest = Ranint(S.nTrials, 5);
Indices = (sub2ind(size(freeParam.sigma_X), S.numGabor, S.indexofInterest));
Data.Sigma_X = freeParam.sigma_X(Indices);

%housekeeping to pass off to percept function
Data.ContrastLevel = S.ContrastLevel;
Data.Orientation = S.Stimulus;
Data.Percept = producePercept(Data); %calculate perceived stimulus value

% If any percepts are outside the range [-pi pi] then move them back 
Data.Percept = vS_mapBackInRange(Data.Percept, -pi, pi);

Response = runResponseSimulation(Data, fixedParam, S, freeParam);    
end