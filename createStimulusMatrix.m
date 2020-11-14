function S = createStimulusMatrix (ModelNum, ParticipantNum, DataSet)
%we want: numGabors, Orientation, ContrastLevel, BlockType
%stitched together into a design*nTrials matrix

%add numGabors
S(:, 1) = DataSet.DataSet.P(ParticipantNum).Data.numGabors;

%add Orientation
S(:, 2) = DataSet.DataSet.P(ParticipantNum).Data.Orientation;

%add ContrastLevel
S(:, 3) = DataSet.DataSet.P(ParticipantNum).Data.ContrastLevel;
                       
%add BlockType
S(:, 4) = DataSet.DataSet.P(ParticipantNum).Data.BlockType; 

%add Model Number
S(:, 5) = ModelNum;

end