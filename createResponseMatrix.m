function ResponseMatrix = createResponseMatrix (ParticipantNum, DataSet)


iParticipant = ParticipantNum; %Choose Participant 

%use quantiles on raw confidnece within individual
 for jTrial = 1:2520 
     
             confidence(jTrial) = DataSet.DataSet.P(iParticipant).Data.Confidence(jTrial, 1);
 end
 
numBins = 4 ;
quantileSize = 1 / numBins;
pDivisions = 0 : quantileSize : 1;
breaks = quantile(confidence, pDivisions);
binnedConfidence = discretize(confidence, breaks);

 
%loop through different stimulus features
    for kResponseFeature = 1:2
%loop through 2520 trials
confidence = zeros(2520, 1);
        for jTrial = 1:2520 
            if kResponseFeature == 1            
%add Decision
                ResponseMatrix(jTrial, kResponseFeature) = DataSet.DataSet.P(iParticipant).Data.Decision(jTrial, 1);         
            
%addd Binned Confidence
            elseif kResponseFeature == 2
              
                 
                %binnedConfidence = here;
                ResponseMatrix(jTrial, kResponseFeature) = binnedConfidence(jTrial);
            end
        end
    end
end
