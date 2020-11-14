function ResponseMatrix = createResponseMatrix (ParticipantNum, DataSet)

%rebin confidence using quantiles on raw confidence within individual
confidence = DataSet.DataSet.P(ParticipantNum).Data.Confidence;
pDivisions = 0 : 0.25 : 1;
breaks = quantile(confidence, pDivisions);
binnedConfidence = discretize(confidence, breaks);

ResponseMatrix(:, 1) = DataSet.DataSet.P(ParticipantNum).Data.Decision;
ResponseMatrix(:, 2) = binnedConfidence;

end
