function result = wrapIBSBADsFit

data = load('BehaviouralDataSet_analysed.mat');

for iParticipant = 2 %1:13 %for each participant
    for jModel = 3 %1:4 %for each model
        for kRun = 1:2 %for ten runs
            isComplete = 0;
            tryCount = 1;
            while isComplete == 0 
                try
                    result.P(iParticipant).Model(jModel).run(kRun) = runIBSBADs(iParticipant, jModel,data);
                    isComplete = 1;
                catch
                    warning('BADs failed to converge on attempt %i.  Trying again.', tryCount);  
                    isComplete = 0;
                    tryCount = tryCount + 1;
                end
            end
        end
    end
end
result
end