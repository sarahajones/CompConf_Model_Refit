function [percept] = producePercept(Data)

noise = randn(length(Data.Sigma_X), 1);
noise = noise.*(Data.Sigma_X);
percept = Data.Orientation + noise; 

end 