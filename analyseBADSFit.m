%script to analyse the model fits achieved by running the wrapIBSBADSFIT
%function - the output structure is loaded and analysed accordingly. 

%load in the data
data = load('ModelFit_ReFit_vonMises.mat'); % this model refit is without the vonMises function usage (i.e. minus the implied cirlce stats). 



bestFits = zeros(13,68); %adjust size for new bins
averageModelFit = zeros(4,1);
for iParticipant = 1:13
    for jModel = 1:4
        likeli = zeros(10,1);
        for kRun = 1:10
            if data.ModelFit.P(iParticipant).Model(jModel).run(kRun).try >1
                %check all tryCounts are at 1 (if they are above 1 the
                %model fit had difficulty converging so throw an error)
                 warning('TryCount for participant %i is above 1.', iParticipant); 
            end
            %extract the likelihood of the model fit on each run within
            %each participant
          likeli(kRun,1) =  data.ModelFit.P(iParticipant).Model(jModel).run(kRun).result(1,17); %store the  likelihood on that run 
        end
        [val, idx] = min(likeli); %find the likelihood for that model, for that participant
        %use the index of the  likelihood for that model to store the
        %best fit for that model for the participant across all runs
        %(SHOULD THIS BE AVERAGE INSTEAD??)
        bestFits(iParticipant, ((((jModel-1)*17) + 1 ):((jModel-1)*17) + 17 )) = data.ModelFit.P(iParticipant).Model(jModel).run(idx).result;
        
        %take the mean of the model fits across all pp 
       averageModelFit(jModel,1) = mean(bestFits(:,(jModel*17)));
       [bestFit, bestModel] = min(averageModelFit);
       
    end
end

save('bestFits.mat')

%compute BIC from the log likelihoodd 
%BIC: ?2 × log-likelihood + log(Number of observations) × number of parameters
numParams = 16;
numObs = 2520*13;

modelBIC = zeros(14,4);
for iParticipant = 1:13
    for jModel = 1:4
        modelBIC(iParticipant, jModel) = ( -2*(bestFits(iParticipant,jModel*17))) + (log(numObs)*numParams);
    end
end


avgbic = zeros(1,4);
for jModel = 1:4
  avgbic(1, jModel) = ( -2*(averageModelFit(jModel,1))) + (log(numObs)*numParams);
end

[~,bic] = aicbic(averageModelFit,numParams,numObs);

%now have the best model fit overall (model 2)
%now within each pp, subtract their model2 fit from the others 
%put rezeroed fits into a neat matrix. 
deltaBIC = zeros(14,4);
for iParticipant = 1:13
    for jModel = 1:4
        deltaBIC(iParticipant, jModel) =   modelBIC(iParticipant, jModel) - modelBIC(iParticipant, bestModel);
    end
end

deltaBIC = -1.*deltaBIC;

%calculate bootci for each model 
ci1 = bootci(10000,@mean,deltaBIC((1:13),1));
ci2 = bootci(10000,@mean,deltaBIC((1:13),2));
ci3 = bootci(10000,@mean,deltaBIC((1:13),3));
ci4 = bootci(10000,@mean,deltaBIC((1:13),4));

%reaverage across the other models
for i = 1:4
deltaBIC(14,i) = mean(deltaBIC((1:13),i));
end


%plot bar of fits - are the error bars right here??
models = 1:4;
data = (deltaBIC(14,:))';

errlow = [abs(data(1)- ci1(1)), abs(data(2)-ci2(1)), abs(data(3)-ci3(1)), abs(data(4)-ci4(1))];
errhigh = [abs(data(1)- ci1(2)), abs(data(2)-ci2(2)), abs(data(3)-ci3(2)), abs(data(4)-ci4(2))];
errBottom = [(data(1)- ci1(1)), (data(2)-ci2(1)), (data(3)-ci3(1)), (data(4)-ci4(1))];

figure
bar(models,data)                

hold on

er = errorbar(models,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold on

colormap winter
for iPtpnt = 1:13
           plot(deltaBIC(iPtpnt, :), 'LineWidth', 1)
   
end

hold off





% 
% %now have the best model fit overall (model 2)
% %now within each pp, subtract their model2 fit from the others 
% %put rezeroed fits into a neat matrix. 
% modelFits = zeros(14,4);
% for iParticipant = 1:13
%     for jModel = 1:4
%         modelFits(iParticipant, jModel) =   bestFits(iParticipant, jModel*17) - bestFits(iParticipant, bestModel*17);
%     end
% end
% 
% 
% %calculate bootci for each model 
% ci1 = bootci(10000,@mean,modelFits((1:13),1));
% ci2 = bootci(10000,@mean,modelFits((1:13),2));
% ci3 = bootci(10000,@mean,modelFits((1:13),3));
% ci4 = bootci(10000,@mean,modelFits((1:13),4));
% 
% %reaverage across the other models
% for i = 1:4
% modelFits(14,i) = mean(modelFits((1:13),i));
% end
% 
% 
% %plot bar of fits - are the error bars right here??
% models = 1:4;
% data = (modelFits(14,:))';
% 
% errlow = [abs(data(1)- ci1(1)), abs(data(2)-ci2(1)), abs(data(3)-ci3(1)), abs(data(4)-ci4(1))];
% errhigh = [abs(data(1)- ci1(2)), abs(data(2)-ci2(2)), abs(data(3)-ci3(2)), abs(data(4)-ci4(2))];
% errBottom = [(data(1)- ci1(1)), (data(2)-ci2(1)), (data(3)-ci3(1)), (data(4)-ci4(1))];
% 
% figure
% bar(models,data)                
% 
% hold on
% 
% er = errorbar(models,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% 
% hold on
% 
% colormap winter
% for iPtpnt = 1:13
%            plot(modelFits(iPtpnt, :), 'LineWidth', 1)
%    
% end
% 
% hold off


%plot out param values per participant per model
%looking at the sigma values 
for jModel = 1:4
figure
for iPtpnt = 1 : 13
           plot(1:5, bestFits(iPtpnt, ((((jModel-1)*17) + 2):((jModel-1)*17) + 6 )),'Color', [0, 0, 0], 'LineWidth', 1) %black 
           hold on
           plot(1:5, bestFits(iPtpnt, ((((jModel-1)*17) + 7):((jModel-1)*17) + 11 )), 'Color', [0.2, 0.7, 0.7], 'LineWidth', 1) %green
           hold on   
end
hold off
end


%check and see how many pp had model2 as the best fitting model
%see the variation in best fitting models across pp. 
winningModels = zeros(13,5);
for iParticipant = 1:13
    for jModel = 1:4
        winningModels(iParticipant, jModel) = bestFits(iParticipant, jModel*17);
    end
end

modelNumber = zeros(13,1);
for iParticipants = 1:13
    winningModels(iParticipants, 5) = min(winningModels(iParticipants, 1:4));
    modelNumber(iParticipants,1) = find(winningModels(iParticipants, 1:4)== winningModels(iParticipants, 5));
end

modelNumber = modelNumber';

model = zeros(4,1);
for i = 1:4
    model(i,1) = sum(modelNumber == i);
    
end

model = model';

figure
bar(models,model)