function [Response] = runTrialSimulation(fixedParam, S, freeParam)
%% Establish models in a model struct
model.ModelFitOptions = [1, 2, 3, 4]; % we have 4 models to choose from 
model.ModelFit = model.ModelFitOptions(S.Model); %input model type from S here

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
    elseif model.ModelFit == 3
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
    indexofInterest = Ranint(1,5);
    if S.numGabor == 1
       Data.Sigma_X(iTrial,1) = freeParam.sigma_X(1, indexofInterest);
    else
       Data.Sigma_X(iTrial,1) = freeParam.sigma_X(2, indexofInterest);
    end
end
%housekeeping to pass off to percept function
Data.ContrastLevel = S.ContrastLevel;
Data.Orientation = S.Stimulus;
Data.Percept = producePercept(S.nTrials, Data); %calculate perceived stimulus value

% If any percepts are outside the range [-pi pi] then move them back 
Data.Percept = vS_mapBackInRange(Data.Percept, -pi, pi);

Response = runResponseSimulation(Data, fixedParam, S, freeParam, model);    
end