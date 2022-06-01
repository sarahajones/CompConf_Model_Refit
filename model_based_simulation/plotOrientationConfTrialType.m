%% confidence_orientation_trialtype_plot

%uses functions from mT folder to plot trial confidence (in 10 bins) against
%orientation
%split by number of gabors

%runs using code by:
% Joshua Calder-Travis, j.calder.travis@gmail.com

%adapted by:
% Sarah Ashcroft-Jones 
% sarahashjones@gmail.com
% GitHub: sarahajones


load('newBehaviouralBins.mat');  
loadedData = newBehaviouralBins;
DataSet = loadedData.DataSet; 

loadedModels = load('DataStore.mat'); %load the datastore output from the runModelBasedSimulation file
DataStore = loadedModels.DataStore;

%% modelled

XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) (Data.binnedConfidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.numGabors == 1;
Series(2).FindIncludedTrials = @(Data)   Data.numGabors == 2;



PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';


PlotStyle.Data(1).Name = 'Simple trials';
PlotStyle.Data(1).PlotType = 'scatter';

PlotStyle.Data(2).Name = 'Complex trials';
PlotStyle.Data(2).PlotType = 'scatter';

figHandle1 = mT_plotVariableRelations(DataStore{4,1}, XVars, YVars, Series, PlotStyle);
%% %% behavioural 

XVars.ProduceVar = @(Data) Data.Orientation;
XVars.NumBins = 10;

YVars.ProduceVar = @(Data, inclTrials) (Data.Confidence(inclTrials));

YVars.FindIncludedTrials = @(Data, inclTrials) true;

Series(1).FindIncludedTrials = @(Data)   Data.numGabors == 1;
Series(2).FindIncludedTrials = @(Data)   Data.numGabors == 2;



PlotStyle.Xaxis(1).Title = 'Stimulus value(s)';
PlotStyle.Yaxis(1).Title = 'Confidence value(s)';


PlotStyle.Data(1).Name = 'Simple trials';
PlotStyle.Data(1).PlotType = 'line';

PlotStyle.Data(2).Name = 'Complex trials';
PlotStyle.Data(2).PlotType = 'line';

figHandle = mT_plotVariableRelations(DataSet, XVars, YVars, Series, PlotStyle);