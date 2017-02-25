[matLearn_classification_generativeNB.m](matLearn_classification_generativeNB.m)
======================================

Perform classification using Naive Bayes

## Example:

### Data
- Both feature and class label values must be `>= 0`

Training data

    X = [1, 1, 1, 1;
         1, 1, 0, 0;
         1, 1, 2, 1;
         1, 0, 1, 1;
         1, 0, 0, 0;
         1, 0, 2, 1;
         1, 0, 2, 0;
         1, 1, 1, 1];

    y = [0;
         1;
         1;
         1;
         0;
         1;
         0;
         1];

Testing data

    Xhat = [0, 1, 1, 0;
            1, 1, 2, 0];

### Step 1: Training

    >> model = matLearn_classification_generativeNB(X, y)

From example data, this step will produce

    model =
               name: 'Naive Bayes'
            classes: [2x1 double]
             priors: [2x1 containers.Map]
        likelihoods: [1x2 struct]
            predict: @predict

- To account for instances of class label values of `0`, `model.likelihoods` is indexed by `class+1`

### Step 2: Testing

    >> yhat = model.predict(model, Xhat)

From example data, this step will produce

    yhat =
         0
         1
