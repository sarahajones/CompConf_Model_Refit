function ResponseMatrix = createResponseMatrix (ParticipantNum)

%load in the behavioural data file

load('BehaviouralDataSet_analysed.mat');

iParticipant = ParticipantNum; %Choose Participant 
%loop through different stimulus features
    for kResponseFeature = 1:2
%loop through 2520 trials
        for jTrial = 1:2520 
            if kResponseFeature == 1            
%add Decision
                ResponseMatrix(jTrial, kResponseFeature) = DataSet.P(iParticipant).Data.Decision(jTrial, 1);         
            
%addd Binned Confidence
            elseif kResponseFeature == 2
                ResponseMatrix(jTrial, kResponseFeature) = DataSet.P(iParticipant).Data.binnedConfidence(jTrial, 1);
            end
        end
    end
end
