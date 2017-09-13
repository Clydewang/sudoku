function [solution, features] = BFS_solver(sudoku, debug)
    % BFS_solver is used to solve a sudoku and extract features from the state
    % tree.
    % Input:
    % - sudoku: a 9*9 matrix filled with 0,1-9, (0 stands for empty cell)
    % - debug:  a bool variable to control the debug output
    % Outputs:
    % - solution: the solution of input sudoku
    % - features: a vector describing the state tree
    %             >>> tree_depth: the depth of search tree;
    %             >>> num_leaves: # leaves in the search tree;
    %             >>> num_nodes: # nodes in the search tree;
    %             >>> num_forks: forks made in the search tree;
    %             >>> max_expanded: largest layer expanded in the search tree.
    if nargin<2
        debug = false;
    end
    
    % initialize solution
    solution=zeros(9);
    
    import java.util.LinkedList
    % LinkedList works like a Queue
    % .add();   and    .remove()
    num_leaves = 0;
    num_forks = 0;
    num_nodes = 0;
    possible_solutions = 0;

    current_queue = LinkedList();
    current_queue.add(sudoku);
    next_queue = LinkedList();

    nnodes_hist = zeros(1,100);

    % solve the sudoku using BFS
    for i = 1:100
        NN = current_queue.size();
        if (debug)
            fprintf('layer%i: %i nodes in this layer\n', i, NN);
        end
        nnodes_hist(i) = NN;
        num_nodes = num_nodes + NN;

        while (current_queue.size()>0)
            state = current_queue.remove();
            % get to the end of this layer
            [updated_state, r, c, choice] = fill_in_till_fork(state);

            % if no choice is provided, get to the leaf
            if (isempty(choice))
                num_leaves = num_leaves + 1;
                if check_finished(updated_state)
                    solution = updated_state;
                    possible_solutions = possible_solutions + 1;
                end
                continue;
            end

            % append 
            for j = 1:length(choice)
                updated_state(r,c) = choice(j);
                next_queue.add(updated_state);
            end
            num_forks = num_forks + length(choice);
        end
        current_queue = next_queue.clone();
        next_queue.clear();

        if (current_queue.size()==0)
            break
        end
    end
    if (debug)
        plot(nnodes_hist);
        xlabel('layer i');
        ylabel('# of nodes in layer i');
    end

    max_expanded = max(nnodes_hist);
    tree_depth = i;
    if (num_nodes-num_leaves==0)
        avg_forks_per_node = 1;
    else
        avg_forks_per_node = num_forks/(num_nodes-num_leaves);
    end
    features = [tree_depth, num_leaves, num_nodes, num_forks, avg_forks_per_node, max_expanded, possible_solutions];
end

function finished = check_finished(state)
    % when finished, the sum of numbers in cells should be 9*sum(1:9)=405.
    finished = (sum(state(:)) == 405);
end