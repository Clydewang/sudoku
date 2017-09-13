function [X_tr, X_val, y_tr, y_val] = split_dataset(X, y, r)
    % This function is used to split dataset into training set and testing set
    % Input:
    % - r: split ratio, which equals `num_training / num_total`
    % Outputs:
    % - X_tr, y_tr: training set
    % - X_val, y_val: validation set

    if (nargin<3)
        r = 0.7;
    end

    % training set size: 4*N
    N = fix(200*r);

    X_tr=[]; X_val=[]; y_tr=[]; y_val=[];
    
    
    % it seems that we can skip "easy" ones
    y = y - 1;
    % take the log(#nodes)
    X(:,4) = log(X(:,4));
  
    for i=2:4
        rnd = randperm(200);
        tr_index = (i-1)*200 + rnd(1:N);
        val_index = (i-1)*200 + rnd(N+1:end);
        X_tr = [X_tr; X(tr_index,[2,4])];
        y_tr = [y_tr; y(tr_index)];
        X_val = [X_val; X(val_index,[2,4])];
        y_val = [y_val; y(val_index)];
    end

    % ensure each label is equally distributed
end