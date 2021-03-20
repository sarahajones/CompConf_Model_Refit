function result =  runIBSBADs(Participant, Model, data)

%debug = runDebug(Participant, data);

%set up the IBS simulations
S = createStimulusMatrix(Model, Participant, data); %create a design matrix to hand to IBS
respMat = createResponseMatrix(Participant, data); %create a response matrix to hand to IBS
fun = @(freeParam, S)passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS

%Use BADS
%Set the parameter bounds
%sigmaX 
sigmaX0 = (randBetweenPoints(((pi/100)), ((2*pi)), 0, 1, 10));
sigmaXlb = (repmat((pi/1000), 1, 10)) ;
sigmaXub = (repmat ((10*pi), 1 , 10 ));
sigmaXplb = (repmat ((pi/200), 1 , 10 )); 
sigmaXpub = (repmat ((2*pi), 1 , 10 ));

%thresh. 
thresh0 = sort(randBetweenPoints(0.1, .9, 0, 1, 1));
threshlb =  sort(zeros(1, 1)+ 0.01);
threshub =  sort(ones(1, 1) - 0.01);
threshplb =  sort(zeros(1, 1) + 0.1);
threshpub = sort(ones(1, 1))- 0.1;

%lapse rate
lapse0 = (randBetweenPoints(0.01, 0.45, 0, 1, 1));
lapselb = (0.001); %0.01 (just off zero)
lapseub = (1); % 1, at limit
lapseplb = (0.01); %0.01 
lapsepub = (0.45); % 0.5, set to chance

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


x0 = [lapse0 sigmaX0 metaCog0 confLapse0 thresh0];
LB = [lapselb sigmaXlb metaCoglb confLapselb threshlb];
UB = [lapseub sigmaXub metaCogub confLapseub threshub];
PLB = [lapseplb sigmaXplb metaCogplb confLapseplb threshplb];
PUB = [lapsepub sigmaXpub metaCogpub confLapsepub threshpub];

badsfun = @(freeParam)badsWrapper(fun, freeParam, respMat, S);

[X,FVAL] = bads(badsfun,x0,LB,UB,PLB,PUB);
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

disp(freeParam)
%options.Nreps = 1; %should maybe raise for accuracy - standard is more like 10? 
options.MaxIter = 10^6;
loglike = ibslike(fun,freeParam,respMat,S, options);

end


