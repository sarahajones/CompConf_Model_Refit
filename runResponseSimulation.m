function Response = runResponseSimulation(Data, fixedParam, S, freeParam, model)
%% COMPUTE DECISION / RESPONSE
%BASED ON FULL LOGLIKLIHOOD RATIO, simple rule amounts to the same thing:
%because the categories are symmetrical and prior is 0.5.
Response.Decision = giveResp(S.nTrials, Data, fixedParam.mu_cat2, fixedParam.mu_cat1, fixedParam.prior);

%% CONFIDENCE
%calculate confidence value for each trail based on model type and decision
%made by the observer based on their percept. 
%%insert metacognitive noise on the confidence 
Data.metacognitiveNoise = freeParam.metacogNoise;
Response.Confidence = computeConfidence(S.nTrials, Data,  fixedParam.sigma_s, fixedParam.mu_cat1, Response.Decision, model.ModelType);


%% prep DATA.STRUCT for binning
%%USE THE THRESHHOLDS (NEED DISCRETE VARIABLE)   

Data.pDivisions = cell2mat(freeParam.thresh);

breaks = quantile(Response.Confidence, Data.pDivisions);
Response.binnedConfidence = discretize(Response.Confidence, breaks);


end
