function Response = runResponseSimulation(Data, fixedParam, S, freeParam)
%% DECISION make decision / give response
Response.Decision = giveResp(S.nTrials, Data, fixedParam.mu_cat2, fixedParam.mu_cat1, fixedParam.prior, freeParam.lapseRate);
%Response.Decision = randi([0 1], length(Response.Decision), 1);

%% CONFIDENCE calculate confidence value for each trial 
Data.metacognitiveNoise = freeParam.metacogNoise;
Response.Confidence = computeConfidence(S.nTrials, Data,  fixedParam.sigma_s, fixedParam.mu_cat1, Response.Decision, S.modelType);

freeParam.thresh = sort(freeParam.thresh);
freeParam.thresh = [0, freeParam.thresh, 1];
Response.binnedConfidence = discretize(Response.Confidence,  freeParam.thresh);

%overwrite some confidence reports with a random confidence report
lapse = (rand(1, S.nTrials))';
vector1 = lapse < freeParam.confLapse; %theses trials should be lapses
Response.binnedConfidence(vector1) = randi(2, sum(vector1), 1); 

end
