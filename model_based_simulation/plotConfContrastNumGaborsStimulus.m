function plotConfContrastNumGaborsStimulus()

%function is loading the datastore (modelfitparamssims) and dataset
%(behaviouraldataset) from the cwd. 

%load('newBehaviouralBins.mat');  
%loadedData = newBehaviouralBins;
%DataSet = loadedData.DataSet; 
load('DataSet1.mat');  
loadedData = DataSet1;
DataSet = loadedData; 

loadedModels = load('DataStore.mat'); %load the datastore output from the runModelBasedSimulation file
DataStore = loadedModels.DataStore;

%% modelled
XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) mean(Data.binnedConfidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)    Data.ContrastLevel == 0.8;
Series(2).FindIncludedTrials = @(Data)    Data.ContrastLevel == 0.4;
Series(3).FindIncludedTrials = @(Data)    Data.ContrastLevel == 0.3;
Series(4).FindIncludedTrials = @(Data)    Data.ContrastLevel == 0.2;
Series(5).FindIncludedTrials = @(Data)    Data.ContrastLevel == 0.1;


PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';

PlotStyle.Data(1).Name = 'Contrast = 0.8';
PlotStyle.Data(1).PlotType = 'errorShading';

PlotStyle.Data(2).Name = 'Contrast = 0.4';
PlotStyle.Data(2).PlotType = 'errorShading';

PlotStyle.Data(3).Name = 'Contrast = 0.3';
PlotStyle.Data(3).PlotType = 'errorShading';

PlotStyle.Data(4).Name = 'Contrast = 0.2';
PlotStyle.Data(4).PlotType = 'errorShading';

PlotStyle.Data(5).Name = 'Contrast = 0.1';
PlotStyle.Data(5).PlotType = 'errorShading';

figHandle1 = mT_plotVariableRelations(DataStore{2,1}, XVars, YVars, Series, PlotStyle);
%% behavioural 

XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) mean(Data.newBinnedConfidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.ContrastLevel == 0.8;
Series(2).FindIncludedTrials = @(Data)   Data.ContrastLevel == 0.4;
Series(3).FindIncludedTrials = @(Data)   Data.ContrastLevel == 0.3;
Series(4).FindIncludedTrials = @(Data)   Data.ContrastLevel == 0.2;
Series(5).FindIncludedTrials = @(Data)   Data.ContrastLevel == 0.1;


PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';

PlotStyle.Data(1).Name = 'Contrast = 0.8';
PlotStyle.Data(1).PlotType = 'line';

PlotStyle.Data(2).Name = 'Contrast = 0.4';
PlotStyle.Data(2).PlotType = 'line';

PlotStyle.Data(3).Name = 'Contrast = 0.3';
PlotStyle.Data(3).PlotType = 'line';

PlotStyle.Data(4).Name = 'Contrast = 0.2';
PlotStyle.Data(4).PlotType = 'line';

PlotStyle.Data(5).Name = 'Contrast = 0.1';
PlotStyle.Data(5).PlotType = 'line';

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle, figHandle1);

end