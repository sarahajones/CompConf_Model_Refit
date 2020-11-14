function Response = runResponseSimulation(Data, fixedParam, S, freeParam)
%% DECISION make decision / give response
Response.Decision = giveResp(S.nTrials, Data, fixedParam.mu_cat2, fixedParam.mu_cat1, fixedParam.prior);

%% CONFIDENCE calculate confidence value for each trial 
Data.metacognitiveNoise = freeParam.metacogNoise;
Response.Confidence = computeConfidence(S.nTrials, Data,  fixedParam.sigma_s, fixedParam.mu_cat1, Response.Decision, S.modelType);

freeParam.thresh = sort(freeParam.thresh);
Response.binnedConfidence = discretize(Response.Confidence,  freeParam.thresh);
end
