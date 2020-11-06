function result =  runSimulationIBS 

data = load('BehaviouralDataSet_analysed.mat');

freeParam = createFreeParam;
for jParticipant = 1:1
    for iModel = 1:1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Use IBS to calculate the negative log likelihood for each
        %participant and each model
        S = createStimulusMatrix(iModel, jParticipant, data); %create a design matrix to hand to IBS
        
        respMat = createResponseMatrix(jParticipant, data); %create a response matrix to hand to IBS
        
        fun = @(freeParam, S) passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS
        
        %likeli(jParticipant, iModel) = ibslike(fun, freeParam, respMat, S); %run IBS 
        %likeli %print likelihood for debugging
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Use BADS 
        %Set the parameter bounds
        %example from @lacerbi
        %x0 = [0 0];                 % Starting point
        %lb = [-20 -20];             % Lower bounds
        %plb = [-5 -5];              % Plausible lower bounds
        %pub = [5 5];                % Plausible upper bounds

%         %sigmaX / variance
        sigmaX0 = (randBetweenPoints(((pi/200)^2), ((2*pi)^2), 0, 1, 10));  
        sigmaXlb = (repmat(((pi/1000)^2), 1, 10)) ; 
        sigmaXub = (repmat (((10*pi)^2), 1 , 10 )); 
        sigmaXplb = (repmat (((pi/200)^2), 1 , 10 ));
        sigmaXpub = (repmat (((2*pi)^2), 1 , 10 ));

        %thresh. HOW MANY THRESHOLDS ARE WE WORKING WITH?  
        thresh0 = sort(randBetweenPoints(0.25, 1, 0, 1, 3)); 
        threshlb =  sort(zeros(1, 3));
        threshub =  sort(ones(1, 3)); 
        threshplb =  sort(zeros(1, 3) + 0.25); 
        threshpub = sort(ones(1, 3)); 

        %lapse rate
        lapse0 = (randBetweenPoints(0.01, 0.5, 0, 1, 1)); 
        lapselb = (0.001); %(just off zero)
        lapseub = (1); %at limit
        lapseplb = (0.01); 
        lapsepub = (0.5); %set to chance

        %metaCognitive noise (STD OF NOISE)
        metaCog0 = (randBetweenPoints(0.0087, 2, 0, 1, 1));
        metaCoglb = (0.00173); 
        metaCogub = (4); 
        metaCogplb = (0.0087); 
        metaCogpub = (2); 

        x0 = [sigmaX0 thresh0 lapse0 metaCog0];
        LB = [sigmaXlb threshlb lapselb metaCoglb];
        UB = [sigmaXub threshub lapseub metaCogub];
        PLB = [sigmaXplb threshplb lapseplb metaCogplb];
        PUB = [sigmaXpub threshpub lapsepub metaCogpub];

       badsfun = @(freeParam)ibslike(fun,freeParam,respMat,S);
       
       bad = bads(badsfun,x0,LB,UB,PLB,PUB);
       
     end
end

end

function n = randBetweenPoints(lower, upper, epsilon, sizeD1, sizeD2)
% Draw a random number from [lower + epsilon, upper - epsilon]

% INPUT
% sizeD1 and sizeD2     size of the output along dimention 1 and 2.
%                       If not specified uses 1, 1.

if nargin == 3
    size = {1, 1};
    
else
    size = {sizeD1, sizeD2};
    
end 
    

range = upper - lower - (2*epsilon);

n = (rand(size{:})*range) + lower + epsilon;


end


