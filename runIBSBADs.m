function result =  runIBSBADs(Participant, Model, data)

%debug = runDebug(Participant, data);

%set up the IBS simulations
S = createStimulusMatrix(Model, Participant, data); %create a design matrix to hand to IBS
respMat = createResponseMatrix(Participant, data); %create a response matrix to hand to IBS
fun = @(freeParam, S)passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS

%Use BADS
%Set the parameter bounds
%lapse rate
lapse0 = (randBetweenPoints(0.01, 0.45, 0, 1, 1));
lapselb = (0.001); %0.01 (just off zero)
lapseub = (1); % 1, at limit
lapseplb = (0.01); %0.01 
lapsepub = (0.45); % 0.5 = chance

%sigmaX 
sigmaX0 = (randBetweenPoints(((pi/100)), ((pi)), 0, 1, 10));
sigmaXlb = (repmat((pi/1000), 1, 10)) ;
sigmaXub = (repmat ((pi), 1 , 10 ));
sigmaXplb = (repmat ((pi/100), 1 , 10 )); 
sigmaXpub = (repmat ((pi), 1 , 10 )); %JUSTIFY YOUR VALUES SARAH - think circle. 

%metaCognitive noise 
metaCog0 = (randBetweenPoints(0.0087, 2, 0, 1, 1));
metaCoglb = (0.0001);%0.0001
metaCogub = (4); %4
metaCogplb = (0.0087); %0.0087
metaCogpub = (2); %2

%confLapse 
confLapse0 = (randBetweenPoints(0.01, 0.1, 0, 1, 1));
confLapselb = (0.0001); 
confLapseub = (1); 
confLapseplb = (0.01);  
confLapsepub = (0.1); 

%thresh (conf bin boundaries)
thresh0 = sort(randBetweenPoints(0.1, .9, 0, 1, 3));
threshlb =  sort(zeros(1, 3)+ 0.01);
threshub =  sort(ones(1, 3) - 0.01);
threshplb =  sort(zeros(1, 3) + 0.1);
threshpub = sort(ones(1, 3))- 0.1;


x0 = [lapse0 sigmaX0 metaCog0 confLapse0 thresh0];
LB = [lapselb sigmaXlb metaCoglb confLapselb threshlb];
UB = [lapseub sigmaXub metaCogub confLapseub threshub];
PLB = [lapseplb sigmaXplb metaCogplb confLapseplb threshplb];
PUB = [lapsepub sigmaXpub metaCogpub confLapsepub threshpub];

badsfun = @(freeParam)badsWrapper(fun, freeParam, respMat, S);

options = bads('defaults');
%inform BADS that IBSLIKE returns noise estimate (SD) as second output
options.UncertaintyHandling = true;
options.SpecifyTargetNoise = true;  
[X,FVAL] = bads(badsfun,x0,LB,UB,PLB,PUB,options);

result = [X, FVAL];

end

function n = randBetweenPoints(lower, upper, epsilon, sizeD1, sizeD2)
% Draw a random number from [lower + epsilon, upper - epsilon]

% INPUT
% sizeD1 and sizeD2 size of the output along dimention 1 and 2.
% If not specified uses 1, 1.
if nargin == 3
    size = {1, 1};
    
else
    size = {sizeD1, sizeD2};
    
end


range = upper - lower - (2*epsilon);

n = (rand(size{:})*range) + lower + epsilon;


end

function loglike = badsWrapper(fun, freeParam, respMat, S)

options_ibs = ibslike('defaults');
options_ibs.Nreps = 10; %up to 10 to increase accuracy (100 for fine tuning)
options_ibs.ReturnStd  = true; %tell IBSLIKE to return as a second output the standard deviation 
% of the estimate (as opposed to the variance). This is very important!
options_ibs.MaxIter = 10^6; %higher than default

loglike = ibslike(fun,freeParam,respMat,S, options_ibs);

end


