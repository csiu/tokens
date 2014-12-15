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

[nTrain, nFeatures] = size(X);
classes = unique(y);

priors = containers.Map;

%%% train classifier
for C = classes'
    % subset X samples by class=C
    X_c = X(ismember(y, C),:);
    nTrain_c = size(X_c,1);
    
    % save prior P(class=C)
    priors(int2str(C)) = nTrain_c / nTrain;
    
    % calculate and save P(x=X_i|class=C) 
    for f = 1:nFeatures
        counter = 0;
        fclass = 0;
        while counter < nTrain_c
            fcounts = 0;
            for n = 1:nTrain_c
                if X_c(n,f) == fclass
                    fcounts = fcounts + 1;
                end
            end
            features(f).fclass(fclass+1) = fcounts / nTrain_c;
            
            counter = counter + fcounts;
            fclass = fclass + 1;
        end
    end
    % note: start at C+1 to include consideration of class 0
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

for r = 1:nRow
    posterior = zeros(1, nClasses);
    for c = 1:nClasses
        C = model.classes(c);
        p = model.priors(int2str(C));
        for f = 1:nCol
            try
                p = p * model.likelihoods(C+1).features(f).fclass(Xhat(r,f)+1);
            catch
                % for when feature class of test set is not in training set
                p = p * 0;
            end
        end
        posterior(c) = p;
    end
    [~,i] = max(posterior);
    yhat(r) = model.classes(i);
end

end
