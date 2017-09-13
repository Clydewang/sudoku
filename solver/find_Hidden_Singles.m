function [updated_sudoku, r, c, choice] = fill_in_till_fork(sudoku)
    updated_sudoku = sudoku;

    % fill in all the single
    while true
        [num_choices, choices] = find_possible_fillins(updated_sudoku);
        % if there exists some cell with only one possible choice
        index = find(num_choices==1, 1);
        if (~isempty(index))
            [r, c]=ind2sub(size(num_choices),index);
            updated_sudoku(r,c) = choices{r,c}(1);
            continue
        end
        break;
    end
    % find the cell with least choices, and make a folk
    [~, index] = min(num_choices(:));
    [r, c] = ind2sub(size(num_choices), index);
    choice = choices{r,c};
end