
%use this function to split the data set based on which type of trial they
%saw in their first block (easy or hard)
%rebin their confidence to have 4 bins like the new model

load ('BehaviouralDataSet_Analysed.mat')
j=1;
k=1;
pDivisions = 0 : 0.25 : 1; %upped to 4
for i =1:13
    DataSet.P(i).Data.Design  = DataSet.P(i).Data.numGabors(1,1);
    if DataSet.P(i).Data.Design ==1
       
       DataSet1.P(j).Data = DataSet.P(i).Data;
       confidence = DataSet1.P(j).Data.Confidence; %rebin original confidence accordingly
       breaks = quantile(confidence, pDivisions);
       DataSet1.P(j).Data.newBinnedConfidence = discretize(confidence, breaks);
       j= j+1;
    else
        
        DataSet2.P(k).Data = DataSet.P(i).Data;
        confidence = DataSet2.P(k).Data.Confidence; %rebin original confidence accordingly
        breaks = quantile(confidence, pDivisions);
        DataSet2.P(k).Data.newBinnedConfidence = discretize(confidence, breaks);
        k=k+1;
    end
        
end  

filename1 = 'DataSet1.mat'; %easy first
save(filename1);

filename2 = 'DataSet2.mat'; %hard first
save(filename2);

