function figHandle = plotConfAgainstTimeAndEv(DSet, plotType, figHandle, confType)
% Make plots of the effect of response time, and the effect of evidence on 
% confidence.

% INPUT
% confType: 'raw' or 'binned'

currentDir = pwd;
currentFolder = currentDir([end-4 : end]);

if strcmp(currentFolder, 'Plots')
    addpath('../modellingTools')
end

%% Product required data

%%%%%%%%%%%%%%%% If want to use ordinal confidence %%%%%%%%%%%%%%%%%%%
%%%%% Note: Need to change ConfCat to UnsignedConfCat below if want this
% The current confidence scores reflect p(right hand side box). Add new
% confidence variable, which refelcts p(correct), called "UnsignedConfCat"
% for iPtpnt = 1 : length(DSet.P)
% 
%     blockType = DSet.P(iPtpnt).Data.BlockType;
%     conf = DSet.P(iPtpnt).Data.Conf;
%     
%     BinSettings.DataType = 'integer';
%     BinSettings.BreakTies = false;
%     BinSettings.Flip = false;
%     BinSettings.EnforceZeroPoint = false;
%     BinSettings.CenterPoint = DSet.Spec.CenterPoint;
%     BinSettings.NumBins = DSet.FitSpec.NumBins;
%     BinSettings.BinsBelow = DSet.FitSpec.NumBins/2;
%     BinSettings.SepBinning = false;
%     
%     [DSet.P(iPtpnt).Data.UnsignedConfCat, indecisionPoint, ~] = ...
%         mT_makeVarOrdinal(BinSettings, conf, blockType, []);
%     
%     %%% Trying to get zero to be the indecision point
% %     % Center confidence categories around the indecision point. Need to subtract
% %     % off an additional 1/2 because the variable provides the bin to the left of
% %     % the indecision point, not this point itelf.
% %     indecisionPoint = cell2mat(indecisionPoint);
% %     indecisionPoint = unique(indecisionPoint);
% %     if length(indecisionPoint) ~= 1; error(['Calculations assume all data ', ...
% %             'binned together.']); end
% %     
% %     DSet.P(iPtpnt).Data.UnsignedConfCat ...
% %         = DSet.P(iPtpnt).Data.UnsignedConfCat - (indecisionPoint +(1/2));
%     
%     
% end


XVars(1).ProduceVar = @(Data) Data.RtPrec;
XVars(1).NumBins = 10;

XVars(2).ProduceVar = @(Data) abs(Data.TotalPreRespEv ./ Data.ActualDurationPrec);
XVars(2).NumBins = 10;

if strcmp(confType, 'raw')
    YVars(1).ProduceVar = @(Data, incTrials) mean(Data.Conf(incTrials));
elseif strcmp(confType, 'binned')
    % Flip the bins to give confidence in choice, rather than in one option vs. 
    % the other.
    midPoint = (DSet.FitSpec.NumBins+1)/2;
    YVars(1).ProduceVar = @(Data, incTrials) ...
        mean((Data.ConfCat(incTrials)-midPoint).*(Data.Resp(incTrials)-3/2)*2);
end

if strcmp(confType, 'raw')
    YVars(2).ProduceVar = @(Data, incTrials) var(Data.Conf(incTrials));
elseif strcmp(confType, 'binned')
    % Flip the bins to give confidence in choice, rather than in one option vs. 
    % the other.
    midPoint = (DSet.FitSpec.NumBins+1)/2;
    YVars(2).ProduceVar = @(Data, incTrials) ...
        var((Data.ConfCat(incTrials)-midPoint).*(Data.Resp(incTrials)-3/2)*2);
end

YVars(1).FindIncludedTrials = @(Data, incTrials) ~isnan(Data.Conf);
YVars(2).FindIncludedTrials = @(Data, incTrials) ~isnan(Data.Conf);

Series(1).FindIncludedTrials = @(Data) Data.BlockType == 1;
Series(2).FindIncludedTrials = @(Data) Data.BlockType == 2;

PlotStyle.Xaxis(1).Title = 'Stimulus duration (s)';
PlotStyle.Xaxis(2).Title = 'Average evidence strength (arb. units)';

PlotStyle.Yaxis(1).Title = 'Confidence (arb. units)';
PlotStyle.Yaxis(2).Title = {'Confidence variance',  '(arb. units)'};

PlotStyle.Data(1).Name = 'Free response';
PlotStyle.Data(1).PlotType = plotType;

PlotStyle.Data(2).Name = 'Fixed response';
PlotStyle.Data(2).PlotType = plotType;



figHandle = mT_plotVariableRelations(DSet, XVars, YVars, Series, PlotStyle, figHandle);


rmpath('../modellingTools')