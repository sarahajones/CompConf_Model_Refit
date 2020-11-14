function resp = giveResp(nTrials, Data, mu_cat2, mu_cat1, prior)
if prior ~= 0.5; error ('Prior is not neutral cannot compute'); end
% What response is given in each case? resp = 0 , cat 1, resp = 1 , cat 2.
resp = zeros(nTrials, 1); %default on zero, if cat 1 percept it stays as the default unchanged

resp(Data.Percept == ((mu_cat2 + mu_cat1)/2)) = logical(randi([0 1], 1, 1)); %if response lies on the decision boundary, randomly assign to either cat1 or cat2
resp(Data.Percept > ((mu_cat2 + mu_cat1)/2)) = 1; %if percept falls below midline respond 1 (cat 2)

end