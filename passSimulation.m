 function response = passSimulation (freeParams, designMatrix)

%unpack vector of free params
freeParam.lapseRate = freeParams(1);
freeParam.sigma_X = [freeParams(2), freeParams(3), freeParams(4),freeParams(5),freeParams(6);
    freeParams(7),freeParams(8), freeParams(9),freeParams(10), freeParams(11)];
%sort(freeParam.sigma_X(1,:));
%sort(freeParam.sigma_X(2,:));
freeParam.metacogNoise = freeParams(12);

for i = 13:length(freeParams)
freeParam.thresh(i-12) = freeParams(i);
end
sort(freeParam.thresh);

%unpack design matrix 
S.Stimulus = designMatrix(:, 2);
S.nTrials = length(S.Stimulus);
S.numGabor = designMatrix(:, 1);
S.ContrastLevel = designMatrix(:, 3);
S.BlockType = designMatrix(:, 4); 
S.Model = designMatrix(1,5);

S.modelType = zeros(S.nTrials,1); %model 2 unchanged as always 0
if S.Model == 4    
    S.modelType(:,1) = 1; %always alternative 
elseif S.Model == 1
    S.modelType(S.BlockType == 1) = 1; %alternative for 2 gabor
elseif S.Model == 3
    S.modelType(S.BlockType == 0) = 1; %alternative for one
end  

%set fixed params 
fixedParam.mu_cat1 = (1/16).*(pi);
fixedParam.mu_cat2 = (-1/16).*(pi);
fixedParam.kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
fixedParam.sigma_s = sqrt(1/7);
fixedParam.contrasts = [0.1, 0.2, 0.3, 0.4, 0.8]; %external noise
fixedParam.prior = 0.5; %assume neutral prior for symmetry of decisions

%structure of responses and confidence
Response = runTrialSimulation(fixedParam, S, freeParam);

%TRANSFORM response into a Matrix
response(:, 1) = Response.Decision;
response(:, 2) = Response.binnedConfidence;

 end
 