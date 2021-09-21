function plotOrientationConfidence()

%function is loading the datastore (modelfitparamssims) and dataset
%(behaviouraldataset) from the cwd. 

load('newBehaviouralBins.mat');  
loadedData = newBehaviouralBins;
DataSet = loadedData.DataSet; 

loadedModels = load('DataStore.mat'); %load the datastore output from the runModelBasedSimulation file
DataStore = loadedModels.DataStore;
%% modelled
XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials)  mean(Data.binnedConfidence(inclTrials));
YVars.NumBins = 'prebinned';

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.numGabors == 1;
Series(2).FindIncludedTrials = @(Data)   Data.numGabors == 2; 

PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';

PlotStyle.Data(1).Name = 'Behavioural: 1 Gabor';
PlotStyle.Data(1).PlotType = 'errorShading';
PlotStyle.Data(2).Name = 'Behavioural: 2 Gabor';
PlotStyle.Data(2).PlotType = 'errorShading';

figHandle1 = mT_plotVariableRelations(DataStore{2,1}, XVars, YVars, Series,  PlotStyle);
%% behavioural 

XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials)  mean(Data.newBinnedConfidence(inclTrials));
YVars.NumBins = 'prebinned';

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.numGabors == 1;
Series(2).FindIncludedTrials = @(Data)   Data.numGabors == 2; 

PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';

PlotStyle.Data(1).Name = 'Behavioural: 1 Gabor';
PlotStyle.Data(1).PlotType = 'line';
PlotStyle.Data(2).Name = 'Behavioural: 2 Gabor';
PlotStyle.Data(2).PlotType = 'line';

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series,  PlotStyle, figHandle1);
end