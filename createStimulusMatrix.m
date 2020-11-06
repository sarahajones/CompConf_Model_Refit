function S = createStimulusMatrix (ModelNum, ParticipantNum, DataSet)

%we want: numGabors, Orientation, ContrastLevel, BlockType
%we want to stitch these together into a design*nTirals matrix
%currently sit in a datastruct with 13P sub structs each holding the
%relevant data. 

%S.Model = ModelNum; %ChooseModel
iParticipant = ParticipantNum; %Choose PArticipant 
%loop through different stimulus features
    for kDesignFeature = 1:5
%loop through 2520 trials
        for jTrial = 1:2520 
            
            if kDesignFeature == 1            
%add numGabors
                S(jTrial, kDesignFeature) = DataSet.DataSet.P(iParticipant).Data.numGabors(jTrial, 1);         
            elseif kDesignFeature == 2

%add Orientation
                S(jTrial, kDesignFeature) = DataSet.DataSet.P(iParticipant).Data.Orientation(jTrial, 1);   

            elseif kDesignFeature == 3
%add ContrastLevel
                S(jTrial, kDesignFeature) = DataSet.DataSet.P(iParticipant).Data.ContrastLevel(jTrial, 1); 
            
            elseif kDesignFeature == 4
%add BlockType
                if S(jTrial, 1) == 1
                    S(jTrial, 4) = 0;
                else
                    S(jTrial, 4) = 1;
                end
                
%add Model Number
            else 
                S(jTrial, kDesignFeature) = ModelNum;

            end
        end
    end

end