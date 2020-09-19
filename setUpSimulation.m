function setUpSimulation
%CREATE THETA VECTOR OF PARAMETER VALUES

%Key values and terms
%set fixed params 
fixedParam.mu_cat1 = (1/16).*(pi);
fixedParam.mu_cat2 = (-1/16).*(pi);
fixedParam.kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
fixedParam.sigma_s = sqrt(1/7);
fixedParam.contrasts = [0.1, 0.2, 0.3, 0.4, 0.8]; %external noise
fixedParam.prior = 0.5; %assume neutral prior for symmetry of decisions


%set free params
freeParam.lapseRate = 0.2;
freeParam.sigma_X = [1, 1.25, 1.5, 1.75, 2;
       1.1, 1.35, 1.6, 1.85, 2.1]; %internal noise that is contrast and numGabor dependent FLIP THIS UP
freeParam.metacogNoise = 0.1; 
freeParam.thresh = {0.1 : 0.1: 1}; 


%%
%CREATE S THE STIMULUS MATRIX
S.nTrials = 100; % number of trials simulated

%ORIENTATION STIMULUS VALUES PER CATEGORY
%set two target categories randomly across nTrials
S.Target =  logical(randi([0 1], S.nTrials, 1)); %the category that should be targetted (correct cat) 0 = cat 1, 1 = cat 2
%create a stimulus value for each trial based on the target
S.Stimulus = produceOrientations(S.nTrials, fixedParam.mu_cat1, fixedParam.mu_cat2, fixedParam.kappa_s, S.Target); %this is the vector of stimulus values

%NUMBER OF GABORS PER TRIAL
%split an ABBA pattern, here A is 1 Gabor, and B is 2  
S.numGabor = zeros(S.nTrials,1);
for iTrial = 1:S.nTrials
    if iTrial < .25*S.nTrials
       S.numGabor(iTrial, 1)= 1;
    elseif iTrial > .75*S.nTrials 
        S.numGabor(iTrial, 1) = 1;
    else
       S.numGabor(iTrial, 1) = 2;
    end
end

% %VISUAL CONTRAST LEVEL PER TRIAL 
S.ContrastLevel = zeros(S.nTrials, 1);
% S.SigmaX = zeros(nTrials, 1);
for iTrial = 1:S.nTrials
    S.indexofInterest = randperm(5,1);
    S.ContrastLevel(iTrial,1) = fixedParam.contrasts(S.indexofInterest);
end

%% Establish block types and models %%CONSIDER MOVE INSIDE RUNSIMULATION
model.ModelFitOptions = [1, 2, 3, 4]; % we have 4 models to choose from 
model.ModelFit = S.ModelFitOptions(1); %input model type HERE

%set block type
for iTrial = 1:S.nTrials
    if S.numGabor(iTrial) == 1
        S.BlockType(iTrial,1) = 0;
    else
        S.BlockType(iTrial,1) = 1;
    end
end

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
S.ModelType = model.ModelType;

%label four potential model fits within data struct
if model.ModelFit ==1
 S.model  = 'normativeGenerative'; %easy being Rule, hard being BAyes
elseif S.ModelFit == 2
 S.model =  'normativeGenerativeAlways'; %always Bayes
elseif S.ModelFit == 3 
 S.model = 'alternativeGenerative' ; %easy as BAyes, hard being rule
elseif S.ModelFit == 4
 S.model = 'alternativeGenerativeAlways';%always rule based
end

currentModel = S.model;

likelihoodMatrix = runSimulation(fixedParam, S, freeParam, model);

