%% Load Data
load('data.mat') % Loads {X,y,Xtest,ytest,groupnames,wordlist}
[N,P] = size(X);
T = size(Xtest,1);

% Compute distance metrics
D = X.^2*ones(P,T) + ones(N,P)*(Xtest').^2 - 2*X*Xtest';

%% K-Nearest Neighbour
% k = 10;
% 
% [sortedD,sortedD_ind] = sort(D,1);
% yhat = zeros(T,1);
% k_nearest_ind = sortedD_ind(1:k,:);
% k_nearest_class = y(k_nearest_ind);
% yhat = mode(k_nearest_class)';
% 
% testError = sum(yhat ~= ytest)/T

K = 10;
testErrors = zeros(K,2);
for k = 1:K
    [sortedD,sortedD_ind] = sort(D,1);
    yhat = zeros(T,1);
    k_nearest_ind = sortedD_ind(1:k,:);
    k_nearest_class = y(k_nearest_ind);
    yhat = mode(k_nearest_class)';

    testError = sum(yhat ~= ytest)/T;
    testErrors(k,:) = [k, testError];
end
testErrors