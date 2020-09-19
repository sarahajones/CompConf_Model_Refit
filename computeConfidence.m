function conf = computeConfidence(nTrials,Data, sigma_s, mu_cat1)
%%%% CHECK THIS PLEASE - IS THE Mu-CAT1/2 right??? 
conf = zeros(nTrials, 1);

for iTrial = 1:nTrials  
      %%%METACOGNOISE = 
      %%draw value centred on the metacog ADD to the log posterior ratio
      %%CHANGE THIS 
    
    if Data.ModelType(iTrial, 1) == 0
        
        if Data.Decision(iTrial,1) == 1
            posteriorRatio(iTrial,1) = (exp(((-2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1))^2))));
            posteriorRatio (iTrial,1) = log(posteriorRatio(iTrial,1));
            posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1)*Data.metacognitiveNoise;
            posteriorRatio(iTrial,1) = exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
        else 
            posteriorRatio(iTrial,1) = (exp(((2)*(Data.Percept(iTrial, 1))*(mu_cat1))/ (((sigma_s)^2) + ((Data.Sigma_X(iTrial,1) )^2))));
            posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
            posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1).*Data.metacognitiveNoise;
            posteriorRatio(iTrial,1) = exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
        end
    else
         if Data.Decision(iTrial,1) == 1
        posteriorRatio(iTrial,1) = (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) ))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
        posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
        posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1).*Data.metacognitiveNoise;
        posteriorRatio (iTrial,1)= exp(posteriorRatio(iTrial,1));
        conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))^-1)); 
        
         else %%%% THIS IS NOT RIGHT YET
        posteriorRatio(iTrial,1) = ((normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )))/(1 - (normcdf(0, -Data.Percept(iTrial, 1), Data.Sigma_X(iTrial,1) )));
        posteriorRatio(iTrial,1) = log(posteriorRatio(iTrial,1));
        posteriorRatio(iTrial,1) = posteriorRatio(iTrial,1).*Data.metacognitiveNoise;
        posteriorRatio (iTrial,1)= exp(posteriorRatio(iTrial,1));
           conf(iTrial,1) = (1 / (1 + (posteriorRatio(iTrial,1))));
        end
        
%         if conf(i,1) < 0.5 
%              error('Code not functioning as expected')
%         end

    end
end      
end