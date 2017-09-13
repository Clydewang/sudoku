%% data visualization
% - num_given:  the number of given cells;
% - tree_depth: the depth of the search tree;
% - num_leaves: the number of leaves (those state with no-choice cell, or
%               finished state);
% - num_nodes:  the number of nodes in the search tree NN;
% - num_forks:  the number of edges in the search tree NE;
% - avg_forks_per_node:  average forks number per non-leaf node;
% - max_expanded:        the size of maximum layer in search tree;

% Notes 1: according to Euler's rule, in the tree structure: NE=NN-1;
% Notes 2: avg_forks_per_node = num_forks / (num_nodes - num_leaves)

% load('data/BFS_features.mat');

m1 = mean(feature(1:200,:));
m2 = mean(feature(201:400,:));
m3 = mean(feature(401:600,:));
m4 = mean(feature(601:800,:));

sum(m1(1:3))
sum(m2(1:3))
sum(m3(1:3))
sum(m4(1:3))


corr = corrcoef(feature);
imagesc(abs(corr));
colormap('gray');

xticklabels({'G','S','HS','NP','HP','PP/T','B/L I','Guesses','Backtracks'})
yticklabels({'G','S','HS','NP','HP','PP/T','B/L I','Guesses','Backtracks'})
colorbar;

% yticklabels({'#G','D','#leaves','#nodes','#forks','avg forks per node','max expanded','Givens','Singles','Hidden Singles','Naked Pairs','Hidden Pairs','Pointing Pairs/Triples','Box/Line Intersections','Guesses','Backtracks'

% depth and nodes might be good indicators
% x = X(:,[2,4]);
% x(:,2) = log(x(:,2));
% scatter(x(1:200,1),x(1:200,2),'o');
% hold on;
% scatter(x(201:400,1),x(201:400,2),'*');
% scatter(x(401:600,1),x(401:600,2),'s');
% scatter(x(601:800,1),x(601:800,2),'^');
% xlabel('depth'); ylabel('log(#nodes)');
% legend('easy','medium','hard','expert') ;

