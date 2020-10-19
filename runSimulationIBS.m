function result =  runSimulationIBS 

freeParam = createFreeParam;

for iModel = 1
    for jParticipant = 1
        S = createStimulusMatrix(iModel, jParticipant); %create a design matrix to hand to IBS
        respMat = createResponseMatrix(jParticipant); %create a response matrix to hand to IBS
        %resp = passSimulation(freeParam, S);
        fun = @(freeParam, S) passSimulation(freeParam, S); %create a function handle for wrapper simulations to hand to IBS
        %likeli = ibslike(fun, freeParam, respMat, S); %run IBS 
      
       %%bads goes here
       
    end
end

end
