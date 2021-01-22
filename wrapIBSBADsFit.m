function result = wrapIBSBADsFit

data = load('BehaviouralDataSet_analysed.mat');

for iParticipant = 1:1 %1:13 %for each participant
    for jModel = 1:1 %1:4 %for each model
        for kRun = 1:2 %for ten runs
            try
            result.P(iParticipant).Model(jModel).run(kRun) = runIBSBADs (iParticipant, jModel,data);
            catch
                warning('BADs failed to converge.  Trying again.');
                try
                    result.P(iParticipant).Model(jModel).run(kRun) = runIBSBADs (iParticipant, jModel,data);
                catch
                    warning('BADs failed to converge a second time.  Moving on');
                end                 
            end
        end
    end
end
result
end