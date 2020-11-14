function conf = computeConfidence(nTrials,Data, sigma_s, mu_cat1, Decision, ModelType)

conf = zeros(nTrials, 1);
metaNoise = (randn(1, nTrials)*(Data.metacognitiveNoise))'; %computes norm dist of noise and chagnes the std by the metacog noise

for iTrial = 1:nTrials
    
    if ModelType(iTrial, 1) == 0
        if Decision(iTrial,1) == 1
            posteriorRatio = log(exp(((-2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1))^2))));
            posteriorRatio = posteriorRatio + metaNoise(iTrial, 1);
            posteriorRatio = exp(posteriorRatio);
            conf(iTrial,1) = (1 / (1 + (posteriorRatio)));
        else
            posteriorRatio = log(exp(((2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1) )^2))));
            posteriorRatio = posteriorRatio + metaNoise(iTrial, 1);
            posteriorRatio = exp(posteriorRatio);
            conf(iTrial,1) = (1 / (1 + (posteriorRatio)));
        end
    else
        if Decision(iTrial,1) == 1
            posteriorRatio = log(normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) ))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
            posteriorRatio = posteriorRatio + metaNoise(iTrial, 1);
            posteriorRatio = exp(posteriorRatio);
            conf(iTrial,1) = (1 / (1 + (posteriorRatio)^-1));
            
        else
            posteriorRatio = log((normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
            posteriorRatio = posteriorRatio + metaNoise(iTrial, 1);
            posteriorRatio= exp(posteriorRatio);
            conf(iTrial,1) = (1 / (1 + (posteriorRatio)));
        end
    end
    
end


end