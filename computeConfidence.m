function conf = computeConfidence(nTrials,Data, sigma_s, mu_cat1, Decision, ModelType)

posteriorRatio = NaN(nTrials, 1); 
metaNoise = (randn(1, nTrials)*(Data.metacognitiveNoise))'; %computes norm dist of noise and changes the std by the metacog noise


vector1 = ModelType ==0 && Decision ==1;
vector2 = ModelType ==0 && Decision ==0;
vector3 = ModelType ==1 && Decision ==1;
vector4 = ModelType ==1 && Decision ==0;

posteriorRatio(vector1) = ((-2)*(Data.Percept(vector1, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(vector1,1))^2));
posteriorRatio(vector2) = ((2)*(Data.Percept(vector2, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(vector2,1) )^2));
posteriorRatio(vector3) = -(log(normcdf(0, -Data.Percept(vector3, 1), Data.Sigma_X(vector3,1) ))/(1 - (normcdf(0, -Data.Percept(vector3, 1), Data.Sigma_X(vector3,1) ))));
posteriorRatio(vector4) = log((normcdf(0, -Data.Percept(vector4, 1), Data.Sigma_X(vector4,1) )))/(1 - (normcdf(0, -Data.Percept(vector4, 1), Data.Sigma_X(vector4,1) )));

posteriorRatio = posteriorRatio + metaNoise;
posteriorRatio = exp(posteriorRatio); 

conf = (1 / (1 + (posteriorRatio)));

end