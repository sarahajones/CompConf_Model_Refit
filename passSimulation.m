 function response = passSimulation (freeParams, designMatrix)

%vector of free params
% {lapse_rate, 10x sigma_X (5x2), metaCognoise, 10x thresh}
%this needs converting to a data structure space 
%take vector of params splice into parts of the data struct 
freeParam.lapseRate = freeParams(1);
freeParam.sigma_X = [freeParams(2), freeParams(3), freeParams(4),freeParams(5),freeParams(6);
    freeParams(7),freeParams(8), freeParams(9),freeParams(10), freeParams(11)];

freeParam.metacogNoise = freeParams(12);
for i = 13:23
freeParam.thresh(i-12) = freeParams(i);
end

%design matrix 
% needs splicing into the S data struct shape
%matrix is nTrials long,and has columns 
%nTrials, Stimulus, numGabor, ContrastLevel,Block Type 
S.nTrials = length(designMatrix);
S.Stimulus = designMatrix(:, 2);
S.numGabor = designMatrix(:, 1);
S.ContrastLevel = designMatrix(:, 3);
S.BlockType = designMatrix(:, 4); 

%Add key values and terms
%set fixed params 
fixedParam.mu_cat1 = (1/16).*(pi);
fixedParam.mu_cat2 = (-1/16).*(pi);
fixedParam.kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
fixedParam.sigma_s = sqrt(1/7);
fixedParam.contrasts = [0.1, 0.2, 0.3, 0.4, 0.8]; %external noise
fixedParam.prior = 0.5; %assume neutral prior for symmetry of decisions

%CHOOSE MODEL
%S.Model = 1;

%OUT
%structure of responses and confidence
Response = runTrialSimulation(fixedParam, S, freeParam);
%TRANSFORM
%response = MATRIX - row is trial and one column is response and 1 is binned confidence 
for i = 1: S.nTrials
    response(i, 1) = Response.Decision(i);
    response(i, 2) = Response.binnedConfidence(i);
end
 end
 