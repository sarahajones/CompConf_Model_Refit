function debug = runDebug(Participant, data) 
%function to test out and investigate the trials relating to the
%problematic parmateer points as identified manually throguh BADs failures.
%takes in the participant and the datastruct and outputs information about
%the problem trials.


%these are the problem params for each model
freeParam1 = [ 0.1020, 0.0698, 5.6221, 0.2074, 0.0492, 0.3947, 0.0707, 0.0572, 3.0593, 0.3197, 0.1128, 0.0805, 0.7545];
freeParam2 = [0.1574, 0.0442, 0.0862, 0.1911, 0.3901, 1.2869, 0.1956, 3.6464, 4.5013, 2.8519, 0.0184, 0.0489, 0.7730]; %always Bayes
freeParam3 = [0.2273, 0.1010, 0.1218, 2.4928, 0.7556, 0.0415, 1.6745, 0.0206, 0.1990, 2.6123, 0.2086, 0.0751, 0.7849];
freeParam4 = [ 0.1629, 3.6464, 0.0643, 0.0376, 0.1700, 1.1857, 0.2443, 0.0534, 0.0230, 3.0954, 6.1739, 0.0090, 0.8829];%always Rule
freeParamALL = [freeParam1; freeParam2; freeParam3; freeParam4];%set freeParam to be the tricky params for this model

confTrials1 = [];
confTrials2 = [];
confTrials3 = [];
confTrials4 = [];
respTrials1 = [];
respTrials2 = [];
respTrials3 = [];
respTrials4 = [];
confidence = zeros(2520, 10000);
response = zeros(2520, 10000);

for j = 1:4
    freeParams = freeParamALL(j,:);
    Model = j;
    S = createStimulusMatrix(Model, Participant, data); %create a design matrix to hand to IBS
    respMat = createResponseMatrix(Participant, data); %create a response matrix to hand to IBS
   
    
    %simulate 10000 times over the same trials and freeParams
    for i = 1:10000
        simulation = passSimulation(freeParams, S);
        confidence(:, i) = simulation(:, 2);
        response(:,i) = simulation(:,1);
    end

    %check they have more than 1 response/confidence bin

    for i = 1:2520
        uniqConf(i, j) = length(unique(confidence(i, :)));
        uniqResp(i, j) = length(unique(response(i, :))); 
        if uniqConf(i,j) == 1
            if j == 1
            confTrials1(end+1) = i;
            elseif j == 2
            confTrials2(end+1) = i;  
            elseif j == 3
            confTrials3(end+1) = i;
            else
            confTrials4(end+1) = i;
            end
        end
        if uniqResp(i,j) ==1
            if j == 1
            respTrials1(end+1) = i;
            elseif j == 2
            respTrials2(end+1) = i; 
            elseif j == 3
            respTrials3(end+1) = i;
            else
            respTrials4(end+1) = i;
            end
        end
    end
    
    
    
end

%investigate the confidence trials  
 confProblem = sort(vertcat(confTrials1', confTrials2', confTrials3', confTrials4'));
 [uniqueA i j] = unique(confProblem,'first');
 indexToDupes = find(not(ismember(1:numel(confProblem),i)));
 indexToDupes = indexToDupes';
 for i = 1:length(indexToDupes)
     confTrials(i,1) = indexToDupes(i,1); %these are the most problematic of trials for conf
 end
 
 %simulate the confidence from those trials
 
 %write down index of problem trials, then debgug point in conf function -
 %call again and check over the vector in confidence and manually look at
 %raw values in problem trials. (stop in the function). 
 
 
 
 
 
 
 respProblem = sort(vertcat(respTrials1', respTrials2', respTrials3', respTrials4'));
 [uniqueB i j] = unique(respProblem,'first');
 indexToDupes2 = find(not(ismember(1:numel(respProblem),i)));
 indexToDupes2 = indexToDupes2';
 for i = 1:length(indexToDupes2)
     respTrials(i,1) = indexToDupes2(i,1); %these are the most problematic for resp
 end

 problemTrials = sort(vertcat(respTrials, confTrials));
 indexToDupes3 = find(not(ismember(1:numel(problemTrials),i)));
 indexToDupes3 = indexToDupes3';
 for i = 1:length(indexToDupes3)
     problemTrials(i,1) = indexToDupes3(i,1); %these are the most problematic for resp
 end

end