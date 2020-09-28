 function response = passSimulation (freeParams, designMatrix)

%vector of free params
% {lapse_rate, 10x sigma_X (5x2), metaCognoise, 10x thresh}
%this needs converting to a data structure space 
%take vector of params splice into parts of the data struct 
freeParam.lapseRate = freeParams(1);
freeParam.sigma_X = [freeParams(2), freeParams(3),freeParams(4),freeParams(5),freeParams(6);
    freeParams(7),freeParams(8), freeParams(9),freeParams(10)];

freeParam.metacogNoise = freeParams(11);
for i = 12:21
freeParam.thresh(i-11) = freeParams(i);
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



%OUT
%matrix of responses and confidence
response = runTrialSimulation;
end