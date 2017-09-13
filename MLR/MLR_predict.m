function y_pred = MLR_predict(X, W, b)
    % this function is used for predicting the unknown data.
    scores = X * W + b;
    [~,y_pred] = max(scores,[],2);
end