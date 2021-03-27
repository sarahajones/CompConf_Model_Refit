%script to analyse the model fits achieved by running the wrapIBSBADSFIT
%function - the output structure is loaded and analysed accordingly. 

%load in teh data
data = load('ModelFit.mat');

%check all tryCounts are at 1 (they are above 1 the model fit had
%difficulty converging

bestFits = zeros(13,60);
averageModelFit = zeros(4,1);
for iParticipant = 1:13
    for jModel = 1:4
        likeli = zeros(10,1);
        for kRun = 1:10
            if data.ans.P(iParticipant).Model(jModel).run(kRun).try >1
                 warning('TryCount for participant %i is above 1.', iParticipant); 
            end
          likeli(kRun,1) =  data.ans.P(iParticipant).Model(jModel).run(kRun).result(1,15); %store the likelihood on that run 
        end
        [val, idx] = min(likeli); %find the overall min lieklihood for that model, for that participant
        bestFits(iParticipant, ((((jModel-1)*15) + 1 ):((jModel-1)*15) + 15 )) = data.ans.P(iParticipant).Model(jModel).run(idx).result;
        
       averageModelFit(jModel,1) = mean(bestFits(:,(jModel*15)));
       [bestFit, bestModel] = min(averageModelFit);
       
    end
end

%now have the best model fit overall (model 2)
%now within each pp, subtract their model2 fit from the others 
%put rezeroed fits into a neat matrix. 
modelFits = zeros(14,4);
for iParticipant = 1:13
    for jModel = 1:4
        modelFits(iParticipant, jModel) = bestFits(iParticipant, jModel*15) -  bestFits(iParticipant, bestModel*15);
    end
end


%reaverage across the other models
for i = 1:4
modelFits(14,i) = mean(modelFits((1:13),i));
end

% %plot
% models = 1:4;
% data = (modelFits(14,:))';
% 
% figure
% barplot(models,data)                

%hold on

%errhigh = [2.1 4.4 0.4 3.3 2.5 0.4 1.6 0.8 0.6 0.8 2.2 0.9 1.5];
%errlow  = [4.4 2.4 2.3 0.5 1.6 1.5 4.5 1.5 0.4 1.2 1.3 0.8 1.9];
%er = errorbar(x,data,errlow,errhigh);    
%er.Color = [0 0 0];                            
%er.LineStyle = 'none';  

%hold off
