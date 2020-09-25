function simulation = setUpSimulation
%% CHOOSE THE MODEL 
S.Model = 1; %CHOOSE MODEL 1, 2, 3, 4

%% CREATE THETA VECTOR OF PARAMETER VALUES
%Key values and terms
%set fixed params 
fixedParam.mu_cat1 = (1/16).*(pi);
fixedParam.mu_cat2 = (-1/16).*(pi);
fixedParam.kappa_s = 7;%%kappa (concentration parameter, needs to be convereted for derivations to sigma)
fixedParam.sigma_s = sqrt(1/7);
fixedParam.contrasts = [0.1, 0.2, 0.3, 0.4, 0.8]; %external noise
fixedParam.prior = 0.5; %assume neutral prior for symmetry of decisions

%set free params
%freeParam.lapseRate = 0.2;
%freeParam.sigma_X = [1, 1.25, 1.5, 1.75, 2;
%      1.1, 1.35, 1.6, 1.85, 2.1]; %internal noise that is contrast and numGabor dependent FLIP THIS UP
%freeParam.metacogNoise = 0.1; 
%freeParam.thresh = {0.1 : 0.1: 1}; 

%% CREATE S THE STIMULUS MATRIX
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

simulation = runTrialSimulation(fixedParam, S, freeParam);
