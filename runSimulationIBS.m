function result =  runSimulationIBS 

freeParam = createFreeParam;

for iModel = 2
    for jParticipant = 1
        
        %lapse rate back down and still solves quickly for morel2 pp1 
        
       % metacog .99 ok, .8 ok, .6 ... slows significantly quit before
       % solved/bugged otu
       
       %change the conf bins to be more robust annd flexible pull out any
       %hard coding. 
       
       
        S = createStimulusMatrix(iModel, jParticipant); %create a design matrix to hand to IBS
        respMat = createResponseMatrix(jParticipant); %create a response matrix to hand to IBS
        %resp = passSimulation(freeParam, S);
        fun = @(freeParam, S) passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS
        likeli = ibslike(fun, freeParam, respMat, S); %run IBS 
        likeli
        
       %%bads goes here
       
%         %sigmaX / variance
%         sigmaX0 = @() randBetweenPoints(((pi/200)^2), ((2*pi)^2), 0, 5, 2);  
%         sigmaXlb =  @() repmat(((pi/1000)^2), 5, 2) ; 
%         sigmaXub = @() repmat (((10*pi)^2), 5, 2); 
%         sigmaXplb = @() randBetweenPoints(((pi/200)^2), 
%         sigmaXpub = @() repmat (((2*pi)^2), 5, 2) ; %plausible upper bound
% 
%         %thresh %%%%DO WE NEED TO SORT THESE _ IS IT SORTED ANYWAY?
%         thresh0 = @() randBetweenPoints(0.25, 1, 0, 9, 1); %start point @() randBetweenPoints(0.5, 1, 0, 9, 1)
%         threshlb =  @() zeros(9, 1); %lower bound @() zeros(9, 1) + 0.5;
%         threshub = @() ones(9, 1); %upper bound @() ones(9, 1);
%         threshplb =   @() zeros(9, 1) + 0.25; %plausible lower bound
%         threshpub = @() ones(9, 1); %plausible upper bound
% 
%         %lapse
%         lapse0 = @() randBetweenPoints(0.01, 0.5, 0, 1, 1); %start point @() randBetweenPoints(1/600, 500/600, 0, 1, 1);
%         lapselb = 0.001; %lower bound @() 1/600; 0 (ust off zero)
%         lapseub = 1; %upper bound @() 500/600; 1 %at limit
%         lapseplb = 0.01; %plausible lower bound % 1% plausible lower bound
%         lapsepub = 0.5; %plausible upper boundb %set to chance
% 
%         %metaCog (STD OF NOISE)
%         metaCog0 = between upper and lower bound; %start point
%         metaCoglb =  0.00173; 
%         metaCogub = 4; 
%         metaCogplb = 0.0087; 
%         metaCogpub = 2; 

%         x0 = [sigmaX0, thresh0, lapse0, metaCog0];
%         LB = [sigmaXlb, threshlb,lapselb,metacoglb];
%         UB = [sigmaXub, threshub, lapseub, metaCogub];
%         PLB = [sigmaXplb, thresplb, lapseplb, metaCogplb];
%         PUB = [sigmaXpub, threshpub, lapsepub, metaCogpub];

       %badsfun = @(freeParam)ibslike(fun,freeParam,respMat,S);
       

       %bad = bads(badsfun,x0,LB,UB,PLB,PUB)
       
    end
end

end
