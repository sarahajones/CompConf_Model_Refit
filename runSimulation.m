function Data = runSimulation(fixedParam, S, freeParam, currentModel)
%% NOISE TO GAIN MEASURE X (PERCEPT)
%apply noise to the orientation to gain percept value
for iTrial = 1:S.nTrials
    if S.numGabor == 1
       Data.Sigma_X(iTrial,1) = freeParam.sigma_X(1, S.indexofInterest);
    else
       Data.Sigma_X(iTrial,1) = freeParam.sigma_X(2, S.indexofInterest);
    end
end
%housekeeping to pass off to percept function
Data.ContrastLevel = S.ContrastLevel;
Data.Orientation = S.Stimulus;
Data.Percept = producePercept(S.nTrials, Data); %calculate perceived stimulus value

% If any percepts are outside the range [-pi pi] then move them back 
Data.Percept = vS_mapBackInRange(Data.Percept, -pi, pi);

%% COMPUTE DECISION / RESPONSE
%BASED ON FULL LOGLIKLIHOOD RATIO, simple rule amounts to the same thing:
%because the categories are symmetrical and prior is 0.5.
Data.Decision = giveResp(S.nTrials, Data, fixedParam.mu_cat2, fixedParam.mu_cat1, fixedParam.prior);

%% CONFIDENCE
%calculate confidence value for each trail based on model type and decision
%made by the observer based on their percept. 
%%insert metacognitive noise on the confidence 
Data.ModelType = S.ModelType;
Data.metacognitiveNoise = freeParam.metacogNoise;
Data.Confidence = computeConfidence(S.nTrials, Data,  fixedParam.sigma_s, fixedParam.mu_cat1);


%% prep DATA.STRUCT for binning
%%USE THE THRESHHOLDS (NEED DISCRETE VARIABLE)   

Data.numBins = 10;
Data.quantileSize = 1 / Data.numBins;
Data.pDivisions = 0 : Data. quantileSize : 1;

breaks = quantile(Data.Confidence, Data.pDivisions);
Data.binnedConfidence = discretize(Data.Confidence, breaks);

    
end