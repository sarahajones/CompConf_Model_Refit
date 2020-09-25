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
%Target, Stimulus, numGabor, ContrastLevel, 


%VISUAL CONTRAST LEVEL PER TRIAL 
S.ContrastLevel = zeros(S.nTrials, 1);
for iTrial = 1:S.nTrials
    S.indexofInterest(iTrial,1) = randperm(5,1);
    S.ContrastLevel(iTrial,1) = fixedParam.contrasts(S.indexofInterest(iTrial,1));
end

%set block type
for iTrial = 1:S.nTrials
    if S.numGabor(iTrial) == 1
        S.BlockType(iTrial,1) = 0; 
    else
        S.BlockType(iTrial,1) = 1;
    end
end


%OUT
%matrix of responses and confidence

end