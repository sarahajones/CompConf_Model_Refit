function result =  runIBSBADs(ParticipantNum, ModelNum, data)
tic
Participant = ParticipantNum;
Model = ModelNum;

%Use IBS to calculate the negative log likelihood 
%testFreeParam = createFreeParam; %comment out when running BADs
S = createStimulusMatrix(Model, Participant, data); %create a design matrix to hand to IBS
respMat = createResponseMatrix(Participant, data); %create a response matrix to hand to IBS
fun = @(freeParam, S)passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS
% result = ibslike(fun, freeParam, respMat, S); %run IBS

%Use BADS
%Set the parameter bounds

%sigmaX 
sigmaX0 = (randBetweenPoints(((pi/100)), ((2*pi)), 0, 1, 10));
sigmaXlb = (repmat((pi/1000), 1, 10)) ;
sigmaXub = (repmat ((10*pi), 1 , 10 ));
sigmaXplb = (repmat ((pi/200), 1 , 10 )); 
sigmaXpub = (repmat ((2*pi), 1 , 10 ));

%thresh. HOW MANY THRESHOLDS ARE WE WORKING WITH? 
thresh0 = sort(randBetweenPoints(0.45, .9, 0, 1, 1));
threshlb =  sort(zeros(1, 1)+ 0.01);
threshub =  sort(ones(1, 1) - 0.01);
threshplb =  sort(zeros(1, 1) + 0.45);
threshpub = sort(ones(1, 1))- 0.1;

%lapse rate
lapse0 = (randBetweenPoints(0.8, 0.9, 0, 1, 1));
lapselb = (0.8); %(just off zero)
lapseub = (1); %at limit
lapseplb = (0.8); 
lapsepub = (0.99); %set to chance

%metaCognitive noise (STD OF NOISE)
metaCog0 = (randBetweenPoints(100, 150, 0, 1, 1));
metaCoglb = (100);
metaCogub = (200);
metaCogplb = (100); %0.0087
metaCogpub = (150);

x0 = [lapse0 sigmaX0 metaCog0 thresh0];
LB = [lapselb sigmaXlb metaCoglb threshlb];
UB = [lapseub sigmaXub metaCogub threshub];
PLB = [lapseplb sigmaXplb metaCogplb threshplb];
PUB = [lapsepub sigmaXpub metaCogpub threshpub];

badsfun = @(freeParam)badsWrapper(fun,freeParam,respMat,S);
%badsfun(testFreeParam)
%result = badsfun(x0);
result = bads(badsfun,x0,LB,UB,PLB,PUB);
%resave as two values? what exactly is saved here Sarah?  

toc
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

function loglike = badsWrapper(fun, freeParam, respMat, S)

disp(freeParam)
options.Nreps = 1;
options.MaxIter = 10^6;
loglike = ibslike(fun,freeParam,respMat,S, options);

end


