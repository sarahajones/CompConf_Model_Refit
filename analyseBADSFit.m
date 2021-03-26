%script to analyse the model fits achieved by running the wrapIBSBADSFIT
%function - the output structure is loaded and analysed accordingly. 

%load in teh data
data = load('ModelFit.mat');

%check all tryCounts are at 1 (they are above 1 the model fit had
%difficulty converging

bestFits = zeros(13,60);
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
        if jModel == 1
            bestFits(iParticipant, (1:15)) = data.ans.P(iParticipant).Model(jModel).run(idx).result; %take the overall lowest i.e. best fit as the bestFit 
        else 
           bestFits(i                                                                                                                                                                                        Participant, (((15*(jModel-1))+1):((15*jModel)+15))) = data.ans.P(iParticipant).Model(jModel).run(idx).result; %take the overall lowest i.e. best fit as the bestFit  
        end
    end
end
