function S = createStimulusMatrix

%we want: numGabors, Orientation, ContrastLevel, BlockType
%we want to stich these together into a design*nTirals matrix
%currently sit in a datastruct with 13P sub structs each holding the
%relevant data. 

%load in the behavioural data file

load('BehaviouralDataSet_analysed.mat');
 
%loop through 13 P
for iParticipant = 1:13 
%loop through different stimulus features
    for kDesignFeature = 1:4
%loop through 2520 trials
        for jTrial = 1:2520 
            kTrial = jTrial + (2520*(iParticipant-1));
            if kDesignFeature == 1            
%add numGabors
                S(kTrial, kDesignFeature) = DataSet.P(iParticipant).Data.numGabors(jTrial, 1);         
            elseif kDesignFeature == 2

%add Orientation
                S(kTrial, kDesignFeature) = DataSet.P(iParticipant).Data.Orientation(jTrial, 1);   

            elseif kDesignFeature == 3
%add ContrastLevel
                S(kTrial, kDesignFeature) = DataSet.P(iParticipant).Data.ContrastLevel(jTrial, 1); 
            else
%add BlockType
                if S(kTrial, 3) == 1
                    S(kTrial, 4) = 0;
                else
                    S(kTrial, 4) = 1;
                end
            end
        end
    end

end