function [W, b] = MLR_train(X_tr, y_tr, X_val, y_val)
% the training process of multi-class logistic regression (MLR)
% Inputs:
% - X: feature data;
% - y: label data; (1-easy;2-medium;3-hard;4-expert)
% Outputs:
% - W: weight matrix (?*4);
% - b: bias term (1*4);

%% Training Setting
% learning rate
alpha = 1e-5;

% max iterations
max_iters = 200;

% debug setting
print_every = 10;

% loss history records
loss_hist = zeros(1,max_iters);

%% initialize all the parameters
weight = 1e-3;
W = randn(2,4) * weight;
b = zeros(1,4);

%% update parameters using Gradient Descent Method
% since the data set is not so big, we feed the whole set to optimizer.
for i = 1:max_iters
    % compute the scores for each label
    scores = X_tr * W + b;
    [loss, dout] = cross_entropy(scores, y_tr);
    loss_hist(i) = loss;
    
    % compute gradients
    dW = X_tr' * dout;
    db = sum(dout,1);
    
    W = W - alpha * dW;
    b = b - alpha * db;

    if mod(i,print_every)==1
        [acc_tr, acc_val] = MLR_validate(X_tr, y_tr, X_val, y_val, W, b);
        fprintf('(%d/%d)current loss: %.4f  acc_tr: %.3f  acc_val: %.3f\n',i,max_iters,loss,acc_tr,acc_val);
    end
end
plot(loss_hist);
xlabel('iterations');
ylabel('loss');
end

function [acc_tr, acc_val] = MLR_validate(X_tr, y_tr, X_val, y_val, W, b)
    pred_tr = MLR_predict(X_tr, W, b);
    acc_tr = sum(pred_tr(:)==y_tr(:))/size(X_tr,1);
    pred_val = MLR_predict(X_val, W, b);
    acc_val = sum(pred_val(:)==y_val(:))/size(X_val,1);
end