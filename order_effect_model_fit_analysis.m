%split analysis for order effects

%load in the modelFits
data = load('ModelFit.mat');

%split by order (checking for order effects)
DataSet = load('BehaviouralDataSet_Analysed'); 

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
        [val, idx] = min(likeli); %find the overall min likelihood for that model, for that participant
        bestFits(iParticipant, ((((jModel-1)*15) + 1 ):((jModel-1)*15) + 15 )) = data.ans.P(iParticipant).Model(jModel).run(idx).result;
        
    end
end

modelFits = zeros(14,4);
for iParticipant = 1:13
    for jModel = 1:4
        modelFits(iParticipant, jModel) = bestFits(iParticipant, jModel*15);
    end
end


order = zeros(13,1);
ModelFit1 = zeros(6,4);
ModelFit2 = zeros(7,4);
k=1;
j=1;
for i =1:13
       order(i,1)= DataSet.DataSet.P(i).Data.numGabors(1,1); 
       if order(i) == 1 
           ModelFit1(k,:) = modelFits(i,:);
           k = k+1;
       else
           ModelFit2(j,:) = modelFits(i,:);
           j= j+1;
       end
end  


%look at the one gabor first  data
for jModel = 1:4
    averageModelFit1(jModel,1) = mean(ModelFit1(:,jModel));
    [bestFit, bestModel] = min(averageModelFit1);
end

for iParticipant = 1:length(ModelFit1(:,1))
    for jModel = 1:4
        bestFits1(iParticipant, jModel) = ModelFit1(iParticipant, jModel) -  ModelFit1(iParticipant, bestModel);
    end
end

%calculate bootci for each model 
ci1_1 = bootci(10000,@mean,bestFits1((1:length(bestFits1(:,1))),1));
ci2_1 = bootci(10000,@mean,bestFits1((1:length(bestFits1(:,1))),2));
ci3_1 = bootci(10000,@mean,bestFits1((1:length(bestFits1(:,1))),3));
ci4_1 = bootci(10000,@mean,bestFits1((1:length(bestFits1(:,1))),4));

%reaverage across the other models
columns = length(bestFits1)+1;
for i = 1:4
bestFits1(columns,i) = mean(bestFits1(:,i));
end

%plot bar of fits - are the error bars right here??
models = 1:4;
data = (bestFits1(7,:))';
errlow = [(ci1_1(1)), ci2_1(1), (ci3_1(1)), (ci4_1(1))];
errhigh = [(ci1_1(2)), ci2_1(2), (ci3_1(2)), (ci4_1(2))];

bar(models,data)                

hold on

er = errorbar(models,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off



%look at the two gabor first  data
for jModel = 1:4
    averageModelFit2(jModel,1) = mean(ModelFit2(:,jModel));
    [bestFit, bestModel] = min(averageModelFit2);
end


for iParticipant = 1:length(ModelFit2(:,1))
    for jModel = 1:4
        bestFits2(iParticipant, jModel) = ModelFit2(iParticipant, jModel) -  ModelFit2(iParticipant, bestModel);
    end
end

%calculate bootci for each model 
ci1_2 = bootci(10000,@mean,bestFits2((1:length(bestFits2(:,1))),1));
ci2_2 = bootci(10000,@mean,bestFits2((1:length(bestFits2(:,1))),2));
ci3_2 = bootci(10000,@mean,bestFits2((1:length(bestFits2(:,1))),3));
ci4_2 = bootci(10000,@mean,bestFits2((1:length(bestFits2(:,1))),4));

%reaverage across the other models
columns = length(bestFits2)+1;
for i = 1:4
bestFits2(columns,i) = mean(bestFits2(:,i));
end

%plot bar of fits - are the error bars right here??
models = 1:4;
data = (bestFits2(8,:))';
errlow = [(ci1_2(1)), ci2_2(1), (ci3_2(1)), (ci4_2(1))];
errhigh = [(ci1_2(2)), ci2_2(2), (ci3_2(2)), (ci4_2(2))];
figure
bar(models,data)                

hold on

er = errorbar(models,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off