function [model] = matLearn_classification_generativeNB(X,y,options)
% matLearn_classification_generativeNB(X,y,options)
%
% Description:
%   - Performs classification using Naive Bayes
%
% Options:
%   - None
%
% Authors:
% 	- Celia Siu (2014)
%
% Details:
%   - Both feature and class labels must be >= 0
%   - To account for instances of class=0,
%     'model.likelihoods' is indexed by 'class+1'
%

[nTrain, nFeatures] = size(X);
classes = unique(y);

priors = containers.Map;

%%% train classifier
for C = classes'
    features = struct('fclass', cell(1));

    % subset X samples by class=C
    X_c = X(ismember(y, C),:);
    nTrain_c = size(X_c,1);

    % save prior P(class=C)
    priors(int2str(C)) = nTrain_c / nTrain;

    % calculate and save P(x=X_j|class=C)
    for j = 1:nFeatures
        counter = 0;
        fclass = 0;
        while counter < nTrain_c
            fcounts = size(find(X_c(:,j)==fclass),1);
            features(j).fclass(fclass+1) = fcounts / nTrain_c;

            counter = counter + fcounts;
            fclass = fclass + 1;
        end
    end
    % note: start at C+1 for consideration of class=0
    likelihoods(C+1).features = features;
end

model.name = 'Naive Bayes';
model.classes = classes;
model.priors = priors;
model.likelihoods = likelihoods;
model.predict = @predict;

end

function [yhat] = predict(model,Xhat)
[nRow, nCol] = size(Xhat);
nClasses = size(model.classes,1);
yhat = zeros(nRow,1);

for i = 1:nRow
    posterior = zeros(1, nClasses);

    % for each class, compute P(class=C)*P(x=X_j|class=C)
    for c = 1:nClasses
        C = model.classes(c);
        p = model.priors(int2str(C));
        for j = 1:nCol
            try
                p = p * model.likelihoods(C+1).features(j).fclass(Xhat(i,j)+1);
            catch
                % for when test set feature label is not in training set
                p = p * 0;
                break
            end
        end
        posterior(c) = p;
    end
    [~,index] = max(posterior);
    yhat(i) = model.classes(index);
end

end
