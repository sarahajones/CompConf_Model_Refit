function result =  runSimulationIBS 

S = createStimulusMatrix;
freeParam = createFreeParam;

result = passSimulation(freeParam, S);

end
