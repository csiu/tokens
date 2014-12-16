X = [1, 1, 1, 1;
     1, 1, 0, 0;
     1, 1, 2, 1;
     1, 0, 1, 1;
     1, 0, 0, 0;
     1, 0, 2, 1;
     1, 0, 2, 0;
     1, 1, 1, 1];

 y = [0;1;1;1;0;1;0;1];

 Xhat = [0,1,1,0;
         1,1,2,0];

model = matLearn_classification_generativeNB(X, y);
yhat = model.predict(model, Xhat);
