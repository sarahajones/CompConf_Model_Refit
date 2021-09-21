 function response = passSimulation (freeParams, designMatrix)

%unpack vector of free params
freeParam.lapseRate = freeParams(1);
freeParam.sigma_X = [freeParams(2), freeParams(3), freeParams(4),freeParams(5),freeParams(6), ...
    freeParams(7),freeParams(8), freeParams(9),freeParams(10), freeParams(11)];
freeParam.metacogNoise = freeParams(12);
freeParam.confLapse = freeParams(13);

for i = 14:length(freeParams)
freeParam.thresh(i-13) = freeParams(i);
end
freeParam.thresh = sort(freeParam.thresh);

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

S.index(S.ContrastLevel == 0.8) = 1;
S.index(S.ContrastLevel == 0.4) = 2;
S.index(S.ContrastLevel == 0.3) = 3;
S.index(S.ContrastLevel == 0.2) = 4;
S.index(S.ContrastLevel == 0.1) = 5;

vector1 = S.numGabor == 2;
S.index(vector1) = S.index(vector1) + 5;
S.index = (S.index)';


%set fixed params 
fixedParam.mu_cat1 = (1/16).*(pi);
fixedParam.mu_cat2 = (-1/16).*(pi);
fixedParam.kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
fixedParam.sigma_s = sqrt(1/fixedParam.kappa_s);
fixedParam.prior = 0.5; %assume neutral prior for symmetry of decisions

%structure of responses and confidence
Response = runTrialSimulation(fixedParam, S, freeParam);

%TRANSFORM response into a Matrix
response(:, 1) = Response.Decision;
response(:, 2) = Response.binnedConfidence;

 end
 