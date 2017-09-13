%% feature extraction
% extract features from given sudoku problems
% you'd better run this script is several batch
% since solving a hard problem requires much time.

% the extracted features are:
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

X = zeros(800,7);
load('data/sudoku.mat');
for i = 1:800
    sudoku = reshape(data(i,:),9,9);
    [~, features] = BFS_solver(sudoku);
    X(i,1) = sum(sudoku(:));
    X(i,2:end) = features;
    fprintf('(%d/800) preocessed',i);
end