%% Load Data
load('data.mat') % Loads {X,y,Xtest,ytest,groupnames,wordlist}
[N,P] = size(X);
C = max(y);

%% Train extra-naive Bayes
p_y = zeros(4,1); % We will store the probability of each class, p(y=c), in this vector
p_x_c = zeros(4,100);      %To store P(X=1|Y=c)
p_x_c_not = zeros(4,100);  %To store P(X=0|Y=c)
top_predictive_words = cell(4,10);
for c = 1:C
    p_y(c) = sum(y==c)/N;
    
    X_c = X(y==c,:);     %subset training data by class c
    p_x_c(c,:) = sum(X_c)/size(X_c,1); %compute P(X=1|Y=c)
    p_x_c_not(c,:) = 1 - p_x_c(c,:);   %compute P(X=0|Y=c)
    
    %%% Top 10 predictive words for each class
    sortedM = p_x_c(c,:);
    [sortedV, sortedI] = sort(sortedM(:), 'descend');
    top_predictive_words(c,:) = wordlist(sortedI(1:10));
end

%% Test extra-naive Bayes
T = size(X,1);
yhat = zeros(T,1); % This will be our predictions
for i = 1:T
    
    a = find(Xtest(i,:)==1); %get indices for X=1
    b = find(Xtest(i,:)==0); %get indices for X=0
    
    prob = zeros(4,1);
    for c = 1:C
        A = p_x_c(c,:);     %Array data for all P(X=1|Y=c)
        B = p_x_c_not(c,:); %Array data for all P(X=0|Y=c)
    
        %Compute P(X1=x1|Y=c)*P(X2=x2|Y=c)*...*P(X100=x100|Y=c) * P(Y=c)
        prob(c) = prod([A(a), B(b), p_y(c)]);
    end
    
    %prob = p_y; % Extra-naive Bayes method ignores the features and just uses the class prior
    [maximumProb,maximumIndex] = max(prob);
    yhat(i) = maximumIndex;
end
testError = sum(yhat ~= ytest)/T

% y_ans = classify(Xtest,X,y,'diaglinear');
% sum(y_ans ~= ytest)/size(X,1)