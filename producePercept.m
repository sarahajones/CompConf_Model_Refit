function [percept] = producePercept(Data)

noise = randn(1, 1)*(Data.Sigma_X);
percept = Data.Orientation + noise; 

end 