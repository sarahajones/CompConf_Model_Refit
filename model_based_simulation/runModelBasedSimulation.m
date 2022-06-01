%running model based simulations using best fits from IBSBADs fitting
%use to generate datasets for each model based on best fitting param values
%these datasets can be passed on for plotting. 

data = load('BehaviouralDataSet_analysed.mat');
bestFits = load('bestFits_retest.mat'); %make sure this is the corresponding BestFits

for iParticipant = 1:13
    for jModel = 1:4
        S = createStimulusMatrix(jModel, iParticipant, data); 
        freeParams(:, 1) = bestFits.bestFits(iParticipant, (1 +((jModel*17)- 17)):((jModel*17)-1)); %change values here based on dimensions (i.e 17 changes with free param dimensions)
        result = passSimulation(freeParams, S);

        ModelSim(jModel).P(iParticipant).Data.nTrial = length(S(:,1));
        ModelSim(jModel).P(iParticipant).Data.numGabors = S(:,1);
        ModelSim(jModel).P(iParticipant).Data.Orientation = S(:,2);
        ModelSim(jModel).P(iParticipant).Data.ContrastLevel = S(:,3);
        ModelSim(jModel).P(iParticipant).Data.BlockType = S(:,4);

        ModelSim(jModel).P(iParticipant).Data.Decision =result(:, 1);
        ModelSim(jModel).P(iParticipant).Data.binnedConfidence =result(:, 2);

    end
    
    confidence = data.DataSet.P(iParticipant).Data.Confidence; %rebin original confidence accordingly
    pDivisions = 0 : 0.25 : 1; %upped to 4
    breaks = quantile(confidence, pDivisions);
    data.DataSet.P(iParticipant).Data.newBinnedConfidence = discretize(confidence, breaks);
end


ModelFit1 = ModelSim(1);
ModelFit2 = ModelSim(2);
ModelFit3 = ModelSim(3);
ModelFit4 = ModelSim(4); 

%load into one struct
DataStore = cell(4,1);
DataStore{1, 1} = ModelFit1;
DataStore{2, 1} = ModelFit2;
DataStore{3, 1} = ModelFit3;
DataStore{4, 1} = ModelFit4;
save("DataStore");


newBehaviouralBins = data;
save("newBehaviouralBins");

