function Data = runTrialSimulation(fixedParam, S, freeParam)
%% Establish models 
model.ModelFitOptions = [1, 2, 3, 4]; % we have 4 models to choose from 
model.ModelFit = model.ModelFitOptions(S.model); %input model type HERE

%choose model type (alt or norm) for each block based on model fit (1:4)
for iTrial = 1:S.nTrials
    if model.ModelFit == 1
        if S.BlockType(iTrial,1) == 1
            model.ModelType(iTrial,1) = 1; %alternative for 2 gabors
        else
            model.ModelType(iTrial,1) = 0; %normative for 1 gabor
        end
    elseif model.ModelFit == 2
        model.ModelType(iTrial,1) = 0; %always normative
    elseif mdoel.ModelFit == 3
         if S.BlockType(iTrial,1) == 1
            model.ModelType(iTrial,1) = 0; %normative for 2 gabors
        else
            model.ModelType(iTrial,1) = 1; %alternative for one
         end
    elseif model.ModelFit == 4
        model.ModelType(iTrial,1) = 1; %always alternative 

    end
end


%label four potential model fits within data struct
if model.ModelFit ==1
 model.modelName  = 'normativeGenerative'; %easy being Rule, hard being BAyes
elseif S.ModelFit == 2
 model.modelName =  'normativeGenerativeAlways'; %always Bayes
elseif S.ModelFit == 3 
 model.modelName = 'alternativeGenerative' ; %easy as BAyes, hard being rule
elseif S.ModelFit == 4
 model.modelName = 'alternativeGenerativeAlways';%always rule based
end

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