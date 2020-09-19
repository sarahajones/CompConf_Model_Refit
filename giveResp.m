function resp = giveResp(nTrials, Data, mu_cat2, mu_cat1, prior)

resp = zeros(nTrials, 1);

% What response is given in each case?
%resp = 0 , cat 1, resp = 1 , cat 2. 
for i =1:nTrials
    if prior == 0.5
        if Data.Percept(i,1) < ((mu_cat2 + mu_cat1)/2) % if percept falls above midlinerespond 0 (cat 1)
            resp(i,1) = 0;
            
        elseif Data.Percept(i,1) == ((mu_cat2 + mu_cat1)/2)
            resp(i,1) = logical(randi([0 1], 1, 1)); %if response lies on the decision boundary, randomly assign to either cat1 or cat2
            
        elseif Data.Percept(i,1) > ((mu_cat2 + mu_cat1)/2)
            resp(i,1) = 1; %if percept falls below midline respond 1 (cat 2)

        end
    else
        error('Prior is not neutral cannot compute')
    end
end


end