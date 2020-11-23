function result =  runSimulationIBS

tic
Participant = 1;
Model = 2;
%model 1 pp1 = 270.412132 seconds, 4.5minutes, 5.7seconds
%model 2 pp1 = 23.18 seconds. 4.4 seconds
%model 3 pp1 = 233.810308 seconds, 3.9 minutes, 5.4 seconds
%model 4 pp1 = 392.837065 seconds, 6.5 minutes, 5.3 seconds
data = load('BehaviouralDataSet_analysed.mat');

%Use IBS to calculate the negative log likelihood 
% freeParam = createFreeParam; %comment out when running BADs
S = createStimulusMatrix(Model, Participant, data); %create a design matrix to hand to IBS
respMat = createResponseMatrix(Participant, data); %create a response matrix to hand to IBS

fun = @(freeParam, S) passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS

% result = ibslike(fun, freeParam, respMat, S); %run IBS
% toc


%Use BADS
%Set the parameter bounds

%sigmaX / variance
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

x0 = [lapse0 sigmaX0 metaCog0 thresh0];
LB = [lapselb sigmaXlb metaCoglb threshlb];
UB = [lapseub sigmaXub metaCogub threshub];
PLB = [lapseplb sigmaXplb metaCogplb threshplb];
PUB = [lapsepub sigmaXpub metaCogpub threshpub];

badsfun = @(freeParam)ibslike(fun,freeParam,respMat,S);

result = bads(badsfun,x0,LB,UB,PLB,PUB);
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


