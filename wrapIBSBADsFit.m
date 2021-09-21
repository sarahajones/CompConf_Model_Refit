function ModelFit = wrapIBSBADsFit

data = load('BehaviouralDataSet_analysed.mat');

for iParticipant = 1:1 %1:13 %for each participant
    for jModel = 1:4 %1:4 %for each model
        for kRun = 1:1 %1:10 %for ten runs
            isComplete = 0;
            tryCount = 1;
            while isComplete == 0  
                try
                    ModelFit.P(iParticipant).Model(jModel).run(kRun).result = runIBSBADs(iParticipant, jModel, data);
                    isComplete = 1;
                 catch
                     warning('BADs failed to converge on attempt %i.  Trying again.', tryCount);  
                     isComplete = 0;
                     tryCount = tryCount + 1;
                 end  
            end
            ModelFit.P(iParticipant).Model(jModel).run(kRun).try = tryCount;
        end
    end
end
save("ModelFit_ReFit_test")
end

