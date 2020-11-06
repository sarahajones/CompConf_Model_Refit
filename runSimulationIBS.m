function result =  runSimulationIBS 

freeParam = createFreeParam;
%numBins = length(freeParam.thresh);
    for jParticipant = 1
       for iModel = 1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Use IBS to calculate the negative log likelihood for each
        %participant and each model
        S = createStimulusMatrix(iModel, jParticipant); %create a design matrix to hand to IBS
        
        respMat = createResponseMatrix(jParticipant); %create a response matrix to hand to IBS
        
        %output = passSimulation(freeParam, S);
        
        fun = @(freeParam, S) passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS
        
        likeli = ibslike(fun, freeParam, respMat, S); %run IBS 
        likeli %print likelihood for debugging
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Use BADS 
        %Set the parameter bounds
        %example from @lacerbi
        %x0 = [0 0];                 % Starting point
        %lb = [-20 -20];             % Lower bounds
        %plb = [-5 -5];              % Plausible lower bounds
        %pub = [5 5];                % Plausible upper bounds

%         %sigmaX / variance
%         sigmaX0 = [randBetweenPoints(((pi/200)^2), ((2*pi)^2), 0, 5, 2)];  
%         sigmaXlb = [repmat(((pi/1000)^2), 5, 2)] ; 
%         sigmaXub = [repmat (((10*pi)^2), 5, 2)]; 
%         sigmaXplb = [randBetweenPoints(((pi/200)^2), ???????
%         sigmaXpub = [repmat (((2*pi)^2), 5, 2)] ;
% 
%         %thresh %%%%DO WE NEED TO SORT THESE _ IS IT SORTED ANYWAY?
            %%HOW MANY THRESHOLDS ARE WE WORKING WITH? SET HERE TOO? 
%         thresh0 = [randBetweenPoints(0.25, 1, 0, 9, 1)]; 
%         threshlb =  [zeros(9, 1)];
%         threshub = [ones(9, 1)]; 
%         threshplb =  [zeros(9, 1) + 0.25]; 
%         threshpub = [ones(9, 1)]; ?????????
% 
%         %lapse rate
%         lapse0 = [randBetweenPoints(0.01, 0.5, 0, 1, 1)]; 
%         lapselb = [0.001]; %(just off zero)
%         lapseub = [1]; %at limit
%         lapseplb = [0.01]; 
%         lapsepub = [0.5]; %set to chance
% 
%         %metaCognitive noise (STD OF NOISE)
%         metaCog0 = [randBetweenPoints(0.0087, 2, 0, 1, 1)]
%         metaCoglb = [0.00173]; 
%         metaCogub = [4]; 
%         metaCogplb = [0.0087]; 
%         metaCogpub = [2]; 

%         x0 = [sigmaX0, thresh0, lapse0, metaCog0];
%         LB = [sigmaXlb, threshlb,lapselb,metacoglb];
%         UB = [sigmaXub, threshub, lapseub, metaCogub];
%         PLB = [sigmaXplb, thresplb, lapseplb, metaCogplb];
%         PUB = [sigmaXpub, threshpub, lapsepub, metaCogpub];

       %badsfun = @(freeParam)ibslike(fun,freeParam,respMat,S)
       
       %bad = bads(badsfun,x0,LB,UB,PLB,PUB)
       
       end
    end
end

