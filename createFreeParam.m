function freeParam = createFreeParam 

%lapseRate = freeParams(1);
%sigma_X = [freeParams(2), freeParams(3),freeParams(4),freeParams(5),freeParams(6); freeParams(7),freeParams(8), freeParams(9),freeParams(10)];
%.metacogNoise = freeParam(11)
%thresh = freeParam(12:21)

lapseRate = 0.2;
sigma_X = [1, 1.25, 1.5, 1.75, 2, 1.1, 1.35, 1.6, 1.85, 2.1]; %internal noise that is contrast and numGabor dependent
metacogNoise = 0.99;
thresh = (0 : 0.25 : 1);

freeParam  = [lapseRate, sigma_X, metacogNoise, thresh]; 

end
