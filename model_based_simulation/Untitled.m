load ('BehaviouralDataSet_Analysed.mat');
fits = load ('bestFits_retest.mat');

j=1;
k=1;
for i =1:13
    DataSet.P(i).Data.Design  = DataSet.P(i).Data.numGabors(1,1);    
    if DataSet.P(i).Data.Design ==1
       
       DataSet1.P(j).Data = DataSet.P(i).Data;
       orderedfits1 =
       j= j+1;
        else
        
        DataSet2.P(k).Data = DataSet.P(i).Data;
        orderfits2
        k=k+1;
    end

end

fits.bestFits
