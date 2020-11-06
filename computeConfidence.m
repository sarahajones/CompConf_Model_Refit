function conf = computeConfidence(nTrials,Data, sigma_s, mu_cat1, Decision, ModelType)
conf = zeros(nTrials, 1);
posteriorRatio = zeros(nTrials,1); 

for iTrial = 1:nTrials  
    metaNoise = randn(1, 1)*(Data.metacognitiveNoise); %computes norm dist of noise and chagnes the std by the metacog noise 
    %metaNoise = 0;
    %plot avg conf as function of percept
    
    if ModelType(iTrial, 1) == 0
        if Decision(iTrial,1) == 1
            posteriorRatio(iTrial,1) = (exp(((-2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1))^2))));
            posteriorRatio (iTrial,1) = log(posteriorRatio(iTrial,1));
            posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1) + metaNoise;
            posteriorRatio(iTrial,1) = exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
        else 
            posteriorRatio(iTrial,1) = (exp(((2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1) )^2))));
            posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
            posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1)+ metaNoise;
            posteriorRatio(iTrial,1) = exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
        end
    else
         if Decision(iTrial,1) == 1
        posteriorRatio(iTrial,1) = (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) ))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
        posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
        posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1)+ metaNoise;
        posteriorRatio (iTrial,1)= exp(posteriorRatio(iTrial,1));
        conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))^-1)); 
        
         else 
        posteriorRatio(iTrial,1) = ((normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
        posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
        posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1) + metaNoise;
        posteriorRatio (iTrial,1)= exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
         end
    end
    %if conf(iTrial,1) < 0.5 
    %          error('Code not functioning as expected')
    %end
end      
end