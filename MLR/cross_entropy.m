function [loss, dx] = cross_entropy(scores, y)
% to avoid overflow, subtract the maximum from each row
shifted_logits = scores - max(scores, 2);
% compute the unnormalized probabilities
prob = exp(shifted_logits);
% compute the normalized probabilities
prob = prob ./ sum(prob, 2);
log_probs = log(prob);

% compute the cross entropy loss
N = size(log_probs,1);
index = sub2ind(size(log_probs), 1:N, y');
loss = -sum(log_probs(index))/N;

% compute the gradient
dx = prob;
dx(index) = dx(index) - 1;
dx = dx / N;
end