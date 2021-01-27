function result = wrapIBSBADsFit

data = load('BehaviouralDataSet_analysed.mat');

for iParticipant = 1:1 %1:13 %for each participant
    for jModel = 1:1 %1:4 %for each model
        for kRun = 1:2 %for ten runs
            isComplete = 0;
            while isComplete == 0 
                try
                    result.P(iParticipant).Model(jModel).run(kRun) = runIBSBADs(iParticipant, jModel,data);
                    isComplete = 1;
                catch
                    warning('BADs failed to converge for the .  Trying again.');  
                    isComplete = 0;
                end
            end
        end
    end
end
result
end